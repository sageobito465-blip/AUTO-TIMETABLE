-- ============================================================
-- AUTO-TIMETABLE - Database Schema
-- ============================================================
-- Run these statements in order on a fresh MariaDB server to
-- set up the database this project needs.
--
-- Usage:
--   1. Log into MariaDB: mysql -u root -p   (or mariadb -u root -p)
--   2. CREATE DATABASE auto_timetable;
--   3. USE auto_timetable;
--   4. Paste/run everything below.

-- ============================================================
-- CORE TABLES
-- ============================================================

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,             -- stored as a werkzeug password hash, never plain text
    role ENUM('Admin', 'Lecturer', 'Student') NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    level VARCHAR(20),                           -- ND1 / ND2 / HND1 / HND2, Students only
    programme VARCHAR(20)                        -- NCC / SWD, HND1/HND2 Students only
);

CREATE TABLE timetable (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(50) NOT NULL,            -- e.g. "COM223", or a label like "SEMINAR & PROJECT"
    session_type ENUM('Lecture', 'Practical') DEFAULT 'Lecture',
    programme VARCHAR(20),                        -- NCC / SWD, only relevant for HND1/HND2 rows
    level VARCHAR(20) NOT NULL,                   -- ND1 / ND2 / HND1 / HND2
    day VARCHAR(20) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    venue VARCHAR(100),
    lecturer_name VARCHAR(100),
    lecturer_title VARCHAR(20)                    -- 'L' (Lecturer) or 'T' (Technologist)
);

CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    lecturer_username VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- AUTO-GENERATION SUPPORT TABLES
-- ============================================================
-- These feed the /admin/timetable/generate feature. Currently only
-- populated with sample data for ND2 (see bottom of this file) -
-- real data for ND1, HND1, and HND2 still needs to be entered.

CREATE TABLE lecturers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    title VARCHAR(20)                             -- 'L' or 'T'
);

CREATE TABLE lecturer_courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    lecturer_id INT NOT NULL,
    course_code VARCHAR(50) NOT NULL,
    FOREIGN KEY (lecturer_id) REFERENCES lecturers(id)
);

CREATE TABLE course_requirements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(50) NOT NULL,
    level VARCHAR(20) NOT NULL,
    programme VARCHAR(20),
    lectures_per_week INT DEFAULT 1,
    practicals_per_week INT DEFAULT 0
);

CREATE TABLE venues (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    venue_type ENUM('Lecture Room', 'Lab') NOT NULL
);


-- ============================================================
-- OPTIONAL: Sample data to test the generator (ND2 only)
-- ============================================================
-- Uncomment and run this section if you want working sample data
-- to test /admin/timetable/generate immediately after setup.

-- INSERT INTO lecturers (full_name, title) VALUES
-- ('Mr Adebesin', 'T'),
-- ('Mr Raji', 'L'),
-- ('Dr Orunsolu', 'L'),
-- ('Mr Olatunji', 'T'),
-- ('Mr Paul', 'T'),
-- ('Mr Salawu', 'L'),
-- ('Mr Faleti', 'L'),
-- ('Mr Moses', 'T');

-- INSERT INTO lecturer_courses (lecturer_id, course_code) VALUES
-- ((SELECT id FROM lecturers WHERE full_name = 'Mr Adebesin'), 'COM223'),
-- ((SELECT id FROM lecturers WHERE full_name = 'Mr Raji'), 'COM221'),
-- ((SELECT id FROM lecturers WHERE full_name = 'Dr Orunsolu'), 'COM228'),
-- ((SELECT id FROM lecturers WHERE full_name = 'Mr Olatunji'), 'COM224'),
-- ((SELECT id FROM lecturers WHERE full_name = 'Mr Paul'), 'COM225'),
-- ((SELECT id FROM lecturers WHERE full_name = 'Mr Paul'), 'COM221'),
-- ((SELECT id FROM lecturers WHERE full_name = 'Mr Salawu'), 'COM227'),
-- ((SELECT id FROM lecturers WHERE full_name = 'Mr Faleti'), 'GNS202'),
-- ((SELECT id FROM lecturers WHERE full_name = 'Mr Moses'), 'COM226');

-- INSERT INTO course_requirements (course_code, level, programme, lectures_per_week, practicals_per_week) VALUES
-- ('COM221', 'ND2', NULL, 1, 1),
-- ('COM223', 'ND2', NULL, 1, 1),
-- ('COM224', 'ND2', NULL, 1, 1),
-- ('COM225', 'ND2', NULL, 1, 1),
-- ('COM227', 'ND2', NULL, 1, 0),
-- ('COM228', 'ND2', NULL, 1, 0),
-- ('GNS202', 'ND2', NULL, 1, 0),
-- ('COM226', 'ND2', NULL, 1, 1);

-- INSERT INTO venues (name, venue_type) VALUES
-- ('COM RM 2', 'Lecture Room'),
-- ('ICT RM 7', 'Lecture Room'),
-- ('ICT RM 8', 'Lecture Room'),
-- ('SCI COM RM 1A', 'Lecture Room'),
-- ('LAB 10', 'Lab'),
-- ('LAB 11', 'Lab'),
-- ('LAB 12', 'Lab');


-- ============================================================
-- FIRST ADMIN ACCOUNT
-- ============================================================
-- Since /admin/register requires being logged in as an Admin already,
-- you need one Admin account to exist before anyone can log in.
--
-- The password below must be a real werkzeug hash, not plain text -
-- generate one with Python first:
--
--   python3 -c "from werkzeug.security import generate_password_hash; print(generate_password_hash('your_chosen_password'))"
--
-- Then paste the output into the INSERT below, replacing the placeholder.

-- INSERT INTO users (username, password, role, full_name, email)
-- VALUES ('admin', 'PASTE_THE_GENERATED_HASH_HERE', 'Admin', 'System Administrator', '');