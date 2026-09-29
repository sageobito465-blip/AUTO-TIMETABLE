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

load_dotenv()


# ============================================================
# COURSE TITLES
# ============================================================

COURSE_TITLES = {

    # ND1 First Semester
    "COM111": "Introduction to Computing",
    "COM112": "Introduction to Digital Electronics",
    "COM113": "Introduction to Programming",
    "COM114": "Statistics for Computing 1",
    "COM115": "Computer Application Packages I",
    "GNS101": "Use of English I",
    "GNS111": "Citizenship Education I",
    "MTH111": "Logic and Linear Algebra",

    # ND1 Second Semester
    "COM121": "Programming using C Language",
    "COM122": "Introduction to Internet",
    "COM123": "Programming Language using Java I",
    "COM124": "Data Structure and Algorithms",
    "COM125": "Introduction to Systems Analysis and Design",
    "COM126": "PC Upgrade & Maintenance",
    "ENT126": "Introduction to Entrepreneurship I",
    "GNS102": "Communication in English",
    "GNS121": "Citizenship Education II",
    "GNS228": "Research Methods",


    # ND2 First Semester
    "COM211": "Programming Language using Java II",
    "COM212": "Introduction to Systems Programming",
    "COM213": "Unified Modelling Language (UML)",
    "COM214": "Computer Systems Troubleshooting",
    "COM215": "Computer Application Packages II",
    "COM216": "Statistics for Computing II",
    "SIW219": "SIWES",
    "GNS201": "Use of English II",
    "EED216": "Practice of Entrepreneurship",

    # ND2 Second Semester
    "COM221": "Basic Computer Networking",
    "COM222": "Seminar on Computer and Society",
    "COM223": "Basic Hardware Maintenance",
    "COM224": "Management Information System",
    "COM225": "Web Technology",
    "COM226": "File Organisation and Management",
    "GNS204": "Communication in English II",
    "COM227": "Project",

    # HND2 First Semester
    "COM411": "Web Development (PHP)",
    "COM412": "Project Management",
    "COM413": "Compiler Construction",
    "COM414": "Data Communication and Networks",
    "COM415": "Multimedia",
    "GNS401": "Communication in English IV",
    "EED413": "Entrepreneurship Development",

    # HND2 Second Semester
    "COM422": "Computer Graphics and Animation",
    "COM423": "Expert Systems and Machine Learning",
    "COM424": "Ethical and Professional Practice in IT",
    "COM425": "Seminar on Emerging Technologies",
    "COM426": "Computer Security",
    "COM429": "Project",
}

app = Flask(__name__)

app.secret_key = os.getenv("SECRET_KEY")


# ============================================================
# ACCESS CONTROL
# ============================================================

def login_required(*role):

    def login_validation(f):

        @wraps(f)
        def guard(*args, **kwargs):

            if "username" not in session:
                return redirect("/login")

            if session["role"] not in role and session["role"] != "Admin":
                return redirect("/login")

            return f(*args, **kwargs)

        return guard

    return login_validation

# ============================================================
# PUBLIC PAGES
# ============================================================

@app.route("/")
def home():

    return render_template("index.html")


@app.route("/login", methods=["GET", "POST"])
def login():

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

        cursor.execute(
            "SELECT username, password, role FROM users WHERE username = ?",
            (username,)
        )

        user = cursor.fetchone()

        if user:

            if check_password_hash(user[1], password):

                session["username"] = user[0]
                session["role"] = user[2]

                if user[2] == "Admin":
                    return redirect("/admin")

                elif user[2] == "Lecturer":
                    return redirect("/lecturer")

                elif user[2] == "Student":
                    return redirect("/student")

            else:

                return render_template(
                    "login.html",
                    message="Wrong Password"
                )

        else:

            return render_template(
                "login.html",
                message="User Not Found"
            )

    return render_template(
        "login.html",
        message=""
    )


@app.route("/logout")
def logout():

    session.clear()

    return redirect("/login")


