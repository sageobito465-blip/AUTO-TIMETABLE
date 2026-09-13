# Auto-Timetable

A web-based timetable management system for the Computer Science Department at MAPOLY (Moshood Abiola Polytechnic). Built with Flask, MariaDB, and Jinja2.

## Overview

Auto-Timetable lets Students, Lecturers, and Admins log in with role-based access to view, search, and manage the department's class schedule. Admins can manage users and timetable entries directly through the web interface, register users individually or in bulk via CSV, and auto-generate a conflict-free timetable for a level once course requirements, lecturers, and venues are defined.

## Tech Stack

- **Backend:** Python, Flask
- **Database:** MariaDB (MySQL-compatible)
- **Templating:** Jinja2, with template inheritance (`base.html`)
- **Security:** `werkzeug.security` for password hashing
- **Config:** `python-dotenv` for environment variables (credentials, secret key)
- **Frontend:** Custom CSS (no framework)

## Setup

1. Clone the repository and set up a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate        # Windows: venv\Scripts\activate
   pip install -r requirements.txt
   ```

   **Windows note:** installing the `mariadb` package sometimes fails unless
   MariaDB Connector/C is installed first. If `pip install mariadb` errors
   out, download and install Connector/C from mariadb.com, then try again.

2. Create the MariaDB database and tables. See `database/` for schema details
   and setup steps, and `schema.sql` (if present) for the timetable/users/
   comments structure.

3. **Create a `.env` file** in the project root (this file is intentionally
   excluded from Git via `.gitignore` — you must create your own):
   ```
   DB_HOST=localhost
   DB_USER=your_db_username
   DB_PASSWORD=your_db_password
   DB_NAME=auto_timetable
   SECRET_KEY=any_long_random_string
   ```
   The app will not start correctly without this file — `database.py` and
   `app.py` both read from it.

4. Run the app:
   ```bash
   python app.py
   ```
   Visit `http://127.0.0.1:5000`.

5. Create your first Admin account directly in the database (since
   `/admin/register` itself requires being logged in as an Admin already),
   or ask an existing Admin to register you.

## Features

### Authentication & Access Control
- Session-based login with hashed passwords (no plain-text storage)
- Role-based access: **Student**, **Lecturer**, **Admin**
- `login_required(role)` decorator protects every route, with Admin override
- Auto-redirect away from `/login` if already authenticated

### Admin
- **User management:** register individually (`/admin/register`) or in bulk
  via CSV upload (`/admin/bulk-register`); view, edit, delete users
- **Timetable management:** full CRUD (`/admin/timetable`) for individual
  classes, plus **auto-generation** (`/admin/timetable/generate`) that
  builds a conflict-free schedule for a level from defined course
  requirements, lecturers, and venues
- **Comments:** view all comments submitted by lecturers (`/admin/comments`)
- **Dashboard:** live stats and shortcuts to common actions

### Student
- Timetable view as a day-by-time-slot grid, filtered to their own level
  (and, once wired in, their NCC/SWD programme for HND1/HND2)
- Switch to view any other level's timetable
- Search for lecturers or courses

### Lecturer
- View only their own assigned classes
- Submit comments visible only to Admins
- Search for lecturers or courses

### Search
- **Search Lecturer** (`/search`) — partial match on lecturer name
- **Search Course** (`/search/course`) — partial match on course code

## Bulk CSV Registration

`/admin/bulk-register` accepts a CSV file with these columns:

```
username, password, full_name, email, level, role, programme
```

- `level`: ND1 / ND2 / HND1 / HND2 (Students only)
- `programme`: NCC / SWD (HND1/HND2 Students only, leave blank otherwise)
- Existing usernames are skipped automatically to avoid duplicates
- Passwords are hashed on import, same as individual registration

## Auto-Generation

`/admin/timetable/generate` builds a conflict-free schedule for one level
using three supporting tables:

- `course_requirements` — which courses exist for a level, and how many
  lecture/practical sessions each needs per week
- `lecturers` + `lecturer_courses` — who can teach what
- `venues` — rooms and labs, typed so practicals only go into labs

**This currently only has sample data for ND2**, entered as a proof of
concept. Generating for a level with no `course_requirements` entries will
simply produce an empty schedule. Populate these tables for other levels
before generating their timetables.

Generating for a level **deletes and replaces** any existing timetable
entries for that level — back up first if needed.

## Database Schema Summary

See `database/` for full setup docs. Core tables:

- **users** — id, username, password (hashed), role, full_name, email,
  level, programme
- **timetable** — id, course_code, session_type, programme, level, day,
  start_time, end_time, venue, lecturer_name, lecturer_title
- **comments** — id, lecturer_username, message, created_at
- **course_requirements**, **lecturers**, **lecturer_courses**, **venues** —
  support tables for auto-generation (ND2 sample data only, see above)

## Known Limitations / Future Work

- **No self-service password reset.** Only an Admin can reset a password.
  All bulk-imported accounts currently share one temporary password —
  a real deployment should prompt for a password change on first login.
- **NCC/SWD filtering not fully wired in** on the Student dashboard yet,
  even though the `programme` field exists on both `users` and `timetable`.
- **Auto-generation is proof-of-concept**, populated for ND2 only. Real
  data for ND1, HND1, and HND2 (courses, lecturers, venues) still needs
  to be entered before generation will work for those levels.
- **Comments are one-way.** Lecturers can submit comments to Admins, but
  there's no reply, delete, or "resolved" status yet.
- **`hash.py`** is a one-time migration script used to convert early
  plain-text test passwords to hashes. Do not run it again — it is kept
  only as a reference.

## Project Structure

```
AUTO-TIMETABLE/
├── app.py                  # All Flask routes and application logic
├── database.py              # MariaDB connection (reads from .env)
├── hash.py                  # One-time password migration script (do not re-run)
├── requirements.txt
├── .env                      # Not committed - create your own (see Setup)
├── .gitignore
├── database/                 # Schema docs and setup steps
├── templates/                # Jinja2 templates
└── static/
    └── style.css
```