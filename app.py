from flask import Flask, render_template, request, redirect, session 
from database import connection, cursor
from functools import wraps

app = Flask(__name__)
# SECRET KEY
app.secret_key = "auto_timetable_key"

# Checks if a user is logged in.
def login_required(role):

    def login_validation(f):

        @wraps(f)
        def guard(*args, **kwargs):

            if "username" not in session:
                return redirect("/login")
            
            if session["role"] != role and session["role"] != "Admin":
                return redirect("/login")
            
            return f(*args, **kwargs)
        
        return guard
    
    return login_validation


# Home page
@app.route("/")
def home():
    return render_template("index.html")


# Login page
@app.route("/login", methods=["GET", "POST"])
def login():

    if request.method == "POST":

        username = request.form["username"]
        password = request.form["password"]

        cursor.execute(
            "SELECT username, password, role FROM users WHERE username = ?",
            (username,)
        )

        user = cursor.fetchone()
# ROLES (USERS)
        if user:

            if password == user[1]:

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

    return render_template("login.html", message="")

#Logout

@app.route("/logout")
def logout():
    session.clear()
    return redirect("/login")

# Student Dashboard
@app.route("/student")
@login_required("Student")
def student_dashboard():
    username = session["username"]

    cursor.execute("SELECT level FROM users WHERE username = ?", (username,))
    student = cursor.fetchone()
    student_level = student[0]

    selected_level = request.args.get("level", student_level)

    cursor.execute(
        "SELECT course_code, course_title, level, day, start_time, end_time, lecturer, room FROM timetable WHERE level = ?",
        (selected_level,)
    )
    all_classes = cursor.fetchall()

    return render_template("student.html", username=username, all_classes=all_classes, selected_level=selected_level)
# End of student session or tab.



# Lecturer Dashboard
@app.route("/lecturer")
@login_required("Lecturer")
def lecturer_dashboard():
    username = session["username"]

    cursor.execute("SELECT full_name FROM users WHERE username = ?", (username,))
    lecturer = cursor.fetchone()
    lecturer_name = lecturer[0]

    cursor.execute(
        "SELECT course_code, course_title, level, day, start_time, end_time, room FROM timetable WHERE lecturer = ?",
        (lecturer_name,)
    )
    all_classes = cursor.fetchall()

    return render_template("lecturer.html", username=username, lecturer_name=lecturer_name, all_classes=all_classes)

# Lecturer comment
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


# Search for lecturer 
@app.route("/search")
def search_lecturer():
    if "username" not in session:
        return redirect("/login")

    query = request.args.get("query", "")

    cursor.execute(
        "SELECT course_code, course_title, level, day, start_time, end_time, lecturer, room FROM timetable WHERE lecturer LIKE ?",
        (f"%{query}%",)
    )
    results = cursor.fetchall()

    return render_template("search.html", results=results, query=query)
# lecturer section

#Search for courses
@app.route("/search/course")
def search_course():
    if "username" not in session:
        return redirect("/login")

    query = request.args.get("query", "")

    cursor.execute(
        "SELECT course_code, course_title, level, day, start_time, end_time, lecturer, room FROM timetable WHERE course_code LIKE ? OR course_title LIKE ?",
        (f"%{query}%", f"%{query}%")
    )
    results = cursor.fetchall()

    return render_template("search_course.html", results=results, query=query)

# Admin Dashboard
@app.route("/admin")
@login_required("Admin")
def admin_dashboard():
    
    username = session["username"]

    return render_template(
        "admin.html",
        username=username)

# Register A New User
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

        cursor.execute(
            "INSERT INTO users (username, password, role, full_name, email, level) VALUES(?, ?, ?, ?, ?, ?)",
            (username, password, role, full_name, email, level)
        )
        connection.commit()

        return "user registered succesfully!"
    
    return render_template("register.html", message="")
    

# List of Users function
@app.route("/admin/users")
@login_required("Admin")
def manage_users():
    cursor.execute("SELECT id, username, full_name, role, email FROM users")
    all_users = cursor.fetchall()

    return render_template("users.html", all_users=all_users)

# Delete user function
@app.route("/admin/delete/<int:user_id>")
@login_required("Admin")
def delete_user(user_id):
    cursor.execute("DELETE FROM users WHERE id = ?", (user_id,))
    connection.commit()

    return redirect("/admin/users")

# Edit User Function for Admin
@app.route("/admin/edit/<int:user_id>", methods=["GET", "POST"])
@login_required("Admin")
def edit_user(user_id):

    if request.method =="POST":
        username = request.form["username"]
        full_name = request.form["full_name"]
        role = request.form["role"]
        email = request.form["email"]
        level = request.form["level"]

        cursor.execute(
            "UPDATE users SET username = ?, full_name = ?, email = ?, role = ?, level = ? WHERE id = ?",
            (username, full_name, email, role, level, user_id)
        )
        connection.commit()

        return redirect("/admin/users")


    cursor.execute("SELECT id, username, full_name, role, email, level FROM users WHERE id = ?", (user_id,))
    user = cursor.fetchone()

    return render_template("edit.html", user=user)
# Admin view comments
@app.route("/admin/comments")
@login_required("Admin")
def view_comments():
    cursor.execute("SELECT lecturer_username, message, created_at FROM comments ORDER BY created_at DESC")
    all_comments = cursor.fetchall()

    return render_template("comments.html", all_comments=all_comments)





if __name__ == "__main__":
    app.run(debug=True)