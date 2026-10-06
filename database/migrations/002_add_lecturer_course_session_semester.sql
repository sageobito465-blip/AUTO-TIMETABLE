/* Add semester-aware session details to lecturer/course assignments. */
ALTER TABLE lecturer_courses
    ADD COLUMN IF NOT EXISTS session_type VARCHAR(20) NULL AFTER course_code,
    ADD COLUMN IF NOT EXISTS semester VARCHAR(20) NULL AFTER session_type;

/* Populate the existing seven rows without deleting or replacing them. */
UPDATE lecturer_courses SET session_type = 'Practical', semester = 'Second Semester' WHERE id = 1;
UPDATE lecturer_courses SET session_type = 'Lecture', semester = 'Second Semester' WHERE id = 2;
UPDATE lecturer_courses SET session_type = 'Lecture', semester = 'Second Semester' WHERE id = 3;
UPDATE lecturer_courses SET session_type = 'Practical', semester = 'Second Semester' WHERE id = 4;
UPDATE lecturer_courses SET session_type = 'Practical', semester = 'Second Semester' WHERE id = 5;
UPDATE lecturer_courses SET session_type = 'Practical', semester = 'Second Semester' WHERE id = 6;
UPDATE lecturer_courses SET session_type = 'Lecture', semester = 'Second Semester' WHERE id = 7;

/* Add missing lecturers while recognizing the supplied name variants. */
INSERT INTO lecturers (full_name) SELECT 'MR. A. A. ADEBAYO' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRAAADEBAYO', 'MRADEBAYO'));
INSERT INTO lecturers (full_name) SELECT 'MR G. OLADIMEJI' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRGOLADIMEJI'));
INSERT INTO lecturers (full_name) SELECT 'MR S.O KAREEM' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRSOKAREEM', 'MROKAREEM', 'MRKAREEM'));
INSERT INTO lecturers (full_name) SELECT 'DR A.A. ALARAN' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('DRAAALARAN', 'DRMAALARAN'));
INSERT INTO lecturers (full_name) SELECT 'MR. S.I SALAWU' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRSISALAWU', 'MRSALAWU'));
INSERT INTO lecturers (full_name) SELECT 'DR AWELEWA' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('DRAWELEWA'));
INSERT INTO lecturers (full_name) SELECT 'MAPCED' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MAPCED', 'MAPCEED'));
INSERT INTO lecturers (full_name) SELECT 'MR. O.A. AKANDE' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MROAAKANDE'));
INSERT INTO lecturers (full_name) SELECT 'MRS. B.C ADEBAYO' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRSBCADEBAYO'));
INSERT INTO lecturers (full_name) SELECT 'MISS A.A ADESINA' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MISSAAADESINA', 'MRSADESINA', 'MISSADESINA'));
INSERT INTO lecturers (full_name) SELECT 'MR. S. O. AKINLADE' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRSOAKINLADE', 'MROAKINLADE', 'MRAKINLADE'));
INSERT INTO lecturers (full_name) SELECT 'MRS O. R. OYELOWO' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRSOROYELOWO', 'MRSOYELOWO'));
INSERT INTO lecturers (full_name) SELECT 'MR. A. A. ODEKUNLE' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRAAODEKUNLE', 'MRODEKUNLE'));
INSERT INTO lecturers (full_name) SELECT 'STAT/MATH DEPT.' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('STAT/MATHDEPT'));
INSERT INTO lecturers (full_name) SELECT 'ENGINEERING DEPT' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('ENGINEERINGDEPT'));
INSERT INTO lecturers (full_name) SELECT 'GNS DEPT.' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('GNSDEPT'));
INSERT INTO lecturers (full_name) SELECT 'MR. AMOKUN' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRAMOKUN'));
INSERT INTO lecturers (full_name) SELECT 'MRS OSINKANMI' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRSOSINKANMI'));
INSERT INTO lecturers (full_name) SELECT 'MRS AKINLUYI' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRSAKINLUYI'));
INSERT INTO lecturers (full_name) SELECT 'MRS ADEBESIN' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRSADEBESIN'));
INSERT INTO lecturers (full_name) SELECT 'MR. FALETI' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRFALETI'));
INSERT INTO lecturers (full_name) SELECT 'Mr Moses' WHERE NOT EXISTS (SELECT 1 FROM lecturers WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRMOSES', 'MRMOSESADEBAYO'));

/* Add supplied assignments using each canonical lecturer or its known aliases. */

SET @lecturer_adebayo = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRAAADEBAYO', 'MRADEBAYO')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebayo, 'COM113', 'Lecture', 'First Semester'
WHERE @lecturer_adebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebayo AND course_code = 'COM113'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebayo, 'SWD315', 'Lecture', 'First Semester'
WHERE @lecturer_adebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebayo AND course_code = 'SWD315'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebayo, 'AIT311', 'Lecture', 'First Semester'
WHERE @lecturer_adebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebayo AND course_code = 'AIT311'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebayo, 'SWD416', 'Lecture', 'First Semester'
WHERE @lecturer_adebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebayo AND course_code = 'SWD416'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebayo, 'AIT314', 'Lecture', 'First Semester'
WHERE @lecturer_adebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebayo AND course_code = 'AIT314'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebayo, 'AIT322', 'Lecture', 'Second Semester'
WHERE @lecturer_adebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebayo AND course_code = 'AIT322'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebayo, 'NCC321', 'Lecture', 'Second Semester'
WHERE @lecturer_adebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebayo AND course_code = 'NCC321'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebayo, 'SWD322', 'Lecture', 'Second Semester'
WHERE @lecturer_adebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebayo AND course_code = 'SWD322'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebayo, 'SWD423', 'Lecture', 'Second Semester'
WHERE @lecturer_adebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebayo AND course_code = 'SWD423'
      AND session_type = 'Lecture' AND semester = 'Second Semester');

