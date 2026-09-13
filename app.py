"""
Auto-Timetable - Main Application File
----------------------------------------
Computer Science Department Timetable Management System
Moshood Abiola Polytechnic (MAPOLY)

This file contains every route (page/URL) in the app.
"""

from flask import Flask, render_template, request, redirect, session
from database import connection, cursor
from functools import wraps
from werkzeug.security import generate_password_hash, check_password_hash
import csv
import io
import os
from dotenv import load_dotenv

load_dotenv()  # reads the .env file and loads its values into the environment

app = Flask(__name__)

# This secret key is needed so Flask can safely remember who is logged in.
# It's stored in .env (not committed to GitHub) rather than hardcoded here.
app.secret_key = os.getenv("SECRET_KEY")


# ============================================================
# ACCESS CONTROL
# ============================================================

# Checks if a user is logged in AND has the correct role before
# letting them see a page. Admins are always let through, no matter
# which role a page was built for.
def login_required(role):

    def login_validation(f):

        @wraps(f)  # keeps the real function name, so Flask doesn't get confused
        def guard(*args, **kwargs):

            # Not logged in at all -> send to login page
            if "username" not in session:
                return redirect("/login")

            # Logged in, but wrong role, and not an Admin -> also blocked
            if session["role"] != role and session["role"] != "Admin":
                return redirect("/login")

            # Passed both checks -> let them see the real page
            return f(*args, **kwargs)

        return guard

    return login_validation


# ============================================================
# PUBLIC PAGES
# ============================================================

# Home page - anyone can see this, no login needed
@app.route("/")
def home():
    return render_template("index.html")


# Login page - shows the form (GET) and checks the login details (POST)
@app.route("/login", methods=["GET", "POST"])
def login():

    # If someone is already logged in and visits /login again,
    # skip the form and send them straight to their dashboard
    if "username" in session:
        if session["role"] == "Admin":
            return redirect("/admin")
        elif session["role"] == "Lecturer":
            return redirect("/lecturer")
        elif session["role"] == "Student":
            return redirect("/student")

    if request.method == "POST":

        username = request.form["username"]
        password = request.form["password"]

        # Look up this username in the database
        cursor.execute(
            "SELECT username, password, role FROM users WHERE username = ?",
            (username,)
        )
        user = cursor.fetchone()

        if user:
            # check_password_hash compares the typed password against the
            # scrambled (hashed) password stored in the database
            if check_password_hash(user[1], password):

                # Remember this user is logged in, and what role they have
                session["username"] = user[0]
                session["role"] = user[2]

                # Send them to the correct dashboard for their role
                if user[2] == "Admin":
                    return redirect("/admin")
                elif user[2] == "Lecturer":
                    return redirect("/lecturer")
                elif user[2] == "Student":
                    return redirect("/student")

            else:
                return render_template("login.html", message="Wrong Password")

        else:
            return render_template("login.html", message="User Not Found")

    # If it's just a normal visit (GET), show the empty login form
    return render_template("login.html", message="")


# Logs the user out by clearing everything in their session
@app.route("/logout")
def logout():
    session.clear()
    return redirect("/login")


# ============================================================
# TIMETABLE GRID HELPER
# ============================================================

# Takes a plain list of classes and arranges them into a
# day + time-slot grid, like a weekly timetable on a wall.
# Used by both /student and /timetable/grid.
def build_timetable_grid(all_classes):
    days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    time_slots = [
        ("08:00:00", "10:00:00"),
        ("10:00:00", "12:00:00"),
        ("12:00:00", "14:00:00"),
        ("14:00:00", "16:00:00"),
    ]

    # Start with every day/time slot empty
    grid = {}
    for day in days:
        for slot in time_slots:
            grid[(day, slot)] = None

    # Now fill in the slots that actually have a class scheduled
    for class_row in all_classes:
        course_code, session_type, day, start_time, end_time, venue, lecturer_name, lecturer_title = class_row
        # start_time/end_time come back from the database as timedelta objects,
        # so we turn them into plain text to match our time_slots list above
        start_str = str(start_time)
        end_str = str(end_time)
        grid[(day, (start_str, end_str))] = class_row

    return grid, days, time_slots


# ============================================================
# STUDENT
# ============================================================

