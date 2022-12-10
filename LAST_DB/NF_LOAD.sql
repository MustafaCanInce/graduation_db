-- ----------------------------------- LOAD DATA ------------------------------------------------
use examanalysis_nf;

show variables like "secure_file_priv";

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\z_students_denormalized.csv'
into table z_students_denormalized
columns terminated by ';';

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\z_exams_denormalized.csv'
into table z_exams_denormalized
columns terminated by ';';

insert into projects (project_id, project_name)
select project_id, project_name from z_students_denormalized group by project_id;

insert into clubs (club_id, club_name)
select club_id, club_name from z_students_denormalized group by club_name;

insert into schools (school_id, school_name, school_number)
select school_id, school_name, school_number from z_students_denormalized group by school_name;

insert into classes (class_id, class_name)
select class_id, class_name from z_students_denormalized group by class_name order by class_id;

insert into cities (city_id, city_name, city_zipcode)
select city_id, city_name, city_zipcode from z_students_denormalized group by city_name;

insert into states (state_id, state_name, state_zipcode)
select state_id, state_name, state_zipcode  from z_students_denormalized group by state_name;

insert into streets (street_id, street_name)
select street_id, street_name from z_students_denormalized group by street_name order by street_id;

insert into students (student_id, student_sid, student_name, student_surname,
student_gender, student_phone, student_birthday, guardian_name, guardian_surname, guardian_phone)
select student_id, student_sid, student_name, student_surname, student_gender, student_phone,
student_birthday, guardian_name, guardian_surname, guardian_phone from z_students_denormalized;

insert into exams_names (name_id, exam_name)
select name_id, exam_name from z_exams_denormalized group by exam_name;

insert into teachers (teacher_id, teacher_name)
select teacher_id, teacher_name from z_exams_denormalized group by teacher_id;

insert into exams (exam_id, teacher_id, optic_number, exam_date )
select exam_id, teacher_id, optic_number, exam_date from z_exams_denormalized group by exam_id;

insert into examsofstudentsdetails (student_id, exam_id, booklet, student_answer, answer_key)
select student_id, exam_id, booklet, student_answer, answer_key from z_exams_denormalized;

insert into students_has_classes
select student_id, class_id from z_students_denormalized;

insert into students_has_clubs
select student_id, club_id from z_students_denormalized;

insert into students_has_projects
select student_id, project_id from z_students_denormalized;

insert into students_has_cities
select student_id, city_id from z_students_denormalized;

insert into students_has_states
select student_id, state_id from z_students_denormalized;

insert into students_has_streets
select student_id, street_id from z_students_denormalized;

insert into exams_has_exams_names
select exam_id, name_id from z_exams_denormalized;

insert into exams_has_teachers
select exam_id, teacher_id from z_exams_denormalized;