SET @lecturer_olatunji = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MROLATUNJI', 'MROTOLATUNJI')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_olatunji, 'COM115', 'Practical', 'First Semester'
WHERE @lecturer_olatunji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_olatunji AND course_code = 'COM115'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_olatunji, 'SWD312', 'Practical', 'First Semester'
WHERE @lecturer_olatunji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_olatunji AND course_code = 'SWD312'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_olatunji, 'NCC411', 'Practical', 'First Semester'
WHERE @lecturer_olatunji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_olatunji AND course_code = 'NCC411'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_olatunji, 'NCC412', 'Practical', 'First Semester'
WHERE @lecturer_olatunji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_olatunji AND course_code = 'NCC412'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_olatunji, 'COM126', 'Practical', 'Second Semester'
WHERE @lecturer_olatunji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_olatunji AND course_code = 'COM126'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_olatunji, 'COM224', 'Practical', 'Second Semester'
WHERE @lecturer_olatunji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_olatunji AND course_code = 'COM224'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_olatunji, 'COM123', 'Practical', 'Second Semester'
WHERE @lecturer_olatunji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_olatunji AND course_code = 'COM123'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_olatunji, 'SWD322', 'Practical', 'Second Semester'
WHERE @lecturer_olatunji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_olatunji AND course_code = 'SWD322'
      AND session_type = 'Practical' AND semester = 'Second Semester');

