INSERT INTO course_requirements /* HND titles remain Unassigned. NCC322 is excluded pending confirmation of its practical count. NCC415 and SWD417 are omitted because MSQ is unsupported by the current generator. Unusual NCC322(P) and SWD421(P) entries are omitted pending confirmation. */ (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'GNS301', 'HND1', 'NCC', 'First Semester', 1, 0
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'GNS301' AND level = 'HND1' AND programme = 'NCC' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC311', 'HND1', 'NCC', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC311' AND level = 'HND1' AND programme = 'NCC' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC312', 'HND1', 'NCC', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC312' AND level = 'HND1' AND programme = 'NCC' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC313', 'HND1', 'NCC', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC313' AND level = 'HND1' AND programme = 'NCC' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC314', 'HND1', 'NCC', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC314' AND level = 'HND1' AND programme = 'NCC' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC315', 'HND1', 'NCC', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC315' AND level = 'HND1' AND programme = 'NCC' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC316', 'HND1', 'NCC', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC316' AND level = 'HND1' AND programme = 'NCC' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'STA311', 'HND1', 'NCC', 'First Semester', 1, 0
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'STA311' AND level = 'HND1' AND programme = 'NCC' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'STA314', 'HND1', 'NCC', 'First Semester', 1, 0
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'STA314' AND level = 'HND1' AND programme = 'NCC' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'AIT312', 'HND1', 'NCC', 'Second Semester', 1, 0
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'AIT312' AND level = 'HND1' AND programme = 'NCC' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'AIT313', 'HND1', 'NCC', 'Second Semester', 0, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'AIT313' AND level = 'HND1' AND programme = 'NCC' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'AIT322', 'HND1', 'NCC', 'Second Semester', 0, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'AIT322' AND level = 'HND1' AND programme = 'NCC' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'CYS322', 'HND1', 'NCC', 'Second Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'CYS322' AND level = 'HND1' AND programme = 'NCC' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'ENT326', 'HND1', 'NCC', 'Second Semester', 1, 0
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'ENT326' AND level = 'HND1' AND programme = 'NCC' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'GNS302', 'HND1', 'NCC', 'Second Semester', 1, 0
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'GNS302' AND level = 'HND1' AND programme = 'NCC' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC321', 'HND1', 'NCC', 'Second Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC321' AND level = 'HND1' AND programme = 'NCC' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC323', 'HND1', 'NCC', 'Second Semester', 1, 0
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC323' AND level = 'HND1' AND programme = 'NCC' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC324', 'HND1', 'NCC', 'Second Semester', 0, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC324' AND level = 'HND1' AND programme = 'NCC' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC325', 'HND1', 'NCC', 'Second Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC325' AND level = 'HND1' AND programme = 'NCC' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'AIT311', 'HND1', 'SWD', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'AIT311' AND level = 'HND1' AND programme = 'SWD' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'AIT313', 'HND1', 'SWD', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'AIT313' AND level = 'HND1' AND programme = 'SWD' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'AIT314', 'HND1', 'SWD', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'AIT314' AND level = 'HND1' AND programme = 'SWD' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'STA311', 'HND1', 'SWD', 'First Semester', 1, 0
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'STA311' AND level = 'HND1' AND programme = 'SWD' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'STA314', 'HND1', 'SWD', 'First Semester', 1, 0
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'STA314' AND level = 'HND1' AND programme = 'SWD' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD311', 'HND1', 'SWD', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD311' AND level = 'HND1' AND programme = 'SWD' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD312', 'HND1', 'SWD', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD312' AND level = 'HND1' AND programme = 'SWD' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD313', 'HND1', 'SWD', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD313' AND level = 'HND1' AND programme = 'SWD' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD315', 'HND1', 'SWD', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD315' AND level = 'HND1' AND programme = 'SWD' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD316', 'HND1', 'SWD', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD316' AND level = 'HND1' AND programme = 'SWD' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'ENT326', 'HND1', 'SWD', 'Second Semester', 1, 0
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'ENT326' AND level = 'HND1' AND programme = 'SWD' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD321', 'HND1', 'SWD', 'Second Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD321' AND level = 'HND1' AND programme = 'SWD' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD322', 'HND1', 'SWD', 'Second Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD322' AND level = 'HND1' AND programme = 'SWD' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD323', 'HND1', 'SWD', 'Second Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD323' AND level = 'HND1' AND programme = 'SWD' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD324', 'HND1', 'SWD', 'Second Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD324' AND level = 'HND1' AND programme = 'SWD' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD325', 'HND1', 'SWD', 'Second Semester', 1, 0
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD325' AND level = 'HND1' AND programme = 'SWD' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD326', 'HND1', 'SWD', 'Second Semester', 1, 0
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD326' AND level = 'HND1' AND programme = 'SWD' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD327', 'HND1', 'SWD', 'Second Semester', 0, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD327' AND level = 'HND1' AND programme = 'SWD' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'AIT321', 'HND2', 'NCC', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'AIT321' AND level = 'HND2' AND programme = 'NCC' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'CYS412', 'HND2', 'NCC', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'CYS412' AND level = 'HND2' AND programme = 'NCC' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'ENT413', 'HND2', 'NCC', 'First Semester', 1, 0
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'ENT413' AND level = 'HND2' AND programme = 'NCC' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'GNS401', 'HND2', 'NCC', 'First Semester', 1, 0
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'GNS401' AND level = 'HND2' AND programme = 'NCC' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC411', 'HND2', 'NCC', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC411' AND level = 'HND2' AND programme = 'NCC' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC412', 'HND2', 'NCC', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC412' AND level = 'HND2' AND programme = 'NCC' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC413', 'HND2', 'NCC', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC413' AND level = 'HND2' AND programme = 'NCC' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC414', 'HND2', 'NCC', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC414' AND level = 'HND2' AND programme = 'NCC' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC421', 'HND2', 'NCC', 'Second Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC421' AND level = 'HND2' AND programme = 'NCC' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC422', 'HND2', 'NCC', 'Second Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC422' AND level = 'HND2' AND programme = 'NCC' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC423', 'HND2', 'NCC', 'Second Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC423' AND level = 'HND2' AND programme = 'NCC' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'NCC424', 'HND2', 'NCC', 'Second Semester', 0, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'NCC424' AND level = 'HND2' AND programme = 'NCC' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'ENT413', 'HND2', 'SWD', 'First Semester', 1, 0
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'ENT413' AND level = 'HND2' AND programme = 'SWD' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD411', 'HND2', 'SWD', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD411' AND level = 'HND2' AND programme = 'SWD' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD412', 'HND2', 'SWD', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD412' AND level = 'HND2' AND programme = 'SWD' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD413', 'HND2', 'SWD', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD413' AND level = 'HND2' AND programme = 'SWD' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD414', 'HND2', 'SWD', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD414' AND level = 'HND2' AND programme = 'SWD' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD415', 'HND2', 'SWD', 'First Semester', 1, 0
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD415' AND level = 'HND2' AND programme = 'SWD' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD416', 'HND2', 'SWD', 'First Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD416' AND level = 'HND2' AND programme = 'SWD' AND semester = 'First Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD421', 'HND2', 'SWD', 'Second Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD421' AND level = 'HND2' AND programme = 'SWD' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD422', 'HND2', 'SWD', 'Second Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD422' AND level = 'HND2' AND programme = 'SWD' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD423', 'HND2', 'SWD', 'Second Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD423' AND level = 'HND2' AND programme = 'SWD' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD424', 'HND2', 'SWD', 'Second Semester', 1, 0
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD424' AND level = 'HND2' AND programme = 'SWD' AND semester = 'Second Semester');

INSERT INTO course_requirements (course_code, level, programme, semester, lectures_per_week, practicals_per_week)
SELECT 'SWD425', 'HND2', 'SWD', 'Second Semester', 1, 1
WHERE NOT EXISTS (SELECT 1 FROM course_requirements WHERE course_code = 'SWD425' AND level = 'HND2' AND programme = 'SWD' AND semester = 'Second Semester');
