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
        def guard():

            if "username" not in session:
                return redirect("/login")
            
            if session["role"] != role and session["role"] != "Admin":
                return redirect("/login")
            
            return f()
        
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
    return "Student Dashboard"

# Lecturer Dashboard
@app.route("/lecturer")
@login_required("Lecturer")
def lecturer_dashboard():
    return "Lecturer Dashboard"


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

        cursor.execute(
            "INSERT INTO users (username, password, role, full_name, email) VALUES(?, ?, ?, ?, ?)",
            (username, password, role, full_name, email)
        )
        connection.commit()

        return "user registered succesfully!"

# List of Users 
@app.route("/admin/users")
@login_required("Admin")
def manage_users():
    cursor.execute("SELECT id, username, full_name, role, email FROM users")
    all_users = cursor.fetchall()

    return render_template("users.html", all_users=all_users)

    
    return render_template("register.html", message="")

if __name__ == "__main__":
    app.run(debug=True)