SET @lecturer_paul = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRPAUL', 'MRFPAUL')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_paul, 'COM212', 'Practical', 'First Semester'
WHERE @lecturer_paul IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_paul AND course_code = 'COM212'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_paul, 'COM215', 'Practical', 'First Semester'
WHERE @lecturer_paul IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_paul AND course_code = 'COM215'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_paul, 'AIT313', 'Practical', 'First Semester'
WHERE @lecturer_paul IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_paul AND course_code = 'AIT313'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_paul, 'SWD411', 'Practical', 'First Semester'
WHERE @lecturer_paul IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_paul AND course_code = 'SWD411'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_paul, 'COM125', 'Practical', 'Second Semester'
WHERE @lecturer_paul IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_paul AND course_code = 'COM125'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_paul, 'COM225', 'Practical', 'Second Semester'
WHERE @lecturer_paul IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_paul AND course_code = 'COM225'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_paul, 'COM221', 'Practical', 'Second Semester'
WHERE @lecturer_paul IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_paul AND course_code = 'COM221'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_paul, 'NCC325', 'Practical', 'Second Semester'
WHERE @lecturer_paul IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_paul AND course_code = 'NCC325'
      AND session_type = 'Practical' AND semester = 'Second Semester');

SET @lecturer_awelewa = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('DRAWELEWA')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_awelewa, 'GNS301', 'Lecture', 'First Semester'
WHERE @lecturer_awelewa IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_awelewa AND course_code = 'GNS301'
      AND session_type = 'Lecture' AND semester = 'First Semester');

SET @lecturer_salawu = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRSALAWU', 'MRSISALAWU')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_salawu, 'NCC313', 'Lecture', 'First Semester'
WHERE @lecturer_salawu IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_salawu AND course_code = 'NCC313'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_salawu, 'SWD412', 'Lecture', 'First Semester'
WHERE @lecturer_salawu IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_salawu AND course_code = 'SWD412'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_salawu, 'SWD311', 'Lecture', 'First Semester'
WHERE @lecturer_salawu IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_salawu AND course_code = 'SWD311'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_salawu, 'AIT312', 'Lecture', 'Second Semester'
WHERE @lecturer_salawu IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_salawu AND course_code = 'AIT312'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_salawu, 'SWD421', 'Lecture', 'Second Semester'
WHERE @lecturer_salawu IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_salawu AND course_code = 'SWD421'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_salawu, 'COM227', 'Lecture', 'Second Semester'
WHERE @lecturer_salawu IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_salawu AND course_code = 'COM227'
      AND session_type = 'Lecture' AND semester = 'Second Semester');

SET @lecturer_alaran = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('DRAAALARAN', 'DRMAALARAN')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_alaran, 'NCC316', 'Lecture', 'First Semester'
WHERE @lecturer_alaran IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_alaran AND course_code = 'NCC316'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_alaran, 'SWD312', 'Lecture', 'First Semester'
WHERE @lecturer_alaran IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_alaran AND course_code = 'SWD312'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_alaran, 'SWD411', 'Lecture', 'First Semester'
WHERE @lecturer_alaran IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_alaran AND course_code = 'SWD411'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_alaran, 'NCC412', 'Lecture', 'First Semester'
WHERE @lecturer_alaran IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_alaran AND course_code = 'NCC412'
      AND session_type = 'Lecture' AND semester = 'First Semester');

SET @lecturer_oladimeji = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRGOLADIMEJI')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_oladimeji, 'NCC313', 'Practical', 'First Semester'
WHERE @lecturer_oladimeji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_oladimeji AND course_code = 'NCC313'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_oladimeji, 'SWD311', 'Practical', 'First Semester'
WHERE @lecturer_oladimeji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_oladimeji AND course_code = 'SWD311'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_oladimeji, 'SWD412', 'Practical', 'First Semester'
WHERE @lecturer_oladimeji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_oladimeji AND course_code = 'SWD412'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_oladimeji, 'NCC414', 'Practical', 'First Semester'
WHERE @lecturer_oladimeji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_oladimeji AND course_code = 'NCC414'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_oladimeji, 'CYS412', 'Practical', 'First Semester'
WHERE @lecturer_oladimeji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_oladimeji AND course_code = 'CYS412'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_oladimeji, 'SWD421', 'Practical', 'Second Semester'
WHERE @lecturer_oladimeji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_oladimeji AND course_code = 'SWD421'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_oladimeji, 'NCC423', 'Practical', 'Second Semester'
WHERE @lecturer_oladimeji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_oladimeji AND course_code = 'NCC423'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_oladimeji, 'NCC421', 'Practical', 'Second Semester'
WHERE @lecturer_oladimeji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_oladimeji AND course_code = 'NCC421'
      AND session_type = 'Practical' AND semester = 'Second Semester');

