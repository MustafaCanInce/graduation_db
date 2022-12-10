-- ExamAnalysis_DB_SQL
-- Adem VAROL - 200709078
-- Mustafa Can İNCE - 200709081
-- Cihan Sezer ÖZKAMER - 200709601 

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `examanalysis_DB` DEFAULT CHARACTER SET latin5 ;
USE `examanalysis_DB` ;

CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`students` (
  `student_id` INT NOT NULL,
  `class_id` INT NOT NULL,
  `school_id` INT NOT NULL,
  `club_id` INT NOT NULL,
  `project_id` INT NOT NULL,
  `city_id` INT NOT NULL,
  `state_id` INT NOT NULL,
  `street_id` INT NOT NULL,
  `student_sid` VARCHAR(11) NOT NULL,
  `student_name` VARCHAR(45) NOT NULL,
  `student_surname` VARCHAR(45) NOT NULL,
  `student_gender` CHAR(1) NOT NULL,
  `student_phone` VARCHAR(45) NOT NULL,
  `student_birthday` DATE NOT NULL,
  `guardian_name` VARCHAR(45) NOT NULL,
  `guardian_surname` VARCHAR(45) NOT NULL,
  `guardian_phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`student_id`, `class_id`, `school_id`, `club_id`, `project_id`, `city_id`, `state_id`, `street_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`student_classes` (
  `class_id` INT NOT NULL,
  `class_name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`class_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`student_schools` (
  `school_id` INT NOT NULL,
  `school_name` VARCHAR(45) NOT NULL,
  `school_number` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`school_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`student_clubs` (
  `club_id` INT NOT NULL,
  `club_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`club_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`student_projects` (
  `project_id` INT NOT NULL,
  `project_name` VARCHAR(45) NULL,
  PRIMARY KEY (`project_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`cities` (
  `city_id` INT NOT NULL,
  `city_name` VARCHAR(45) NOT NULL,
  `city_zipcode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`city_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`states` (
  `state_id` INT NOT NULL,
  `state_name` VARCHAR(45) NOT NULL,
  `state_zipcode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`state_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`streets` (
  `street_id` INT NOT NULL,
  `street_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`street_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`exams` (
  `exam_id` INT NOT NULL,
  `exam_name_id` INT NOT NULL,
  `teacher_id` INT NOT NULL,
  `optic_number` INT NOT NULL,
  `exam_date` DATE NOT NULL,
  PRIMARY KEY (`exam_id`, `exam_name_id`, `teacher_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`examsofstudentsdetails` (
  `details_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `exam_id` INT NOT NULL,
  `booklet` CHAR(1) NOT NULL,
  `student_answer` VARCHAR(255) NOT NULL,
  `answer_key` VARCHAR(255) NOT NULL,
  `number_correct` INT NULL,
  `number_wrong` INT NULL,
  `number_blank` INT NULL,
  `number_net` FLOAT NULL,
  `grade` FLOAT NULL,
  INDEX `fk_examsofstudentsdetails_students1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_examsofstudentsdetails_exams1_idx` (`exam_id` ASC) VISIBLE,
  PRIMARY KEY (`details_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`exams_names` (
  `exam_name_id` INT NOT NULL,
  `exam_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`exam_name_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`teachers_names` (
  `teacher_id` INT NOT NULL,
  `teacher_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`teacher_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`z_students_denormalized` (
  `student_id` INT NULL,
  `class_id` INT NULL,
  `class_name` VARCHAR(10) NULL,
  `school_id` INT NULL,
  `school_name` VARCHAR(45) NULL,
  `school_number` VARCHAR(10) NULL,
  `student_name` VARCHAR(45) NULL,
  `student_surname` VARCHAR(45) NULL,
  `student_gender` CHAR(1) NULL,
  `student_sid` VARCHAR(11) NULL,
  `student_phone` VARCHAR(45) NULL,
  `student_birthday` DATE NULL,
  `guardian_name` VARCHAR(45) NULL,
  `guardian_surname` VARCHAR(45) NULL,
  `guardian_phone` VARCHAR(45) NULL,
  `city_id` INT NULL,
  `city_name` VARCHAR(45) NULL,
  `city_zipcode` VARCHAR(45) NULL,
  `state_id` INT NULL,
  `state_name` VARCHAR(45) NULL,
  `state_zipcode` VARCHAR(45) NULL,
  `street_id` INT NULL,
  `street_name` VARCHAR(45) NULL,
  `club_id` INT NULL,
  `club_name` VARCHAR(45) NULL,
  `project_id` VARCHAR(45) NULL,
  `project_name` VARCHAR(45) NULL)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`z_exams_denormalized` (
  `student_id` INT NULL,
  `optic_number` INT NULL,
  `booklet` CHAR(1) NULL,
  `student_answer` VARCHAR(255) NULL,
  `answer_key` VARCHAR(255) NULL,
  `exam_id` INT NULL,
  `exam_name_id` INT NULL,
  `exam_name` VARCHAR(45) NULL,
  `exam_date` DATE NULL,
  `teacher_id` INT NULL,
  `teacher_name` VARCHAR(45) NULL)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- ----------------------------------- LOAD DATA ------------------------------------------------
use examanalysis_db;

show variables like "secure_file_priv";

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

-- --------------------------- VIEWS & PROCEDURES & FUNCTIONS ------------------------------
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
DROP TEMPORARY TABLE IF EXISTS my_temp_table;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `medianCalculate`(IN inDate DATE, IN inLesson varchar(255))
BEGIN
DECLARE counter, idNumber1, idNumber2, strt INT DEFAULT 0;
DECLARE grade1, grade2, median FLOAT DEFAULT 0;
DECLARE isEven BOOLEAN DEFAULT FALSE;

select count(examsofstudentsdetails.grade) into counter from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date=inDate and exams_names.exam_name=inLesson order by examsofstudentsdetails.grade;

if (counter % 2 = 0) then
	set isEven = true;
end if;
if (isEven) then
	set idNumber1 = counter/2;
    set idNumber2 = counter/2 + 1;
else
	set idNumber1 = counter / 2;
end if;

DROP TEMPORARY TABLE IF EXISTS my_temp_table;
CREATE TEMPORARY TABLE my_temp_table (median_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY)

select examsofstudentsdetails.grade from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date=inDate and exams_names.exam_name=inLesson order by examsofstudentsdetails.grade;

-- select * from my_temp_table;

select grade into grade1 from my_temp_table where median_id=idNumber1;
select grade into grade2 from my_temp_table where median_id=idNumber2;

if (grade2=0) then
	set median=grade1;
else
	set median=(grade1+grade2)/2;
end if;

-- select counter, isEven, idNumber1, idNumber2, grade1, grade2, median;
select median;

DROP TEMPORARY TABLE IF EXISTS my_temp_table;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `eldeststudent`(IN inDate DATE, IN inLesson varchar(255))
BEGIN
select CONCAT (students.student_name," ",students.student_surname) as "STUDENT NAME", min(students.student_birthday) as "BIRTHDAY OF ELDEST STUDENT" from exams 
left join examsofstudentsdetails on examsofstudentsdetails.exam_id=exams.exam_id
left join exams_names on exams_names.exam_name_id=exams.exam_name_id
left join students on examsofstudentsdetails.student_id=students.student_id
where exams.exam_date=inDate and exams_names.exam_name=inLesson;
END //
DELIMITER ;
-- ----------------------------------- UPDATE ----------------------------------------------
call updateGrades();
-- --------------------------------- QUESTIONS ---------------------------------------------
-- 1. What is the total number of female students among the students who took all the exams?
select * from sumoffemalestudents;

-- 2. What is the GPA of male/female students who take a given exam?
call gpaList("2020-01-01", "Math", "M");
call gpaList("2021-05-05", "Chemistry", "F");

-- 3. What is the minimum grade on a given exam?
call minGrade("2020-01-01", "Math");
call minGrade("2021-05-05", "Chemistry");

-- 4. What is the interval length (max-min) of a given exam?
call intervalLenght("2020-01-01", "Math");
call intervalLenght("2020-04-04", "Chemistry");

-- 5. What is the arithmetic mean of the nets in a given exam?
call wnaCalculate("2020-01-01","Math");
call wnaCalculate("2021-05-05", "Chemistry");

-- 6. What is the standard deviation of a given exam?
call standartdeviationCalculate("2021-05-05", "Chemistry");
call standartdeviationCalculate("2020-01-01","Math");

-- 7. What is the median of a given exam?
call medianCalculate("2021-05-05", "Chemistry");
call medianCalculate("2020-01-01","Math");

-- 8. What is the most repeated (mod) grade on a given exam?
call modCalculate("2020-01-01", "Math");
call modCalculate("2021-05-05", "Chemistry");

-- 9. What is the percentage of those who took and did not take the exam in a given group (for example, all 10th graders)?
call percentCalculate("2020-01-01", "Math", "12-F");
call percentCalculate("2020-04-04", "Chemistry", "11-D");

-- 10. What is a list of students in a given exam?
call examList("2020-01-01", "Math");
call examList("2020-04-04", "Chemistry");

-- 11. What is the total number of students in the classes?
select * from numberofclasses;

-- 12. Who is the eldest of the students who took a given exam?
call eldeststudent("2020-01-01", "Math");
call eldeststudent("2020-04-04", "Chemistry");

-- 13. What is the list of all students who took the exam on a given date?
call examlistwithDate("2021-05-05");
call examlistwithDate("2020-01-01");

/* ASK THIS
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
