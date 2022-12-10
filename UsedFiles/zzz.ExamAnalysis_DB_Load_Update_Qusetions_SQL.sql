#1 #################################### LOAD DATA ##############################################
use examanalysis_db;
#2
show variables like "secure_file_priv";

#3 #5
select * from z_students_denormalized;

#4
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\z_students_denormalized.csv'
into table z_students_denormalized
columns terminated by ';';

#6 #8
select * from z_exams_denormalized;

#7
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\z_exams_denormalized.csv'
into table z_exams_denormalized
columns terminated by ';';

#9 #11
select * from student_projects;

#10
insert into student_projects (project_id, project_name)
select project_id, project_name from z_students_denormalized group by project_id;

#12 #14
select * from student_clubs;

#13
insert into student_clubs (club_id, club_name)
select club_id, club_name from z_students_denormalized group by club_name;

#15 #17
select * from student_schools;

#16
insert into student_schools (school_id, school_name, school_number)
select school_id, school_name, school_number from z_students_denormalized group by school_name;

#18 #20
select * from student_classes;

#19
insert into student_classes (class_id, class_name)
select class_id, class_name from z_students_denormalized group by class_name order by class_id;

#21 #23
select * from cities;

#22
insert into cities (city_id, city_name, city_zipcode)
select city_id, city_name, city_zipcode from z_students_denormalized group by city_name;

#24 #26
select * from states;

#25
insert into states (state_id, state_name, state_zipcode)
select state_id, state_name, state_zipcode  from z_students_denormalized group by state_name;

#27 #29
select * from streets;

#28
insert into streets (street_id, street_name)
select street_id, street_name from z_students_denormalized group by street_name order by street_id;

#30 #32
select * from students;

#31
insert into students (student_id, class_id, school_id, club_id, project_id, city_id, state_id, street_id, student_sid, student_name, student_surname,
student_gender, student_phone, student_birthday, guardian_name, guardian_surname, guardian_phone)
select student_id, class_id, school_id, club_id, project_id, city_id, state_id, street_id, student_sid, student_name, student_surname,
student_gender, student_phone, student_birthday, guardian_name, guardian_surname, guardian_phone from z_students_denormalized;

#33 #35
select * from exams_names;

#34
insert into exams_names (exam_name_id, exam_name)
select exam_name_id, exam_name from z_exams_denormalized group by exam_name;

#36 #38
select * from teachers_names;

#37
insert into teachers_names (teacher_id, teacher_name)
select teacher_id, teacher_name from z_exams_denormalized group by teacher_id;

#39 #41
select * from exams;

#40
insert into exams (exam_id, exam_name_id, teacher_id, optic_number, exam_date)
select exam_id, exam_name_id, teacher_id, optic_number, exam_date from z_exams_denormalized group by exam_id;

#42 #44
select * from examsofstudentsdetails;

#43
insert into examsofstudentsdetails (student_id, exam_id, booklet, student_answer, answer_key)
select student_id, exam_id, booklet, student_answer, answer_key from z_exams_denormalized;

############################################# PROCEDURES & FUNCTIONS #################################################
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `gradeCalculateProcedure`(IN student varchar(255), IN answer varchar(255))
BEGIN
		DECLARE strt INT DEFAULT 0 ;
		DECLARE ende INT DEFAULT length(answer) ;
        DECLARE c, w, b INT DEFAULT 0;
        DECLARE n, g FLOAT;
        DECLARE s, a CHAR;
        
		my_loop: LOOP
			SET strt=strt+1;
			SET @s = SUBSTR(student,strt,1);
            SET @a = SUBSTR(answer,strt,1);
            
			IF @s = ' ' THEN
				SET b=b+1;
            ELSEIF @s = @a THEN
				SET c=c+1;
			ELSE
				SET w=w+1;
			END IF;
            
			IF strt=ende THEN
				LEAVE my_loop;
			END IF;
		END LOOP my_loop;
        SET n = (c - w / 4);
        SET g = (n * 5);
        SELECT c AS "NUMBER OF CORRECTS", w AS "NUMBER OF WRONGS", b AS "NUMBER OF BLANKS", n AS "NUMBER OF NETS", g AS "GRADE";
   END //

CREATE DEFINER=`root`@`localhost` FUNCTION `blankCalculateFunction`(  
    student VARCHAR(255), answer VARCHAR(255)
) RETURNS float
    DETERMINISTIC
BEGIN  
		DECLARE strt INT DEFAULT 0;
		DECLARE ende INT DEFAULT length(answer);
        DECLARE b, c, w INT DEFAULT 0;
        DECLARE n, g FLOAT;
        DECLARE s, a CHAR;
		my_loop: LOOP
			SET strt=strt+1;
			SET @s = SUBSTR(student, strt, 1);
            SET @a = SUBSTR(answer, strt, 1);
			IF @s = ' ' THEN
				SET b=b+1;
            ELSEIF @s = @a THEN
				SET c=c+1;
			ELSE
				SET w=w+1;
			END IF;
			IF strt=ende THEN
				LEAVE my_loop;
			END IF;
		END LOOP my_loop;
		SET n=(c - w / 4);
        SET g=(n * 5);
    RETURN (b);