SET @lecturer_kareem = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRSOKAREEM', 'MROKAREEM', 'MRKAREEM')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_kareem, 'SWD316', 'Practical', 'First Semester'
WHERE @lecturer_kareem IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_kareem AND course_code = 'SWD316'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_kareem, 'NCC311', 'Practical', 'First Semester'
WHERE @lecturer_kareem IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_kareem AND course_code = 'NCC311'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_kareem, 'SWD315', 'Practical', 'First Semester'
WHERE @lecturer_kareem IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_kareem AND course_code = 'SWD315'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_kareem, 'SWD327', 'Lecture', 'Second Semester'
WHERE @lecturer_kareem IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_kareem AND course_code = 'SWD327'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_kareem, 'NCC321', 'Practical', 'Second Semester'
WHERE @lecturer_kareem IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_kareem AND course_code = 'NCC321'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_kareem, 'NCC422', 'Practical', 'Second Semester'
WHERE @lecturer_kareem IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_kareem AND course_code = 'NCC422'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_kareem, 'SWD423', 'Practical', 'Second Semester'
WHERE @lecturer_kareem IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_kareem AND course_code = 'SWD423'
      AND session_type = 'Practical' AND semester = 'Second Semester');

SET @lecturer_faleti = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRFALETI')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_faleti, 'GNS401', 'Lecture', 'First Semester'
WHERE @lecturer_faleti IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_faleti AND course_code = 'GNS401'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_faleti, 'GNS201', 'Lecture', 'First Semester'
WHERE @lecturer_faleti IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_faleti AND course_code = 'GNS201'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_faleti, 'GNS202', 'Lecture', 'Second Semester'
WHERE @lecturer_faleti IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_faleti AND course_code = 'GNS202'
      AND session_type = 'Lecture' AND semester = 'Second Semester');

SET @lecturer_orunsolu = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('DRORUNSOLU', 'DRAAORUNSOLU')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_orunsolu, 'CYS412', 'Lecture', 'First Semester'
WHERE @lecturer_orunsolu IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_orunsolu AND course_code = 'CYS412'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_orunsolu, 'AIT313', 'Lecture', 'First Semester'
WHERE @lecturer_orunsolu IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_orunsolu AND course_code = 'AIT313'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_orunsolu, 'COM111', 'Lecture', 'First Semester'
WHERE @lecturer_orunsolu IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_orunsolu AND course_code = 'COM111'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_orunsolu, 'SWD425', 'Lecture', 'Second Semester'
WHERE @lecturer_orunsolu IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_orunsolu AND course_code = 'SWD425'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_orunsolu, 'COM228', 'Lecture', 'Second Semester'
WHERE @lecturer_orunsolu IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_orunsolu AND course_code = 'COM228'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_orunsolu, 'CYS322', 'Lecture', 'Second Semester'
WHERE @lecturer_orunsolu IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_orunsolu AND course_code = 'CYS322'
      AND session_type = 'Lecture' AND semester = 'Second Semester');

SET @lecturer_mapced = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MAPCED', 'MAPCEED')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_mapced, 'ENT413', 'Lecture', 'First Semester'
WHERE @lecturer_mapced IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_mapced AND course_code = 'ENT413'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_mapced, 'EED216', 'Lecture', 'First Semester'
WHERE @lecturer_mapced IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_mapced AND course_code = 'EED216'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_mapced, 'ENT126', 'Lecture', 'Second Semester'
WHERE @lecturer_mapced IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_mapced AND course_code = 'ENT126'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_mapced, 'ENT326', 'Lecture', 'Second Semester'
WHERE @lecturer_mapced IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_mapced AND course_code = 'ENT326'
      AND session_type = 'Lecture' AND semester = 'Second Semester');

