# =====SYSTEM DESIGN =====
# MAIN OBJECTS
- Users
- Students
- Lecturers
- Courses
- Timetable
- Comments
# CONNECTION
Users
 │
 ├──────── Student
 │
 └──────── Lecturer
               │
               │
           Timetable
          /         \
     Courses      Programme/Level
               │
               │
           Comments
           
# ===============================================
           
           
        # USER FLOW
         
	Admin
	│
	├── Create Student
	│      │
	│      ├── Username
	│      └── Temporary Password
	│
	├── Create Lecturer
	│      │
	│      ├── Username
	│      └── Temporary Password
	│
	└── Manage Timetable

	Student
	│
	├── Login
	├── Change Password
	└── View Timetable

	Lecturer
	│
	├── Login
	├── Change Password
	├── View Timetable
	└── Submit Comments
	
# Database Relationships
	Users
	│
	├── Students
	│       │
	│       └── Programmes
	│
	└── Lecturers
		│
		├── Timetable
		│       │
		│       ├── Courses
		│       └── Programmes
		│
		└── Comments
		
		
# ER DIAGRAM
		            USERS
	    ┌─────────────────────────────────┐
	    │ user_id (PK)                    │
	    │ username                        │
	    │ password                        │
	    │ role                            │
	    │ must_change_password            │
	    └─────────────────────────────────┘
		      │               │
		      │               │
		One-to-One      One-to-One
		      │               │
		      ▼               ▼

	      STUDENTS          LECTURERS
	 ┌────────────────┐   ┌─────────────────┐
	 │ student_id     │   │ lecturer_id     │
	 │ user_id (FK)   │   │ user_id (FK)    │
	 │ matric_no      │   │ staff_no        │
	 │ full_name      │   │ full_name       │
	 │ programme_id   │   │ email           │
	 └────────────────┘   └─────────────────┘
		 │                     │
		 │                     │
		 ▼                     ▼

	      PROGRAMMES          COMMENTS
	 ┌────────────────┐    ┌────────────────┐
	 │ programme_id   │    │ comment_id     │
	 │ programme_name │    │ lecturer_id FK │
	 └────────────────┘    │ message        │
		 ▲             │ created_at     │
		 │             └────────────────┘
		 │
		 │
		 ▼

	      TIMETABLE
	 ┌──────────────────────────────┐
	 │ timetable_id                 │
	 │ programme_id (FK)            │
	 │ course_id (FK)               │
	 │ lecturer_id (FK)             │
	 │ day                          │
	 │ start_time                   │
	 │ end_time                     │
	 │ venue                        │
	 └──────────────────────────────┘
		       ▲
		       │
		       │
		   COURSES
	 ┌────────────────────┐
	 │ course_id          │
	 │ course_code        │
	 │ course_title       │
	 │ units              │
	 └────────────────────┘
# USERS ("list")
	users

│
├── User 1
│      Username → admin
│      Password → 1234
│      Role → Admin
│
├── User 2
│      Username → john
│      Password → abc123
│      Role → Lecturer
│
└── User 3
       Username → MAP/CSC/24/001
       Password → pass123
       Role → Student