# Shows the logged-in student's timetable as a day x time-slot grid,
# filtered to their own level. A dropdown lets them switch levels too.
@app.route("/student")
@login_required("Student")
def student_dashboard():
    username = session["username"]

    cursor.execute("SELECT level FROM users WHERE username = ?", (username,))
    student = cursor.fetchone()
    student_level = student[0]

    selected_level = request.args.get("level", student_level)

    cursor.execute(
        """SELECT course_code, session_type, day, start_time, end_time,
                  venue, lecturer_name, lecturer_title
           FROM timetable WHERE level = ?""",
        (selected_level,)
    )
    all_classes = cursor.fetchall()

    grid, days, time_slots = build_timetable_grid(all_classes)

    return render_template(
        "student.html",
        username=username,
        grid=grid,
        days=days,
        time_slots=time_slots,
        selected_level=selected_level
    )


# ============================================================
# LECTURER
# ============================================================

# Shows only the classes that belong to the logged-in lecturer
@app.route("/lecturer")
@login_required("Lecturer")
def lecturer_dashboard():
    username = session["username"]

    # Get this lecturer's real name, so we can match it against the timetable
    cursor.execute("SELECT full_name FROM users WHERE username = ?", (username,))
    lecturer = cursor.fetchone()
    lecturer_name = lecturer[0]

    cursor.execute(
        """SELECT course_code, session_type, level, day, start_time, end_time,
                  venue, lecturer_title
           FROM timetable WHERE lecturer_name = ?""",
        (lecturer_name,)
    )
    all_classes = cursor.fetchall()

    return render_template(
        "lecturer.html",
        username=username,
        lecturer_name=lecturer_name,
        all_classes=all_classes
    )


# Saves a comment written by a lecturer. Only Admins can read these.
@app.route("/lecturer/comment", methods=["POST"])
@login_required("Lecturer")
def post_comment():
    username = session["username"]
    message = request.form["message"]

    cursor.execute(
        "INSERT INTO comments (lecturer_username, message) VALUES (?, ?)",
        (username, message)
    )
    connection.commit()

    return redirect("/lecturer")


# ============================================================
# SEARCH (shared - works for any logged-in user, any role)
# ============================================================

# Lets any logged-in user search the timetable by lecturer name
@app.route("/search")
def search_lecturer():
    if "username" not in session:
        return redirect("/login")

    query = request.args.get("query", "")

    cursor.execute(
        """SELECT course_code, session_type, level, day, start_time, end_time,
                  venue, lecturer_name, lecturer_title
           FROM timetable WHERE lecturer_name LIKE ?""",
        (f"%{query}%",)  # the % signs mean "match anywhere in the text"
    )
    results = cursor.fetchall()

    return render_template("search.html", results=results, query=query)


# Lets any logged-in user search the timetable by course code
@app.route("/search/course")
def search_course():
    if "username" not in session:
        return redirect("/login")

    query = request.args.get("query", "")

    cursor.execute(
        """SELECT course_code, session_type, level, day, start_time, end_time,
                  venue, lecturer_name, lecturer_title
           FROM timetable WHERE course_code LIKE ?""",
        (f"%{query}%",)
    )
    results = cursor.fetchall()

    return render_template("search_course.html", results=results, query=query)


# ============================================================
# WEEKLY GRID VIEW (view any level's timetable, not just your own)
# ============================================================

@app.route("/timetable/grid")
def timetable_grid():
    if "username" not in session:
        return redirect("/login")

    # Default to ND2 if no level was chosen in the URL
    level = request.args.get("level", "ND2")

    cursor.execute(
        """SELECT course_code, session_type, day, start_time, end_time,
                  venue, lecturer_name, lecturer_title
           FROM timetable WHERE level = ?""",
        (level,)
    )
    all_classes = cursor.fetchall()

    grid, days, time_slots = build_timetable_grid(all_classes)

    return render_template(
        "timetable_grid.html",
        grid=grid,
        days=days,
        time_slots=time_slots,
        level=level
    )


# ============================================================
# ADMIN - DASHBOARD
# ============================================================

# Admin's landing page - shows quick numbers and shortcuts
@app.route("/admin")
@login_required("Admin")
def admin_dashboard():
    username = session["username"]

    # Count how many users, timetable entries, and comments exist,
    # just to display as quick stats on the dashboard
    cursor.execute("SELECT COUNT(*) FROM users")
    total_users = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM timetable")
    total_classes = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM comments")
    total_comments = cursor.fetchone()[0]

    return render_template(
        "admin.html",
        username=username,
        total_users=total_users,
        total_classes=total_classes,
        total_comments=total_comments
    )


# ============================================================
# ADMIN - USER MANAGEMENT
# ============================================================