END //

CREATE DEFINER=`root`@`localhost` FUNCTION `correctCalculateFunction`(  
    student VARCHAR(255), answer VARCHAR(255)
) RETURNS float
    DETERMINISTIC
BEGIN  
		DECLARE strt INT DEFAULT 0;
		DECLARE ende INT DEFAULT length(answer);
        DECLARE b, c, w INT DEFAULT 0;
        DECLARE n, g FLOAT;
        DECLARE s, a CHAR;
		my_loop: LOOP
			SET strt=strt+1;
			SET @s = SUBSTR(student, strt, 1);
            SET @a = SUBSTR(answer, strt, 1);
			IF @s = ' ' THEN
				SET b=b+1;
            ELSEIF @s = @a THEN
				SET c=c+1;
			ELSE
				SET w=w+1;
			END IF;
			IF strt=ende THEN
				LEAVE my_loop;
			END IF;
		END LOOP my_loop;
		SET n=(c - w / 4);
        SET g=(n * 5);
    RETURN (c);
END //

CREATE DEFINER=`root`@`localhost` FUNCTION `wrongCalculateFunction`(  
    student VARCHAR(255), answer VARCHAR(255)
) RETURNS float
    DETERMINISTIC
BEGIN  
		DECLARE strt INT DEFAULT 0;
		DECLARE ende INT DEFAULT length(answer);
        DECLARE b, c, w INT DEFAULT 0;
        DECLARE n, g FLOAT;
        DECLARE s, a CHAR;
		my_loop: LOOP
			SET strt=strt+1;
			SET @s = SUBSTR(student, strt, 1);
            SET @a = SUBSTR(answer, strt, 1);
			IF @s = ' ' THEN
				SET b=b+1;
            ELSEIF @s = @a THEN
				SET c=c+1;
			ELSE
				SET w=w+1;
			END IF;
			IF strt=ende THEN
				LEAVE my_loop;
			END IF;
		END LOOP my_loop;
		SET n=(c - w / 4);
        SET g=(n * 5);
    RETURN (w);
END //

CREATE DEFINER=`root`@`localhost` FUNCTION `netCalculateFunction`(  
    student VARCHAR(255), answer VARCHAR(255)
) RETURNS float
    DETERMINISTIC
BEGIN  
		DECLARE strt INT DEFAULT 0;
		DECLARE ende INT DEFAULT length(answer);
        DECLARE b, c, w INT DEFAULT 0;
        DECLARE n, g FLOAT;
        DECLARE s, a CHAR;
		my_loop: LOOP
			SET strt=strt+1;
			SET @s = SUBSTR(student, strt, 1);
            SET @a = SUBSTR(answer, strt, 1);
			IF @s = ' ' THEN
				SET b=b+1;
            ELSEIF @s = @a THEN
				SET c=c+1;
			ELSE
				SET w=w+1;
			END IF;
			IF strt=ende THEN
				LEAVE my_loop;
			END IF;
		END LOOP my_loop;
		SET n=(c - w / 4);
        SET g=(n * 5);
    RETURN (n);
END //

CREATE DEFINER=`root`@`localhost` FUNCTION `gradeCalculateFunction`(  
    student VARCHAR(255), answer VARCHAR(255)
) RETURNS float
    DETERMINISTIC
BEGIN  
		DECLARE strt INT DEFAULT 0;
		DECLARE ende INT DEFAULT length(answer);
        DECLARE b, c, w INT DEFAULT 0;
        DECLARE n, g FLOAT;
        DECLARE s, a CHAR;
		my_loop: LOOP
			SET strt=strt+1;
			SET @s = SUBSTR(student, strt, 1);
            SET @a = SUBSTR(answer, strt, 1);
			IF @s = ' ' THEN
				SET b=b+1;
            ELSEIF @s = @a THEN
				SET c=c+1;
			ELSE
				SET w=w+1;
			END IF;
			IF strt=ende THEN
				LEAVE my_loop;
			END IF;
		END LOOP my_loop;
		SET n=(c - w / 4);
        SET g=(n * 5);
    RETURN (g);
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `percentCalculateProcedure`(IN indate DATE, IN inlesson varchar(255), IN inclass varchar(255) )
BEGIN
DECLARE totalcount, entercount, noenterCount, perEnter, perNoenter FLOAT;

select count(students.student_id) into totalcount from students
left join student_classes on student_classes.class_id=students.class_id
where student_classes.class_name=inclass;

select count(students.student_id) into entercount from exams
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
left join student_classes on student_classes.class_id=students.class_id
where exams.exam_date=indate  and exams_names.exam_name=inlesson and student_classes.class_name=inclass;

set noenterCount=totalcount-entercount;
set perEnter=entercount/totalcount;
set perNoenter=noentercount/totalcount;

SELECT totalcount AS "CLASS SIZE", entercount AS "NUMBER OF EXAM TAKER", noenterCount AS "NUMBER OF EXAM NOT TAKER",
perEnter as "PERCENTAGE of EXAM TAKER", perNoenter as "PERCENTAGE of EXAM NOT TAKER";

