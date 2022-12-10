-- INDEXLEMELER
select * from cities;
create unique index cityidx using btree on cities(city_id);

create unique index classesidx using btree on classes(class_id);

create unique index clubsidx using btree on clubs(club_id);

create unique index examsidx using btree on exams(exam_id);

create unique index exams_names using btree on exams_names(name_id);

create unique index examsofstudentsdetailsidx using btree on examsofstudentsdetails(details_id);

create unique index projectsidx using btree on projects(project_id);

create unique index schoolsidx using btree on schools(school_id);

create unique index statesidx using btree on states(state_id);

create unique index streetsidx using btree on streets(street_id);

create unique index studentsidx using btree on students(student_id);

create unique index teachersidx using btree on teachers(teacher_id);

-- VIEW, PROCEDURE, FUNCTIONS

select student_name,min(student_birthday) from students;
select * from eldest_student;

select * from students;

select * from classes;

select * from students_has_states;

select class_name,count(class_name) from students_has_classes
left join students on students_has_classes.student_id 
left join classes on students_has_classes.student_id
group by class_name;

select classes.class_name, count(students.student_id) from students left join students_has_classes on students.student_id=students_has_classes.student_id
left join classes on classes.class_id=students_has_classes.class_id
where classes.class_name= "09-A";

call numberofclass("09-A");

call gradeCalculateProcedure("DEAAEBCABEACD ECECEB", "DEAACECBEADEBDCCDEEB");

select * from examsofstudentsdetails;

call updateGrades();

call medianCalculate();

select count(grade) from examsofstudentsdetails order by grade;




## Adem VAROL - 200709078

-- select * from proteins;

-- EXPLAIN select * from proteins where pid like "5HT2C_HUMA%";
-- EXPLAIN select * from proteins where accession = "Q9UBA6";

-- create unique index idx1 using btree on proteins(pid);
-- alter table proteins add constraint acc_pk primary key (accession);

-- alter table proteins drop primary key;

-- CREATE DEFINER=`root`@`localhost` PROCEDURE `eldeststudent`(IN inDate DATE, IN inLesson varchar(255))
-- BEGIN
-- select CONCAT (students.student_name," ",students.student_surname) as "STUDENT NAME", min(students.student_birthday) as "BIRTHDAY OF ELDEST STUDENT" from exams 
-- left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
-- left join exams_names on exams_names.exam_name_id=exams.exam_name_id
-- left join students on examsofstudentsdetails.student_id=students.student_id
-- where exams.exam_date=inDate and exams_names.exam_name=inLesson;
-- END //
-- DELIMITER ;

select student_name from students 
where students.student_id = 20210001;


update students
set student_name = "ayşe"
where students.student_id = 20210001;

delete from students
where students.student_id = 20210001;

select * from students;

insert into students values(2022222, 11111111, "adem","varol","M",5585458596,"2000-00-00","mehmet","varol",5589697541);

select * from students
where students.student_id = 2022222;