SET @lecturer_adebesin = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRADEBESIN', 'MRAAADEBESIN')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebesin, 'COM112', 'Practical', 'First Semester'
WHERE @lecturer_adebesin IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebesin AND course_code = 'COM112'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebesin, 'COM214', 'Practical', 'First Semester'
WHERE @lecturer_adebesin IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebesin AND course_code = 'COM214'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebesin, 'NCC314', 'Practical', 'First Semester'
WHERE @lecturer_adebesin IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebesin AND course_code = 'NCC314'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebesin, 'SWD413', 'Practical', 'First Semester'
WHERE @lecturer_adebesin IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebesin AND course_code = 'SWD413'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebesin, 'AIT313', 'Practical', 'Second Semester'
WHERE @lecturer_adebesin IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebesin AND course_code = 'AIT313'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebesin, 'COM223', 'Practical', 'Second Semester'
WHERE @lecturer_adebesin IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebesin AND course_code = 'COM223'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebesin, 'AIT322', 'Lecture', 'Second Semester'
WHERE @lecturer_adebesin IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebesin AND course_code = 'AIT322'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebesin, 'CYS322', 'Practical', 'Second Semester'
WHERE @lecturer_adebesin IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebesin AND course_code = 'CYS322'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adebesin, 'NCC424', 'Practical', 'Second Semester'
WHERE @lecturer_adebesin IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adebesin AND course_code = 'NCC424'
      AND session_type = 'Practical' AND semester = 'Second Semester');

SET @lecturer_akande = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MROAAKANDE')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_akande, 'COM112', 'Lecture', 'First Semester'
WHERE @lecturer_akande IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_akande AND course_code = 'COM112'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_akande, 'COM212', 'Lecture', 'First Semester'
WHERE @lecturer_akande IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_akande AND course_code = 'COM212'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_akande, 'COM213', 'Lecture', 'First Semester'
WHERE @lecturer_akande IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_akande AND course_code = 'COM213'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_akande, 'COM122', 'Lecture', 'Second Semester'
WHERE @lecturer_akande IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_akande AND course_code = 'COM122'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_akande, 'COM124', 'Lecture', 'Second Semester'
WHERE @lecturer_akande IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_akande AND course_code = 'COM124'
      AND session_type = 'Lecture' AND semester = 'Second Semester');

SET @lecturer_bcadebayo = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRSBCADEBAYO')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_bcadebayo, 'COM113', 'Practical', 'First Semester'
WHERE @lecturer_bcadebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_bcadebayo AND course_code = 'COM113'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_bcadebayo, 'AIT314', 'Practical', 'First Semester'
WHERE @lecturer_bcadebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_bcadebayo AND course_code = 'AIT314'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_bcadebayo, 'NCC413', 'Practical', 'First Semester'
WHERE @lecturer_bcadebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_bcadebayo AND course_code = 'NCC413'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_bcadebayo, 'NCC316', 'Practical', 'First Semester'
WHERE @lecturer_bcadebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_bcadebayo AND course_code = 'NCC316'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_bcadebayo, 'SWD313', 'Practical', 'First Semester'
WHERE @lecturer_bcadebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_bcadebayo AND course_code = 'SWD313'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_bcadebayo, 'SWD416', 'Practical', 'First Semester'
WHERE @lecturer_bcadebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_bcadebayo AND course_code = 'SWD416'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_bcadebayo, 'COM111', 'Practical', 'First Semester'
WHERE @lecturer_bcadebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_bcadebayo AND course_code = 'COM111'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_bcadebayo, 'NCC324', 'Practical', 'Second Semester'
WHERE @lecturer_bcadebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_bcadebayo AND course_code = 'NCC324'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_bcadebayo, 'SWD323', 'Practical', 'Second Semester'
WHERE @lecturer_bcadebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_bcadebayo AND course_code = 'SWD323'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_bcadebayo, 'SWD324', 'Practical', 'Second Semester'
WHERE @lecturer_bcadebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_bcadebayo AND course_code = 'SWD324'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_bcadebayo, 'SWD321', 'Practical', 'Second Semester'
WHERE @lecturer_bcadebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_bcadebayo AND course_code = 'SWD321'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_bcadebayo, 'SWD425', 'Practical', 'Second Semester'
WHERE @lecturer_bcadebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_bcadebayo AND course_code = 'SWD425'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_bcadebayo, 'COM122', 'Practical', 'Second Semester'
WHERE @lecturer_bcadebayo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_bcadebayo AND course_code = 'COM122'
      AND session_type = 'Practical' AND semester = 'Second Semester');