# Creates a new Student, Lecturer, or Admin account (one at a time)
@app.route("/admin/register", methods=["GET", "POST"])
@login_required("Admin")
def register_user():
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]
        full_name = request.form["full_name"]
        email = request.form["email"]
        role = request.form["role"]
        level = request.form["level"]

        # Never save the real password - scramble it first
        hashed_password = generate_password_hash(password)

        # Check if this username is already taken, so we don't crash
        # the database with a duplicate entry
        cursor.execute("SELECT id FROM users WHERE username = ?", (username,))
        existing_user = cursor.fetchone()

        if existing_user:
            return render_template("register.html", message="Username already taken")

        cursor.execute(
            """INSERT INTO users (username, password, role, full_name, email, level)
               VALUES (?, ?, ?, ?, ?, ?)""",
            (username, hashed_password, role, full_name, email, level)
        )
        connection.commit()

        return redirect("/admin/users")

    # If it's just a visit (GET), show the empty registration form
    return render_template("register.html", message="")


# Creates MANY accounts at once from an uploaded CSV file.
# Expected columns: username, password, full_name, email, level, role, programme
@app.route("/admin/bulk-register", methods=["GET", "POST"])
@login_required("Admin")
def bulk_register():
    if request.method == "POST":
        uploaded_file = request.files["csv_file"]

        # Read the uploaded file as text
        file_contents = uploaded_file.read().decode("utf-8")
        csv_reader = csv.DictReader(io.StringIO(file_contents))

        added = 0
        skipped = 0

        for row in csv_reader:
            username = row["username"]
            password = row["password"]
            full_name = row["full_name"]
            email = row.get("email", "")
            level = row.get("level", "")
            role = row.get("role", "Student")
            programme = row.get("programme", "")

            if programme == "":
                programme = None

            # Skip if this username already exists
            cursor.execute("SELECT id FROM users WHERE username = ?", (username,))
            existing = cursor.fetchone()

            if existing:
                skipped += 1
                continue

            hashed_password = generate_password_hash(password)

            cursor.execute(
                """INSERT INTO users (username, password, role, full_name, email, level, programme)
                   VALUES (?, ?, ?, ?, ?, ?, ?)""",
                (username, hashed_password, role, full_name, email, level, programme)
            )
            added += 1

        connection.commit()

        return render_template(
            "bulk_register.html",
            message=f"Added {added} users, skipped {skipped} duplicates."
        )

    return render_template("bulk_register.html", message="")


# Shows every user in the system, with Edit/Delete links for each
@app.route("/admin/users")
@login_required("Admin")
def manage_users():
    cursor.execute("SELECT id, username, full_name, role, email FROM users")
    all_users = cursor.fetchall()

    return render_template("users.html", all_users=all_users)


# Deletes one specific user, chosen by their ID number
@app.route("/admin/delete/<int:user_id>")
@login_required("Admin")
def delete_user(user_id):
    cursor.execute("DELETE FROM users WHERE id = ?", (user_id,))
    connection.commit()

    return redirect("/admin/users")


# Shows a pre-filled edit form (GET), or saves the changes (POST)
@app.route("/admin/edit/<int:user_id>", methods=["GET", "POST"])
@login_required("Admin")
def edit_user(user_id):

    if request.method == "POST":
        username = request.form["username"]
        full_name = request.form["full_name"]
        role = request.form["role"]
        email = request.form["email"]
        level = request.form["level"]

        cursor.execute(
            """UPDATE users SET username = ?, full_name = ?, email = ?,
                                role = ?, level = ? WHERE id = ?""",
            (username, full_name, email, role, level, user_id)
        )
        connection.commit()

        return redirect("/admin/users")

    # GET request - fetch the current details for this user, to show in the form
    cursor.execute(
        "SELECT id, username, full_name, role, email, level FROM users WHERE id = ?",
        (user_id,)
    )
    user = cursor.fetchone()

    return render_template("edit.html", user=user)


# ============================================================
# ADMIN - TIMETABLE MANAGEMENT
# ============================================================

# Shows every timetable entry in a flat list, with Edit/Delete for each
@app.route("/admin/timetable")
@login_required("Admin")
def manage_timetable():
    cursor.execute(
        """SELECT id, course_code, session_type, programme, level, day,
                  start_time, end_time, venue, lecturer_name, lecturer_title
           FROM timetable ORDER BY level, day"""
    )
    all_classes = cursor.fetchall()

    return render_template("timetable.html", all_classes=all_classes)


