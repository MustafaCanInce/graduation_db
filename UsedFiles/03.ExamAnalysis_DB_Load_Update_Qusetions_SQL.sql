##################################### LOAD DATA ##############################################
use examanalysis_db;

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\z_students_denormalized.csv'
into table z_students_denormalized
columns terminated by ';';

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\z_exams_denormalized.csv'
into table z_exams_denormalized
columns terminated by ';';

insert into student_projects (project_id, project_name)
select project_id, project_name from z_students_denormalized group by project_id;

insert into student_clubs (club_id, club_name)
select club_id, club_name from z_students_denormalized group by club_name;

insert into student_schools (school_id, school_name, school_number)
select school_id, school_name, school_number from z_students_denormalized group by school_name;

insert into student_classes (class_id, class_name)
select class_id, class_name from z_students_denormalized group by class_name order by class_id;

insert into cities (city_id, city_name, city_zipcode)
select city_id, city_name, city_zipcode from z_students_denormalized group by city_name;

insert into states (state_id, state_name, state_zipcode)
select state_id, state_name, state_zipcode  from z_students_denormalized group by state_name;

insert into streets (street_id, street_name)
select street_id, street_name from z_students_denormalized group by street_name order by street_id;

insert into students (student_id, class_id, school_id, club_id, project_id, city_id, state_id, street_id, student_sid, student_name, student_surname,
student_gender, student_phone, student_birthday, guardian_name, guardian_surname, guardian_phone)
select student_id, class_id, school_id, club_id, project_id, city_id, state_id, street_id, student_sid, student_name, student_surname,
student_gender, student_phone, student_birthday, guardian_name, guardian_surname, guardian_phone from z_students_denormalized;

insert into exams_names (exam_name_id, exam_name)
select exam_name_id, exam_name from z_exams_denormalized group by exam_name;

insert into teachers_names (teacher_id, teacher_name)
select teacher_id, teacher_name from z_exams_denormalized group by teacher_id;

insert into exams (exam_id, exam_name_id, teacher_id, optic_number, exam_date)
select exam_id, exam_name_id, teacher_id, optic_number, exam_date from z_exams_denormalized group by exam_id;

insert into examsofstudentsdetails (student_id, exam_id, booklet, student_answer, answer_key)
select student_id, exam_id, booklet, student_answer, answer_key from z_exams_denormalized;

############################ VIEWS & PROCEDURES & FUNCTIONS ###############################
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `eldeststudent` AS
    SELECT 
        `students`.`student_name` AS `student_name`,
        `students`.`student_surname` AS `student_surname`,
        MIN(`students`.`student_birthday`) AS `BIRTHDAY OF ELDEST STUDENT`
    FROM
        (`examsofstudentsdetails`
        JOIN `students` ON ((`examsofstudentsdetails`.`student_id` = `students`.`student_id`)));

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `numberofclasses` AS
    SELECT 
        `student_classes`.`class_name` AS `CLASS NAME`,
        COUNT(`students`.`class_id`) AS `NUMBER OF STUDENTS`
    FROM
        (`student_classes`
        JOIN `students` ON ((`student_classes`.`class_id` = `students`.`class_id`)))
    GROUP BY `student_classes`.`class_name`
    ORDER BY `student_classes`.`class_name`;
    
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `sumoffemalestudents` AS
    SELECT 
        COUNT(`students`.`student_id`) AS `NUMBER OF FEMALE STUDENTS`
    FROM
        `students`
    WHERE
        ((`students`.`student_gender` = 'F')
            AND `students`.`student_id` IN (SELECT 
                `examsofstudentsdetails`.`student_id`
            FROM
                `examsofstudentsdetails`));

DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `examlistwithDate`(IN inDate DATE)
BEGIN
select students.student_id as "STUDENT ID", CONCAT(students.student_name," ",students.student_surname) as "STUDENT NAME" from examsofstudentsdetails
left join students on examsofstudentsdetails.student_id=students.student_id
left join exams on exams.exam_id=examsofstudentsdetails.exam_id
left join exams_names on exams.exam_name_id=exams_names.exam_name_id
where exams.exam_date=inDate
order by students.student_name;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `minGrade`(IN inDate DATE, IN inLesson varchar(255))
BEGIN
select min(examsofstudentsdetails.grade) as "MINIMUM GRADE" from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date=inDate and exams_names.exam_name=inLesson;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `intervalLenght`(IN inDate DATE, IN inLesson varchar(255))
BEGIN
select max(examsofstudentsdetails.grade) - min(examsofstudentsdetails.grade) as "INTERVAL LENGHT"from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date=inDate and exams_names.exam_name=inLesson;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `modCalculate`(IN inDate DATE, IN inLesson varchar(255))
BEGIN
DROP TEMPORARY TABLE IF EXISTS my_temp_table;
CREATE TEMPORARY TABLE my_temp_table (mod_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY)
select examsofstudentsdetails.grade as Grades, count(examsofstudentsdetails.grade) as gCount  from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date=inDate and exams_names.exam_name=inLesson group by Grades order by gCount desc;