# ============================================================
# TIMETABLE GRID HELPER
# ============================================================

def build_timetable_grid(all_classes):

    days = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday"
    ]

    time_slots = [
        ("08:00:00", "10:00:00"),
        ("10:00:00", "12:00:00"),
        ("12:00:00", "14:00:00"),
        ("14:00:00", "16:00:00"),
    ]

    grid = {}

    for day in days:

        for slot in time_slots:

            grid[(day, slot)] = None

    for class_row in all_classes:

        course_code, session_type, day, start_time, end_time, venue, lecturer_name, lecturer_title = class_row

        start_str = str(start_time).zfill(8)
        end_str = str(end_time).zfill(8)

        grid[(day, (start_str, end_str))] = class_row

    return grid, days, time_slots


# ============================================================
# ACCOUNT
# ============================================================

@app.route("/change-password", methods=["GET", "POST"])
def change_password():

    if "username" not in session:
        return redirect("/login")

    if request.method == "POST":

        current_password = request.form["current_password"]
        new_password = request.form["new_password"]
        confirm_password = request.form["confirm_password"]

        username = session["username"]

        cursor.execute(
            "SELECT password FROM users WHERE username = ?",
            (username,)
        )

        user = cursor.fetchone()

        if not check_password_hash(user[0], current_password):

            return render_template(
                "change_password.html",
                message="Current password is incorrect"
            )

        if new_password != confirm_password:

            return render_template(
                "change_password.html",
                message="New passwords do not match"
            )

        hashed_password = generate_password_hash(new_password)

        cursor.execute(
            "UPDATE users SET password = ? WHERE username = ?",
            (hashed_password, username)
        )

        connection.commit()

        return render_template(
            "change_password.html",
            message="Password changed successfully!"
        )

    return render_template(
        "change_password.html",
        message=""
    )


# ============================================================
# STUDENT
# ============================================================

@app.route("/student")
@login_required("Student")
def student_dashboard():

    username = session["username"]

    cursor.execute(
        "SELECT level, programme FROM users WHERE username = ?",
        (username,)
    )

    student = cursor.fetchone()

    student_level = student[0]
    student_programme = student[1]

    selected_level = request.args.get(
        "level",
        student_level
    )

    selected_programme = request.args.get(
        "programme",
        student_programme
    )
    selected_semester = request.args.get(
        "semester",
        "Semester 1"
    )

    if selected_programme:

        cursor.execute(
            """SELECT course_code, session_type, day, start_time, end_time,
                      venue, lecturer_name, lecturer_title
               FROM timetable
               WHERE level = ?
               AND programme = ?
               AND semester = ?""",
            (
                selected_level,
                selected_programme,
                selected_semester
            )
        )

    else:

        cursor.execute(
            """SELECT course_code, session_type, day, start_time, end_time,
                      venue, lecturer_name, lecturer_title
               FROM timetable
               WHERE level = ?
               AND semester = ?""",
            (
                selected_level,
                selected_semester
            )
        )

    all_classes = cursor.fetchall()

    grid, days, time_slots = build_timetable_grid(all_classes)

    return render_template(
        "student.html",
        username=username,
        grid=grid,
        days=days,
        time_slots=time_slots,
        selected_level=selected_level,
        selected_programme=selected_programme,
        selected_semester=selected_semester
    )


# ============================================================
# LECTURER
# ============================================================

@app.route("/lecturer")
@login_required("Lecturer")
def lecturer_dashboard():

    username = session["username"]

    cursor.execute(
        "SELECT full_name FROM users WHERE username = ?",
        (username,)
    )

    lecturer = cursor.fetchone()

    lecturer_name = lecturer[0]

    cursor.execute(
        """SELECT course_code, session_type, level, day, start_time, end_time,
                  venue, lecturer_title
           FROM timetable
           WHERE lecturer_name LIKE ?""",
        (f"%{lecturer_name}%",)
    )

    all_classes = cursor.fetchall()

    return render_template(
        "lecturer.html",
        username=username,
        lecturer_name=lecturer_name,
        all_classes=all_classes,
        course_titles=COURSE_TITLES
    )


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
# SEARCH
# ============================================================

