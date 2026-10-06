DELETE lecturer_courses
FROM lecturer_courses
JOIN lecturers ON lecturer_courses.lecturer_id = lecturers.id
WHERE lecturer_courses.course_code = 'GNS128/121'
  AND lecturer_courses.session_type = 'Lecture'
  AND lecturer_courses.semester = 'Second Semester'
  AND lecturers.full_name = 'GNS DEPT.';
