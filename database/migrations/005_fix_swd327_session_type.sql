UPDATE lecturer_courses
JOIN lecturers ON lecturer_courses.lecturer_id = lecturers.id
SET lecturer_courses.session_type = 'Practical'
WHERE lecturer_courses.course_code = 'SWD327'
  AND lecturer_courses.semester = 'Second Semester'
  AND lecturer_courses.session_type = 'Lecture'
  AND lecturers.full_name = 'MR S.O KAREEM';