@app.route("/search")
def search_lecturer():

    if "username" not in session:
        return redirect("/login")

    query = request.args.get("query", "")

    cursor.execute(
        """SELECT course_code, session_type, level, day, start_time, end_time,
                  venue, lecturer_name
           FROM timetable
           WHERE lecturer_name LIKE ?""",
        (f"%{query}%",)
    )

    results = []

    for row in cursor.fetchall():

        course_code = row[0]

        course_title = COURSE_TITLES.get(
            course_code,
            "Unknown Course"
        )

        results.append(row + (course_title,))

    return render_template(
        "search.html",
        results=results,
        query=query
    )




@app.route("/search/course")
def search_course():

    if "username" not in session:
        return redirect("/login")

    query = request.args.get("query", "").strip()

    matching_courses = set()

    # Search course codes in the timetable
    cursor.execute(
        """SELECT DISTINCT course_code
           FROM timetable
           WHERE course_code LIKE ?""",
        (f"%{query}%",)
    )

    for row in cursor.fetchall():
        matching_courses.add(row[0])

    # Search course titles
    for course_code, course_title in COURSE_TITLES.items():
        if query.lower() in course_title.lower():
            matching_courses.add(course_code)

    results = []

    for course_code in matching_courses:

        cursor.execute(
            """SELECT course_code, session_type, level, day,
                      start_time, end_time, venue,
                      lecturer_name, lecturer_title
               FROM timetable
               WHERE course_code = ?""",
            (course_code,)
        )

        for row in cursor.fetchall():

            course_title = COURSE_TITLES.get(
                course_code,
                "Unknown Course"
            )

            results.append(
                row + (course_title,)
            )

    return render_template(
        "search_course.html",
        results=results,
        query=query
    )





# ============================================================
# WEEKLY GRID VIEW
# ============================================================

@app.route("/timetable/grid")
def timetable_grid():

    if "username" not in session:
        return redirect("/login")

    level = request.args.get("level", "ND2")

    cursor.execute(
        """SELECT course_code, session_type, day, start_time, end_time,
                  venue, lecturer_name, lecturer_title
           FROM timetable
           WHERE level = ?""",
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

@app.route("/admin")
@login_required("Admin")
def admin_dashboard():

    username = session["username"]

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

        if password.strip() == "":

            return render_template(
                "register.html",
                message="Password cannot be empty"
            )

        hashed_password = generate_password_hash(password)

        cursor.execute(
            "SELECT id FROM users WHERE username = ?",
            (username,)
        )

        existing_user = cursor.fetchone()

        if existing_user:

            return render_template(
                "register.html",
                message="Username already taken"
            )

        cursor.execute(
            """INSERT INTO users
               (username, password, role, full_name, email, level)
               VALUES (?, ?, ?, ?, ?, ?)""",
            (
                username,
                hashed_password,
                role,
                full_name,
                email,
                level
            )
        )

        connection.commit()

        return redirect("/admin/users")

    return render_template(
        "register.html",
        message=""
    )


@app.route("/admin/bulk-register", methods=["GET", "POST"])
@login_required("Admin")
def bulk_register():

    if request.method == "POST":

        uploaded_file = request.files["csv_file"]

        file_contents = uploaded_file.read().decode("utf-8")

        csv_reader = csv.DictReader(
            io.StringIO(file_contents)
        )

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

            if username.strip() == "" or password.strip() == "":

                skipped += 1
                continue

            cursor.execute(
                "SELECT id FROM users WHERE username = ?",
                (username,)
            )

            existing = cursor.fetchone()

            if existing:

                skipped += 1
                continue

            hashed_password = generate_password_hash(password)

            cursor.execute(
                """INSERT INTO users
                   (username, password, role, full_name, email, level, programme)
                   VALUES (?, ?, ?, ?, ?, ?, ?)""",
                (
                    username,
                    hashed_password,
                    role,
                    full_name,
                    email,
                    level,
                    programme
                )
            )

            added += 1

        connection.commit()

        return render_template(
            "bulk_register.html",
            message=f"Added {added} users, skipped {skipped} duplicates or invalid rows."
        )

    return render_template(
        "bulk_register.html",
        message=""
    )


@app.route("/admin/users")
@login_required("Admin")
def manage_users():

    cursor.execute(
        "SELECT id, username, full_name, role, email FROM users"
    )

    all_users = cursor.fetchall()

    return render_template(
        "users.html",
        all_users=all_users
    )


@app.route("/admin/delete/<int:user_id>")
@login_required("Admin")
def delete_user(user_id):

    cursor.execute(
        "DELETE FROM users WHERE id = ?",
        (user_id,)
    )

    connection.commit()

    return redirect("/admin/users")


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
            """UPDATE users
               SET username = ?, full_name = ?, email = ?,
                   role = ?, level = ?
               WHERE id = ?""",
            (
                username,
                full_name,
                email,
                role,
                level,
                user_id
            )
        )

        connection.commit()

        return redirect("/admin/users")

    cursor.execute(
        """SELECT id, username, full_name, role, email, level
           FROM users
           WHERE id = ?""",
        (user_id,)
    )

    user = cursor.fetchone()

    return render_template(
        "edit.html",
        user=user
    )


