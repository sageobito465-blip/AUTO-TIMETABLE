DELETE FROM course_requirements
WHERE course_code = 'SIW219'
  AND level = 'ND2'
  AND programme IS NULL
  AND semester = 'First Semester';

DELETE FROM timetable
WHERE course_code = 'SIW219'
  AND level = 'ND2';