select grades as "MOD OF GRADES", gCount as "REPEAT COUNT" from my_temp_table where mod_id=1;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `medianCalculate`()
BEGIN
DROP TEMPORARY TABLE IF EXISTS my_temp_table;
CREATE TEMPORARY TABLE my_temp_table

select examsofstudentsdetails.grade from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date="2021-05-05" and exams_names.exam_name="Chemistry" order by examsofstudentsdetails.grade;

select * from my_temp_table;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `percentCalculate`(IN indate DATE, IN inlesson varchar(255), IN inclass varchar(255) )
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
where exams.exam_date=indate and exams_names.exam_name=inlesson and student_classes.class_name=inclass;

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `examList`(IN inDate DATE, IN inLesson varchar(255))
BEGIN
select students.student_id as "STUDENT ID", CONCAT(students.student_name," ",students.student_surname) as "STUDENT NAME" from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date=inDate and exams_names.exam_name=inLesson order by students.student_name;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `wnaCalculate`(IN inDate DATE, IN inLesson varchar(255))
BEGIN
select avg(examsofstudentsdetails.number_net) as "WEIGHTED NET AVERAGE" from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date=inDAte and exams_names.exam_name=inLesson;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `gpaList`(IN inDate DATE, IN inLesson varchar(255), IN inGender char)
BEGIN
select avg(examsofstudentsdetails.grade) as "GPA OF MALE/FEMALE STUDENTS" from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date=inDate and exams_names.exam_name=inLesson and students.student_gender=inGender order by students.student_name;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateGrades`()
BEGIN
	update examsofstudentsdetails
	set
		number_correct = correctCalculate(student_answer, answer_key),
		number_wrong = wrongCalculate(student_answer, answer_key),
		number_blank = blankCalculate(student_answer, answer_key),
		number_net = netCalculate(student_answer, answer_key),
		grade = gradeCalculate(student_answer, answer_key);
END //

CREATE DEFINER=`root`@`localhost` FUNCTION `blankCalculate`(  
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

CREATE DEFINER=`root`@`localhost` FUNCTION `correctCalculate`(  
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

CREATE DEFINER=`root`@`localhost` FUNCTION `wrongCalculate`(  
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

CREATE DEFINER=`root`@`localhost` FUNCTION `netCalculate`(  
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

CREATE DEFINER=`root`@`localhost` FUNCTION `gradeCalculate`(  
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
DELIMITER ;
##################################### UPDATE ##############################################
call updateGrades();
################################### QUESTIONS #############################################
## 1. What is the total number of female students among the students who took all the exams?
select * from sumoffemalestudents;

## 2. What is the GPA of male/female students who take a given exam?
call gpaList("2020-01-01", "Math", "M");

## 3. What is the minimum grade on a given exam?
call minGrade("2020-01-01", "Math");

## 4. What is the interval length (max-min) of a given exam?
call intervalLenght("2020-01-01", "Math");

## 5. What is the arithmetic mean of the nets in a given exam?
call wnaCalculate("2020-01-01","Math");

## 6. What is the standard deviation of a given exam?
call standartdeviationCalculate("2021-05-05", "Chemistry");

## 7. What is the median of a given exam?
call medianCalculate();

## 8. What is the most repeated (mod) grade on a given exam?
call modCalculate("2020-01-01", "Math");

## 9. What is the percentage of those who took and did not take the exam in a given group (for example, all 10th graders)?
call percentCalculate("2020-01-01", "Math", "12-F");

## 10. What is a list of students in a given exam?
call examList("2020-01-01", "Math");

## 11. What is the total number of students in the classes?
select * from numberofclasses;

## 12. Who is the eldest of the students who took the exam?
select * from eldeststudent;

## 13. What is the list of all students who took the exam on a given date?
call examlistwithDate("2021-05-05");

/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `gradeCalculate`(IN student varchar(255), IN answer varchar(255))
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
   END
*/