SET @lecturer_adesina = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MISSAAADESINA', 'MRSADESINA', 'MISSADESINA')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adesina, 'COM215', 'Lecture', 'First Semester'
WHERE @lecturer_adesina IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adesina AND course_code = 'COM215'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adesina, 'NCC315', 'Lecture', 'First Semester'
WHERE @lecturer_adesina IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adesina AND course_code = 'NCC315'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adesina, 'NCC312', 'Lecture', 'First Semester'
WHERE @lecturer_adesina IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adesina AND course_code = 'NCC312'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adesina, 'COM125', 'Lecture', 'Second Semester'
WHERE @lecturer_adesina IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adesina AND course_code = 'COM125'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_adesina, 'SWD424', 'Lecture', 'Second Semester'
WHERE @lecturer_adesina IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_adesina AND course_code = 'SWD424'
      AND session_type = 'Lecture' AND semester = 'Second Semester');

SET @lecturer_akinlade = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRSOAKINLADE', 'MROAKINLADE', 'MRAKINLADE')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_akinlade, 'NCC314', 'Lecture', 'First Semester'
WHERE @lecturer_akinlade IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_akinlade AND course_code = 'NCC314'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_akinlade, 'AIT321', 'Lecture', 'First Semester'
WHERE @lecturer_akinlade IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_akinlade AND course_code = 'AIT321'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_akinlade, 'NCC414', 'Lecture', 'First Semester'
WHERE @lecturer_akinlade IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_akinlade AND course_code = 'NCC414'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_akinlade, 'SWD321', 'Lecture', 'Second Semester'
WHERE @lecturer_akinlade IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_akinlade AND course_code = 'SWD321'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_akinlade, 'NCC423', 'Lecture', 'Second Semester'
WHERE @lecturer_akinlade IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_akinlade AND course_code = 'NCC423'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_akinlade, 'COM226', 'Lecture', 'Second Semester'
WHERE @lecturer_akinlade IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_akinlade AND course_code = 'COM226'
      AND session_type = 'Lecture' AND semester = 'Second Semester');

SET @lecturer_oyelowo = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRSOROYELOWO', 'MRSOYELOWO')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_oyelowo, 'SWD313', 'Lecture', 'First Semester'
WHERE @lecturer_oyelowo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_oyelowo AND course_code = 'SWD313'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_oyelowo, 'NCC413', 'Lecture', 'First Semester'
WHERE @lecturer_oyelowo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_oyelowo AND course_code = 'NCC413'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_oyelowo, 'NCC411', 'Lecture', 'First Semester'
WHERE @lecturer_oyelowo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_oyelowo AND course_code = 'NCC411'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_oyelowo, 'NCC311', 'Lecture', 'First Semester'
WHERE @lecturer_oyelowo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_oyelowo AND course_code = 'NCC311'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_oyelowo, 'SWD415', 'Lecture', 'First Semester'
WHERE @lecturer_oyelowo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_oyelowo AND course_code = 'SWD415'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_oyelowo, 'NCC422', 'Lecture', 'Second Semester'
WHERE @lecturer_oyelowo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_oyelowo AND course_code = 'NCC422'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_oyelowo, 'SWD326', 'Lecture', 'Second Semester'
WHERE @lecturer_oyelowo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_oyelowo AND course_code = 'SWD326'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_oyelowo, 'NCC325', 'Lecture', 'Second Semester'
WHERE @lecturer_oyelowo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_oyelowo AND course_code = 'NCC325'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_oyelowo, 'SWD422', 'Lecture', 'Second Semester'
WHERE @lecturer_oyelowo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_oyelowo AND course_code = 'SWD422'
      AND session_type = 'Lecture' AND semester = 'Second Semester');