# ============================================================
# ADMIN - TIMETABLE MANAGEMENT
# ============================================================

@app.route("/admin/timetable")
@login_required("Admin")
def manage_timetable():

    cursor.execute(
        """SELECT id, course_code, session_type, programme, level, semester,
                  day, start_time, end_time, venue, lecturer_name, lecturer_title
           FROM timetable
           ORDER BY level, semester, day"""
    )

    all_classes = cursor.fetchall()

    return render_template(
        "timetable.html",
        all_classes=all_classes
    )


@app.route("/admin/timetable/add", methods=["GET", "POST"])
@login_required("Admin")
def add_class():

    if request.method == "POST":

        course_code = request.form["course_code"]
        session_type = request.form["session_type"]
        programme = request.form["programme"]
        level = request.form["level"]
        semester = request.form["semester"]
        day = request.form["day"]
        start_time = request.form["start_time"]
        end_time = request.form["end_time"]
        venue = request.form["venue"]
        lecturer_name = request.form["lecturer_name"]
        lecturer_title = request.form["lecturer_title"]

        if programme == "":
            programme = None

        cursor.execute(
            """INSERT INTO timetable
               (course_code, session_type, programme, level, semester,
                day, start_time, end_time, venue,
                lecturer_name, lecturer_title)
               VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)""",
            (
                course_code,
                session_type,
                programme,
                level,
                semester,
                day,
                start_time,
                end_time,
                venue,
                lecturer_name,
                lecturer_title
            )
        )

        connection.commit()

        return redirect("/admin/timetable")

    return render_template("add_class.html")


@app.route("/admin/timetable/delete/<int:class_id>")
@login_required("Admin")
def delete_class(class_id):

    cursor.execute(
        "DELETE FROM timetable WHERE id = ?",
        (class_id,)
    )

    connection.commit()

    return redirect("/admin/timetable")