# Adds a brand new class/session to the timetable
@app.route("/admin/timetable/add", methods=["GET", "POST"])
@login_required("Admin")
def add_class():
    if request.method == "POST":
        course_code = request.form["course_code"]
        session_type = request.form["session_type"]
        programme = request.form["programme"]  # blank for ND1/ND2, since they have no programme split
        level = request.form["level"]
        day = request.form["day"]
        start_time = request.form["start_time"]
        end_time = request.form["end_time"]
        venue = request.form["venue"]
        lecturer_name = request.form["lecturer_name"]
        lecturer_title = request.form["lecturer_title"]

        # Store nothing (NULL) instead of an empty string when there's no programme
        if programme == "":
            programme = None

        cursor.execute(
            """INSERT INTO timetable (course_code, session_type, programme, level,
                                       day, start_time, end_time, venue,
                                       lecturer_name, lecturer_title)
               VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)""",
            (course_code, session_type, programme, level, day,
             start_time, end_time, venue, lecturer_name, lecturer_title)
        )
        connection.commit()

        return redirect("/admin/timetable")

    return render_template("add_class.html")


# Deletes one specific timetable entry, chosen by its ID number
@app.route("/admin/timetable/delete/<int:class_id>")
@login_required("Admin")
def delete_class(class_id):
    cursor.execute("DELETE FROM timetable WHERE id = ?", (class_id,))
    connection.commit()

    return redirect("/admin/timetable")


