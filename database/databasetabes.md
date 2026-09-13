#=========== Database Design =========

------- USERS ---------
-----------------------
 Admin
 Lecturer
 Student
 ---------------------
 ------- User Tables-----
	students
	lecturers
	courses
	rooms
	timetable
 Column-----------Purpose
	id----------------Unique ID for each user
	username----------Used to log in
	password----------User's password 
	role Admin,-------Lecturer, or Student
	full_name---------User's full name
	email-------------Email address
		users
		│
		├── id
		├── username
		├── password
		├── role
		├── full_name
		└── email

		lecturers
		│
		├── id
		├── user_id
		├── staff_number
		└── department

		students
		│
		├── id
		├── user_id
		├── matric_number
		├── level
		└── programme

		courses
		│
		├── id
		├── course_code
		├── course_title
		├── units
		├── level
		├── programme
		└── lecturer_id

		rooms
		│
		├── id
		├── room_name
		└── capacity

		timetable
		│
		├── id
		├── course_id
		├── room_id
		├── day
		├── start_time
		├── end_time
		└── session