@app.route("/admin/timetable/edit/<int:class_id>", methods=["GET", "POST"])
@login_required("Admin")
def edit_class(class_id):

    if request.method == "POST":

        course_code = request.form["course_code"]
        session_type = request.form["session_type"]
        programme = request.form["programme"]
        level = request.form["level"]
        semester = request.form["semester"]
        day = request.form["day"]
        start_time = request.form["start_time"]
        end_time = request.form["end_time"]
        venue = request.form["venue"]
        lecturer_name = request.form["lecturer_name"]
        lecturer_title = request.form["lecturer_title"]

        if programme == "":
            programme = None

        cursor.execute(
            """UPDATE timetable
               SET course_code = ?, session_type = ?, programme = ?,
                   level = ?, semester = ?, day = ?,
                   start_time = ?, end_time = ?,
                   venue = ?, lecturer_name = ?, lecturer_title = ?
               WHERE id = ?""",
            (
                course_code,
                session_type,
                programme,
                level,
                semester,
                day,
                start_time,
                end_time,
                venue,
                lecturer_name,
                lecturer_title,
                class_id
            )
        )

        connection.commit()

        return redirect("/admin/timetable")

    cursor.execute(
        """SELECT id, course_code, session_type, programme, level, semester,
                  day, start_time, end_time, venue, lecturer_name, lecturer_title
           FROM timetable
           WHERE id = ?""",
        (class_id,)
    )

    class_data = cursor.fetchone()

    class_data = list(class_data)

    # start_time is now position 7
    total_seconds_start = class_data[7].total_seconds()

    hours_start = int(total_seconds_start // 3600)
    minutes_start = int((total_seconds_start % 3600) // 60)

    class_data[7] = f"{hours_start:02d}:{minutes_start:02d}"

    # end_time is now position 8
    total_seconds_end = class_data[8].total_seconds()

    hours_end = int(total_seconds_end // 3600)
    minutes_end = int((total_seconds_end % 3600) // 60)

    class_data[8] = f"{hours_end:02d}:{minutes_end:02d}"

    if class_data[3] is None:
        class_data[3] = ""

    return render_template(
        "edit_class.html",
        class_data=class_data
    )


# ============================================================
# ADMIN - TIMETABLE AUTO-GENERATION
# ============================================================

def generate_timetable(level, programme=None, semester="Semester 1"):

    """
    Attempts to build a conflict-free timetable for one level and
    programme using the lecturers, venues, and course requirements
    already stored in the database.
    """
    if semester == "First Semester":
        timetable_semester = "Semester 1"
    else:
        timetable_semester = "Semester 2"

    days = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday"
    ]

    time_slots = [
        ("08:00:00", "10:00:00"),
        ("10:00:00", "12:00:00"),
        ("12:00:00", "14:00:00"),
        ("14:00:00", "16:00:00"),
    ]

    # Get every course that needs to be scheduled for this level and semester
    if programme:

        cursor.execute(
            """SELECT course_code, lectures_per_week, practicals_per_week
            FROM course_requirements
            WHERE level = ? AND programme = ? AND semester = ?""",
            (level, programme, semester)
        )

    else:

        cursor.execute(
            """SELECT course_code, lectures_per_week, practicals_per_week
            FROM course_requirements
            WHERE level = ? AND programme IS NULL AND semester = ?""",
            (level, semester)
        )

    courses = cursor.fetchall()
    
    # Get all venues, split by type
    cursor.execute(
        "SELECT name, venue_type FROM venues"
    )

    all_venues = cursor.fetchall()

    lecture_rooms = [
        v[0] for v in all_venues
        if v[1] == "Lecture Room"
    ]

    labs = [
        v[0] for v in all_venues
        if v[1] == "Lab"
    ]

    booked_lecturer_slots = set()
    booked_venue_slots = set()
    booked_level_slots = set()
    new_schedule = []

    # Load existing timetable bookings
    cursor.execute(
        """SELECT day, start_time, venue, lecturer_name
        FROM timetable
        WHERE semester = ?""",
        (timetable_semester,)
    )

    existing_bookings = cursor.fetchall()

    for day, start_time, venue, lecturer_name in existing_bookings:
        start_time = str(start_time).zfill(8)

        booked_venue_slots.add((venue, day, start_time))

        if lecturer_name is not None:
            booked_lecturer_slots.add(
                (lecturer_name, day, start_time)
            )

    for course_code, lectures_needed, practicals_needed in courses:

        sessions_to_book = (
            [("Lecture", lecture_rooms)] * lectures_needed
            + [("Practical", labs)] * practicals_needed
        )

        for session_type, valid_venues in sessions_to_book:

            cursor.execute(
                """SELECT lecturers.full_name, lecturers.title
                   FROM lecturer_courses
                   JOIN lecturers
                   ON lecturer_courses.lecturer_id = lecturers.id
                   WHERE lecturer_courses.course_code = ?
                   AND lecturer_courses.session_type = ?""",
                (course_code, session_type)
            )

            possible_lecturers = cursor.fetchall()

            if not possible_lecturers:
                    possible_lecturers = [(None, None)]

            scheduled = False

            for day in days:

                if scheduled:
                    break

                for start_time, end_time in time_slots:

                    if scheduled:
                        break

                    if (day, start_time) in booked_level_slots:
                        continue

                    for lecturer_name, lecturer_title in possible_lecturers:

                        if lecturer_name is not None:
                            if (
                                lecturer_name,
                                day,
                                start_time
                            ) in booked_lecturer_slots:
                                continue

                        for venue in valid_venues:

                            if (
                                venue,
                                day,
                                start_time
                            ) in booked_venue_slots:

                                continue

                            if lecturer_name is not None:
                                booked_lecturer_slots.add(
                                    (lecturer_name, day, start_time)
                                )

                            booked_venue_slots.add(
                                (venue, day, start_time)
                            )

                            booked_level_slots.add(
                                (day, start_time)
                            )

                            new_schedule.append(
                                (
                                    course_code,
                                    session_type,
                                    programme,
                                    level,
                                    timetable_semester,
                                    day,
                                    start_time,
                                    end_time,
                                    venue,
                                    lecturer_name,
                                    lecturer_title
                                )
                            )

                            scheduled = True

                            break

                        if scheduled:
                            break

            if not scheduled:

                return (
                    f"Could not find a free slot for "
                    f"{course_code} ({session_type}) - "
                    f"try adding more venues or lecturers."
                )

    return new_schedule


# ============================================================
# ADMIN - GENERATE TIMETABLE ROUTE
# ============================================================

@app.route("/admin/timetable/generate", methods=["GET", "POST"])
@login_required("Admin")
def generate_timetable_route():

    if request.method == "POST":

        level = request.form["level"]
        programme = request.form["programme"]
        semester = request.form["semester"]

        if programme == "":
            programme = None

        if semester == "Semester 1":
            requirement_semester = "First Semester"
        else:
            requirement_semester = "Second Semester"

        result = generate_timetable(
            level,
            programme,
            requirement_semester
        )

        if isinstance(result, str):

            return render_template(
                "generate_timetable.html",
                message=result
            )

        # Delete only the selected level + programme + semester
        if programme:

            cursor.execute(
                """DELETE FROM timetable
                   WHERE level = ?
                   AND programme = ?
                   AND semester = ?""",
                (
                    level,
                    programme,
                    semester
                )
            )

        else:

            cursor.execute(
                """DELETE FROM timetable
                   WHERE level = ?
                   AND programme IS NULL
                   AND semester = ?""",
                (
                    level,
                    semester
                )
            )

        # Insert the new timetable
        for row in result:

            cursor.execute(
                """INSERT INTO timetable
                   (course_code, session_type, programme, level, semester,
                    day, start_time, end_time, venue,
                    lecturer_name, lecturer_title)
                   VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)""",
                row
            )

        connection.commit()

        return redirect("/admin/timetable")

    return render_template(
        "generate_timetable.html",
        message=""
    )


# ============================================================
# ADMIN - COMMENTS
# ============================================================

@app.route("/admin/comments")
@login_required("Admin")
def view_comments():

    cursor.execute(
        """SELECT lecturer_username, message, created_at
           FROM comments
           ORDER BY created_at DESC"""
    )

    all_comments = cursor.fetchall()

    return render_template(
        "comments.html",
        all_comments=all_comments
    )


# ============================================================
# START THE APP
# ============================================================

if __name__ == "__main__":

    app.run(host="0.0.0.0", port=5000, debug=True)