SET @lecturer_moses = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRMOSES', 'MRMOSESADEBAYO')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_moses, 'NCC314', 'Practical', 'First Semester'
WHERE @lecturer_moses IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_moses AND course_code = 'NCC314'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_moses, 'COM213', 'Practical', 'First Semester'
WHERE @lecturer_moses IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_moses AND course_code = 'COM213'
      AND session_type = 'Practical' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_moses, 'COM121', 'Practical', 'Second Semester'
WHERE @lecturer_moses IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_moses AND course_code = 'COM121'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_moses, 'COM226', 'Practical', 'Second Semester'
WHERE @lecturer_moses IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_moses AND course_code = 'COM226'
      AND session_type = 'Practical' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_moses, 'COM124', 'Practical', 'Second Semester'
WHERE @lecturer_moses IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_moses AND course_code = 'COM124'
      AND session_type = 'Practical' AND semester = 'Second Semester');

SET @lecturer_odekunle = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRAAODEKUNLE', 'MRODEKUNLE')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_odekunle, 'SWD413', 'Lecture', 'First Semester'
WHERE @lecturer_odekunle IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_odekunle AND course_code = 'SWD413'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_odekunle, 'SWD414', 'Lecture', 'First Semester'
WHERE @lecturer_odekunle IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_odekunle AND course_code = 'SWD414'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_odekunle, 'SWD316', 'Lecture', 'First Semester'
WHERE @lecturer_odekunle IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_odekunle AND course_code = 'SWD316'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_odekunle, 'COM225', 'Lecture', 'Second Semester'
WHERE @lecturer_odekunle IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_odekunle AND course_code = 'COM225'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_odekunle, 'SWD324', 'Lecture', 'Second Semester'
WHERE @lecturer_odekunle IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_odekunle AND course_code = 'SWD324'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_odekunle, 'SWD323', 'Lecture', 'Second Semester'
WHERE @lecturer_odekunle IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_odekunle AND course_code = 'SWD323'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_odekunle, 'NCC421', 'Lecture', 'Second Semester'
WHERE @lecturer_odekunle IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_odekunle AND course_code = 'NCC421'
      AND session_type = 'Lecture' AND semester = 'Second Semester');

SET @lecturer_statmath = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('STAT/MATHDEPT')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_statmath, 'COM216', 'Lecture', 'First Semester'
WHERE @lecturer_statmath IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_statmath AND course_code = 'COM216'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_statmath, 'MTH111', 'Lecture', 'First Semester'
WHERE @lecturer_statmath IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_statmath AND course_code = 'MTH111'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_statmath, 'STA314', 'Lecture', 'First Semester'
WHERE @lecturer_statmath IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_statmath AND course_code = 'STA314'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_statmath, 'COM114', 'Lecture', 'First Semester'
WHERE @lecturer_statmath IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_statmath AND course_code = 'COM114'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_statmath, 'STA311', 'Lecture', 'First Semester'
WHERE @lecturer_statmath IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_statmath AND course_code = 'STA311'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_statmath, 'NCC323', 'Lecture', 'Second Semester'
WHERE @lecturer_statmath IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_statmath AND course_code = 'NCC323'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_statmath, 'SWD325', 'Lecture', 'Second Semester'
WHERE @lecturer_statmath IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_statmath AND course_code = 'SWD325'
      AND session_type = 'Lecture' AND semester = 'Second Semester');

