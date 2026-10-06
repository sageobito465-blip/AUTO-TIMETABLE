-- course_requirements uses 'First Semester' and 'Second Semester'.
-- timetable.semester uses 'Semester 1' and 'Semester 2'.
-- The six existing ND2 requirement records were an old second-semester snapshot.

ALTER TABLE course_requirements
    ADD COLUMN semester VARCHAR(20) NULL
    AFTER programme;

UPDATE course_requirements
SET semester = 'Second Semester'
WHERE level = 'ND2'
  AND programme IS NULL
  AND course_code IN ('COM221', 'COM223', 'COM224', 'COM225', 'COM227', 'COM228');

-- Insert missing ND1 and ND2 requirements without adding duplicate rows on rerun.
INSERT INTO course_requirements
    (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT requirements.course_code,
       requirements.level,
       requirements.programme,
       requirements.semester,
       requirements.lectures_per_week,
       requirements.practicals_per_week
FROM (
    SELECT 'COM111' AS course_code, 'ND1' AS level, NULL AS programme, 'First Semester' AS semester, 1 AS lectures_per_week, 1 AS practicals_per_week
    UNION ALL SELECT 'COM112', 'ND1', NULL, 'First Semester', 1, 1
    UNION ALL SELECT 'COM113', 'ND1', NULL, 'First Semester', 1, 1
    UNION ALL SELECT 'COM114', 'ND1', NULL, 'First Semester', 1, 0
    UNION ALL SELECT 'COM115', 'ND1', NULL, 'First Semester', 1, 1
    UNION ALL SELECT 'MTH111', 'ND1', NULL, 'First Semester', 1, 0
    UNION ALL SELECT 'GNS101', 'ND1', NULL, 'First Semester', 1, 0
    UNION ALL SELECT 'GNS111', 'ND1', NULL, 'First Semester', 1, 0
    UNION ALL SELECT 'COM121', 'ND1', NULL, 'Second Semester', 1, 1
    UNION ALL SELECT 'COM122', 'ND1', NULL, 'Second Semester', 1, 1
    UNION ALL SELECT 'COM123', 'ND1', NULL, 'Second Semester', 1, 1
    UNION ALL SELECT 'COM124', 'ND1', NULL, 'Second Semester', 1, 1
    UNION ALL SELECT 'COM125', 'ND1', NULL, 'Second Semester', 1, 1
    UNION ALL SELECT 'COM126', 'ND1', NULL, 'Second Semester', 1, 1
    UNION ALL SELECT 'GNS128', 'ND1', NULL, 'Second Semester', 1, 0
    UNION ALL SELECT 'GNS102', 'ND1', NULL, 'Second Semester', 1, 0
    UNION ALL SELECT 'EED126', 'ND1', NULL, 'Second Semester', 1, 0
    UNION ALL SELECT 'GNS228', 'ND1', NULL, 'Second Semester', 1, 0
    UNION ALL SELECT 'COM211', 'ND2', NULL, 'First Semester', 1, 1
    UNION ALL SELECT 'COM212', 'ND2', NULL, 'First Semester', 1, 1
    UNION ALL SELECT 'COM213', 'ND2', NULL, 'First Semester', 1, 1
    UNION ALL SELECT 'COM214', 'ND2', NULL, 'First Semester', 1, 1
    UNION ALL SELECT 'COM215', 'ND2', NULL, 'First Semester', 1, 1
    UNION ALL SELECT 'COM216', 'ND2', NULL, 'First Semester', 1, 0
    UNION ALL SELECT 'SIW219', 'ND2', NULL, 'First Semester', 1, 0
    UNION ALL SELECT 'GNS201', 'ND2', NULL, 'First Semester', 1, 0
    UNION ALL SELECT 'EED216', 'ND2', NULL, 'First Semester', 1, 0
    UNION ALL SELECT 'COM221', 'ND2', NULL, 'Second Semester', 1, 1
    UNION ALL SELECT 'COM222', 'ND2', NULL, 'Second Semester', 1, 0
    UNION ALL SELECT 'COM223', 'ND2', NULL, 'Second Semester', 1, 1
    UNION ALL SELECT 'COM224', 'ND2', NULL, 'Second Semester', 1, 1
    UNION ALL SELECT 'COM225', 'ND2', NULL, 'Second Semester', 1, 1
    UNION ALL SELECT 'COM226', 'ND2', NULL, 'Second Semester', 1, 1
    UNION ALL SELECT 'GNS204', 'ND2', NULL, 'Second Semester', 1, 0
    UNION ALL SELECT 'COM227', 'ND2', NULL, 'Second Semester', 1, 0
    UNION ALL SELECT 'COM228', 'ND2', NULL, 'Second Semester', 1, 0
) AS requirements
WHERE NOT EXISTS (
    SELECT 1
    FROM course_requirements AS existing
    WHERE existing.course_code = requirements.course_code
      AND existing.level = requirements.level
      AND existing.programme <=> requirements.programme
      AND existing.semester = requirements.semester
);

ALTER TABLE course_requirements
    MODIFY COLUMN semester VARCHAR(20) NOT NULL;

-- Correct only the listed ND2 rows still labeled as Semester 1.
UPDATE timetable
SET semester = 'Semester 2'
WHERE level = 'ND2'
  AND semester = 'Semester 1'
  AND course_code IN ('COM221', 'COM223', 'COM224', 'COM225', 'COM227', 'COM228');
