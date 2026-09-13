AUTO-TIMETABLE

A Flask-based automatic timetable management system using MariaDB.

The system provides timetable management for administrators, lecturers, and students, including timetable generation, searching, editing, and viewing.

Features
Admin, Lecturer, and Student accounts
User registration and management
Timetable creation and management
Automatic timetable generation
Lecturer timetable
Student timetable
Weekly timetable grid
Course search
Lecturer search
Comments
Venue management
Course requirements
Lecturer-course assignments
MariaDB database integration
Requirements

Before running the project, install the following:

Python 3
Git
MariaDB
Visual Studio Code (recommended)

Windows users can use the VS Code terminal or PowerShell for the commands below.

1. Clone the Repository

Open PowerShell or the VS Code terminal and run:

git clone YOUR_GITHUB_REPOSITORY_URL


Then enter the project directory:

cd AUTO-TIMETABLE

2. Create a Python Virtual Environment

Create the virtual environment:

python -m venv venv


Activate it:

.\venv\Scripts\Activate.ps1


After activation, the terminal should show (venv).

If PowerShell prevents activation, run:

Set-ExecutionPolicy -Scope CurrentUser RemoteSigned


Then activate the environment again:

.\venv\Scripts\Activate.ps1

3. Install Python Dependencies

Make sure the virtual environment is activated.

Run:

pip install -r requirements.txt


The project uses Flask and the MariaDB Python connector.

If installing the mariadb package fails on Windows, MariaDB Connector/C may need to be installed first.

4. Set Up MariaDB

Make sure the MariaDB server is running.

Open the MariaDB client as an administrator/root user.

Create the application database:

CREATE DATABASE auto_timetable;


Create the application database user:

CREATE USER 'flask_user'@'localhost' IDENTIFIED BY 'flask123';


Grant the user access to the database:

GRANT ALL PRIVILEGES ON auto_timetable.* TO 'flask_user'@'localhost';


Apply the privileges:

FLUSH PRIVILEGES;

5. Import the Project Database

The repository contains a database dump:

database/auto_timetable.sql


Exit the MariaDB client and return to the project directory.

From PowerShell, run:

mariadb -u flask_user -p auto_timetable < database\auto_timetable.sql


When prompted for the password, enter:

flask123


The database contains the tables and sample/test data required by the application.

6. Verify the Database

You can verify that the tables were imported successfully:

mariadb -u flask_user -p auto_timetable


Then run:

SHOW TABLES;


You should see:

comments
course_requirements
lecturer_courses
lecturers
timetable
users
venues


Exit MariaDB:

exit;

7. Run the Application

Make sure the Python virtual environment is activated:

.\venv\Scripts\Activate.ps1


Then run:

python app.py


Flask should start the application.

Open your browser and go to:

http://127.0.0.1:5000

Test Accounts

The database contains sample accounts for testing.

Administrator
Username: admin@mapoly.edu.ng
Password: 1234
Role: Admin

Lecturer
Username: john@mapoly.edu.ng
Password: abcd
Role: Lecturer

Student
Username: MAP/CSC/24/001
Password: pass123
Role: Student


These are development/test accounts.

Project Structure
AUTO-TIMETABLE/
│
├── app.py
├── database.py
├── requirements.txt
├── README.md
│
├── database/
│   ├── auto_timetable.sql
│   ├── TABLES
│   └── databasetabes.md
│
├── static/
│   └── style.css
│
└── templates/
    ├── add_class.html
    ├── admin.html
    ├── base.html
    ├── bulk_register.html
    ├── comments.html
    ├── edit.html
    ├── edit_class.html
    ├── generate_timetable.html
    ├── index.html
    ├── lecturer.html
    ├── login.html
    ├── register.html
    ├── search.html
    ├── search_course.html
    ├── student.html
    ├── timetable.html
    ├── timetable_grid.html
    └── users.html

Working With Git

Do not work directly on the master branch if multiple people are developing the project.

Create a branch for your work:

git checkout -b my-feature


For example:

git checkout -b timetable-improvements


After making changes:

git add .
git commit -m "Improve timetable generation"
git push -u origin timetable-improvements


Then create a Pull Request on GitHub so the changes can be reviewed before being merged.

Getting New Changes From GitHub

Before starting new work, update your local copy:

git checkout master
git pull


Then create your new branch:

git checkout -b my-new-feature

Important

Do not commit sensitive information such as:

Real passwords
API keys
Database credentials for production
.env files
Private user information

The credentials currently included in this project are intended only for local development/testing.

Troubleshooting
Database connection error

If the application displays a database connection error, check that:

MariaDB is running.
The database is named auto_timetable.
The MariaDB user is flask_user.
The password is flask123.
The user has privileges on auto_timetable.

You can test the connection with:

mariadb -u flask_user -p auto_timetable

Python package installation error

Make sure the virtual environment is activated:

.\venv\Scripts\Activate.ps1


Then run:

pip install -r requirements.txt

Port already in use

If port 5000 is already being used, stop the other Flask application or change the port configuration in app.py.

Development Database

The included:

database/auto_timetable.sql


is a development database dump containing the tables and sample data required by the application.

For production deployment, use secure credentials and a separate production database.