END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `standartdeviationCalculate`(IN indate DATE, IN inlesson VARCHAR(45))
BEGIN
DECLARE counter INT DEFAULT 0;
DECLARE sd, gradeavg FLOAT DEFAULT 0;
DECLARE asname LONGTEXT;

select count(examsofstudentsdetails.grade) into counter from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date=indate and exams_names.exam_name=inlesson order by examsofstudentsdetails.grade;

select avg(examsofstudentsdetails.grade) into gradeavg from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date=indate and exams_names.exam_name=inlesson order by examsofstudentsdetails.grade;

select sqrt(sum(power(gradeavg-examsofstudentsdetails.grade,2))/(counter-1)) into sd from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date=indate and exams_names.exam_name=inlesson order by examsofstudentsdetails.grade;

select sd AS "STANDART DEVIATION";
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateGradeProcedure`()
BEGIN
	update examsofstudentsdetails
	set
		number_correct = correctCalculateFunction(student_answer, answer_key),
		number_wrong = wrongCalculateFunction(student_answer, answer_key),
		number_blank = blankCalculateFunction(student_answer, answer_key),
		number_net = netCalculateFunction(student_answer, answer_key),
		grade = gradeCalculateFunction(student_answer, answer_key);
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `medianCalculate`()
BEGIN
DECLARE counter, idNumber1, idNumber2, strt, median INT DEFAULT 0;
DECLARE grade1, grade2 FLOAT DEFAULT 0;
DECLARE isEven BOOLEAN DEFAULT FALSE;
DECLARE notlar LONGTEXT;

select count(examsofstudentsdetails.grade) into counter from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date="2021-05-05" and exams_names.exam_name="Chemistry" order by examsofstudentsdetails.grade;

if (counter % 2 = 0) then
	set isEven = true;
end if;
if (isEven) then
	set idNumber1 = counter/2;
    set idNumber2 = counter/2 + 1;
else
	set idNumber1 = counter / 2;
end if;
            
select concat_ws(";", notlar, exams_names.exam_name) from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date="2021-05-05" and exams_names.exam_name="Chemistry" order by examsofstudentsdetails.grade;

select counter, isEven, idNumber1, idNumber2, median, grade1, grade2, notlar;
END //
DELIMITER ;
##################################### UPDATE ##############################################
call updateGradeProcedure();
################################### QUESTIONS #############################################
## 1. What is the total number of female students among the students who took all the exams?
select count(student_id) as "Number of female students who took all exams:" from students 
where students.student_gender="F" and students.student_id in
(select student_id from examsofstudentsdetails);

## 2. What is the GPA of male students who take a given exam?
select avg(examsofstudentsdetails.grade) from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date="2020-01-01" and exams_names.exam_name="Math" and students.student_gender="M" order by students.student_name;

## 3. What is the minimum grade on a given exam?
select min(examsofstudentsdetails.grade) from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date="2020-01-01" and exams_names.exam_name="Math";

## 4. What is the interval length (max-min) of a given exam?
select max(examsofstudentsdetails.grade) - min(examsofstudentsdetails.grade) from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date="2020-01-01" and exams_names.exam_name="Math";

## 5. What is the arithmetic mean of the nets in a given exam?
select avg(examsofstudentsdetails.number_net) from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date="2020-01-01" and exams_names.exam_name="Math";

## 6. What is the standard deviation of a given exam?
call standartdeviationCalculate("2021-05-05", "Chemistry");

## 7. What is the median of a given exam?

select examsofstudentsdetails.grade from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date="2021-05-05" and exams_names.exam_name="Chemistry" order by examsofstudentsdetails.grade;

call medianCalculate();

## 8. What is the most repeated (mod) grade on a given exam?


## 9. What is the percentage of those who took and did not take the exam in a given group (for example, all 10th graders)?
call percentCalculateProcedure("2020-01-01", "Math", "12-F");

## 10. What is a list of students in a given exam?
select exams.exam_date, exams_names.exam_name, students.student_id, students.student_name, students.student_surname from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date="2020-01-01" and exams_names.exam_name="Math" order by students.student_name;

## 11. What is the total number of students in the classes?
select student_classes.class_name as "Class Name", count(students.class_id) as "Number of students"
from student_classes join students on student_classes.class_id = students.class_id 
group by student_classes.class_name
order by student_classes.class_name;

## 12. Who is the eldest of the students who took the exam?
select  students.student_name, students.student_surname, min(students.student_birthday) as "Birthday of eldest student"
from examsofstudentsdetails join students on examsofstudentsdetails.student_id=students.student_id;

## 13. What is the list of all students who took the exam on a given date?
select students.student_id ,students.student_name, students.student_surname
from examsofstudentsdetails join exams join students 
on examsofstudentsdetails.exam_id=exams.exam_id and students.student_id=examsofstudentsdetails.student_id
where exams.exam_date="2020-4-4"
order by students.student_name;