SET @lecturer_engineering = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('ENGINEERINGDEPT')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_engineering, 'COM214', 'Lecture', 'First Semester'
WHERE @lecturer_engineering IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_engineering AND course_code = 'COM214'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_engineering, 'COM126', 'Lecture', 'Second Semester'
WHERE @lecturer_engineering IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_engineering AND course_code = 'COM126'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_engineering, 'COM223', 'Lecture', 'Second Semester'
WHERE @lecturer_engineering IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_engineering AND course_code = 'COM223'
      AND session_type = 'Lecture' AND semester = 'Second Semester');

SET @lecturer_gnsdept = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('GNSDEPT')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_gnsdept, 'GNS111', 'Lecture', 'First Semester'
WHERE @lecturer_gnsdept IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_gnsdept AND course_code = 'GNS111'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_gnsdept, 'GNS101', 'Lecture', 'First Semester'
WHERE @lecturer_gnsdept IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_gnsdept AND course_code = 'GNS101'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_gnsdept, 'GNS128/121', 'Lecture', 'Second Semester'
WHERE @lecturer_gnsdept IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_gnsdept AND course_code = 'GNS128/121'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_gnsdept, 'GNS302', 'Lecture', 'Second Semester'
WHERE @lecturer_gnsdept IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_gnsdept AND course_code = 'GNS302'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_gnsdept, 'GNS228', 'Lecture', 'Second Semester'
WHERE @lecturer_gnsdept IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_gnsdept AND course_code = 'GNS228'
      AND session_type = 'Lecture' AND semester = 'Second Semester');

SET @lecturer_raji = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRRAJI', 'MRTARAJI')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_raji, 'COM115', 'Lecture', 'First Semester'
WHERE @lecturer_raji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_raji AND course_code = 'COM115'
      AND session_type = 'Lecture' AND semester = 'First Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_raji, 'COM221', 'Lecture', 'Second Semester'
WHERE @lecturer_raji IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_raji AND course_code = 'COM221'
      AND session_type = 'Lecture' AND semester = 'Second Semester');

SET @lecturer_amokun = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRAMOKUN')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_amokun, 'COM121', 'Lecture', 'Second Semester'
WHERE @lecturer_amokun IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_amokun AND course_code = 'COM121'
      AND session_type = 'Lecture' AND semester = 'Second Semester');
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_amokun, 'COM224', 'Lecture', 'Second Semester'
WHERE @lecturer_amokun IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_amokun AND course_code = 'COM224'
      AND session_type = 'Lecture' AND semester = 'Second Semester');

SET @lecturer_osinkanmi = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRSOSINKANMI')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_osinkanmi, 'COM123', 'Lecture', 'Second Semester'
WHERE @lecturer_osinkanmi IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_osinkanmi AND course_code = 'COM123'
      AND session_type = 'Lecture' AND semester = 'Second Semester');

SET @lecturer_akinluyi = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRSAKINLUYI')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_akinluyi, 'GNS102', 'Lecture', 'Second Semester'
WHERE @lecturer_akinluyi IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_akinluyi AND course_code = 'GNS102'
      AND session_type = 'Lecture' AND semester = 'Second Semester');

SET @lecturer_mrs_adebesin = (
    SELECT id FROM lecturers
    WHERE UPPER(REPLACE(REPLACE(full_name, '.', ''), ' ', '')) IN ('MRSADEBESIN')
    ORDER BY id
    LIMIT 1
);
INSERT INTO lecturer_courses (lecturer_id, course_code, session_type, semester)
SELECT @lecturer_mrs_adebesin, 'SWD422', 'Practical', 'Second Semester'
WHERE @lecturer_mrs_adebesin IS NOT NULL AND NOT EXISTS (SELECT 1 FROM lecturer_courses
    WHERE lecturer_id = @lecturer_mrs_adebesin AND course_code = 'SWD422'
      AND session_type = 'Practical' AND semester = 'Second Semester');

/* Require complete assignment details after all rows are populated. */
ALTER TABLE lecturer_courses
    MODIFY COLUMN session_type VARCHAR(20) NOT NULL,
    MODIFY COLUMN semester VARCHAR(20) NOT NULL;
