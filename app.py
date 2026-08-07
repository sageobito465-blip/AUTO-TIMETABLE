from flask import Flask, render_template, request, redirect, session 
from database import connection, cursor

app = Flask(__name__)
# SECRET KEY
app.secret_key = "auto_timetable_key"

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
def student_dashboard():
    return "Student Dashboard"


# Lecturer Dashboard
@app.route("/lecturer")
def lecturer_dashboard():
    return "Lecturer Dashboard"


# Admin Dashboard
@app.route("/admin")
def admin_dashboard():

    username = session["username"]

    return render_template(
        "admin.html",
        username=username)


if __name__ == "__main__":
    app.run(debug=True)