# Shows a pre-filled edit form (GET), or saves the changes (POST)
@app.route("/admin/timetable/edit/<int:class_id>", methods=["GET", "POST"])
@login_required("Admin")
def edit_class(class_id):

    if request.method == "POST":
        course_code = request.form["course_code"]
        session_type = request.form["session_type"]
        programme = request.form["programme"]
        level = request.form["level"]
        day = request.form["day"]
        start_time = request.form["start_time"]
        end_time = request.form["end_time"]
        venue = request.form["venue"]
        lecturer_name = request.form["lecturer_name"]
        lecturer_title = request.form["lecturer_title"]

        if programme == "":
            programme = None

        cursor.execute(
            """UPDATE timetable SET course_code = ?, session_type = ?, programme = ?,
                                    level = ?, day = ?, start_time = ?, end_time = ?,
                                    venue = ?, lecturer_name = ?, lecturer_title = ?
               WHERE id = ?""",
            (course_code, session_type, programme, level, day,
             start_time, end_time, venue, lecturer_name, lecturer_title, class_id)
        )
        connection.commit()

        return redirect("/admin/timetable")

    # GET request - fetch this class's current details, to show in the form
    cursor.execute(
        """SELECT id, course_code, session_type, programme, level, day,
                  start_time, end_time, venue, lecturer_name, lecturer_title
           FROM timetable WHERE id = ?""",
        (class_id,)
    )
    class_data = cursor.fetchone()

    # Tuples can't be changed directly, so turn this into a list first
    class_data = list(class_data)

    # start_time (position 6) comes back as a timedelta - turn it into
    # plain "HH:MM" text so it matches the dropdown options in the form
    total_seconds_start = class_data[6].total_seconds()
    hours_start = int(total_seconds_start // 3600)
    minutes_start = int((total_seconds_start % 3600) // 60)
    class_data[6] = f"{hours_start:02d}:{minutes_start:02d}"

    # Same conversion for end_time (position 7)
    total_seconds_end = class_data[7].total_seconds()
    hours_end = int(total_seconds_end // 3600)
    minutes_end = int((total_seconds_end % 3600) // 60)
    class_data[7] = f"{hours_end:02d}:{minutes_end:02d}"

    # programme might be empty (None) in the database - change it to an
    # empty string so the "N/A" option in the form pre-selects correctly
    if class_data[3] is None:
        class_data[3] = ""

    return render_template("edit_class.html", class_data=class_data)


# ============================================================
# ADMIN - TIMETABLE AUTO-GENERATION
# ============================================================

def generate_timetable(level, programme=None):
    """
    Attempts to build a conflict-free timetable for one level (and
    programme, if applicable) using the lecturers, venues, and course
    requirements already stored in the database.

    Returns a list of newly created timetable rows, or an error
    message (as a string) if something couldn't be scheduled.
    """
    days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    time_slots = [
        ("08:00:00", "10:00:00"),
        ("10:00:00", "12:00:00"),
        ("12:00:00", "14:00:00"),
        ("14:00:00", "16:00:00"),
    ]

    # Get every course that needs to be scheduled for this level
    cursor.execute(
        "SELECT course_code, lectures_per_week, practicals_per_week FROM course_requirements WHERE level = ?",
        (level,)
    )
    courses = cursor.fetchall()

    # Get all venues, split by type
    cursor.execute("SELECT name, venue_type FROM venues")
    all_venues = cursor.fetchall()
    lecture_rooms = [v[0] for v in all_venues if v[1] == "Lecture Room"]
    labs = [v[0] for v in all_venues if v[1] == "Lab"]

    # These sets keep track of what's already been booked, so we don't double-book
    booked_lecturer_slots = set()   # (lecturer_name, day, start_time)
    booked_venue_slots = set()      # (venue, day, start_time)
    booked_level_slots = set()      # (day, start_time) - the level can't be in two places at once

    new_schedule = []   # the rows we successfully schedule

    # Try to schedule every course, one at a time
    for course_code, lectures_needed, practicals_needed in courses:

        # Find which lecturer(s) can teach this course
        cursor.execute(
            """SELECT lecturers.full_name, lecturers.title
               FROM lecturer_courses
               JOIN lecturers ON lecturer_courses.lecturer_id = lecturers.id
               WHERE lecturer_courses.course_code = ?""",
            (course_code,)
        )
        possible_lecturers = cursor.fetchall()

        if not possible_lecturers:
            return f"No lecturer found for {course_code} - please add one first."

        # Schedule the required number of lecture and practical sessions
        sessions_to_book = [("Lecture", lecture_rooms)] * lectures_needed + [("Practical", labs)] * practicals_needed

        for session_type, valid_venues in sessions_to_book:
            scheduled = False

            # Try every day and time slot until we find one that works
            for day in days:
                if scheduled:
                    break
                for start_time, end_time in time_slots:
                    if scheduled:
                        break

                    # The level can't have two classes at the same time
                    if (day, start_time) in booked_level_slots:
                        continue

                    # Try each lecturer who can teach this course
                    for lecturer_name, lecturer_title in possible_lecturers:
                        if (lecturer_name, day, start_time) in booked_lecturer_slots:
                            continue

                        # Try each venue of the right type (Lecture Room or Lab)
                        for venue in valid_venues:
                            if (venue, day, start_time) in booked_venue_slots:
                                continue

                            # Found a valid combination - book it
                            booked_lecturer_slots.add((lecturer_name, day, start_time))
                            booked_venue_slots.add((venue, day, start_time))
                            booked_level_slots.add((day, start_time))

                            new_schedule.append((
                                course_code, session_type, programme, level,
                                day, start_time, end_time, venue,
                                lecturer_name, lecturer_title
                            ))

                            scheduled = True
                            break
                        if scheduled:
                            break

            if not scheduled:
                return f"Could not find a free slot for {course_code} ({session_type}) - try adding more venues or lecturers."

    return new_schedule


# Uses generate_timetable() above to build a schedule and save it into the
# real timetable table, replacing any existing entries for that level
@app.route("/admin/timetable/generate", methods=["GET", "POST"])
@login_required("Admin")
def generate_timetable_route():
    if request.method == "POST":
        level = request.form["level"]
        programme = request.form["programme"]
        if programme == "":
            programme = None

        result = generate_timetable(level, programme)

        # If generate_timetable() returned a string, that's an error message, not a schedule
        if isinstance(result, str):
            return render_template("generate_timetable.html", message=result)

        # Remove any existing timetable entries for this level, so we don't get duplicates
        cursor.execute("DELETE FROM timetable WHERE level = ?", (level,))

        # Insert every newly generated row
        for row in result:
            cursor.execute(
                """INSERT INTO timetable (course_code, session_type, programme, level,
                                           day, start_time, end_time, venue,
                                           lecturer_name, lecturer_title)
                   VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)""",
                row
            )
        connection.commit()

        return redirect("/admin/timetable")

    return render_template("generate_timetable.html", message="")


# ============================================================
# ADMIN - COMMENTS
# ============================================================

# Shows every comment submitted by lecturers, newest first
@app.route("/admin/comments")
@login_required("Admin")
def view_comments():
    cursor.execute(
        "SELECT lecturer_username, message, created_at FROM comments ORDER BY created_at DESC"
    )
    all_comments = cursor.fetchall()

    return render_template("comments.html", all_comments=all_comments)


# ============================================================
# START THE APP
# ============================================================

if __name__ == "__main__":
    app.run(debug=True)