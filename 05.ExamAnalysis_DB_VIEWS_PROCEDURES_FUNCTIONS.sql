-- --------------------------- VIEWS & PROCEDURES & FUNCTIONS ------------------------------
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `examanalysis_db`.`numberofclasses` AS
    SELECT 
        `examanalysis_db`.`student_classes`.`class_name` AS `class_name`,
        COUNT(`examanalysis_db`.`student_classes`.`class_name`) AS `count(student_classes.class_name)`
    FROM
        ((`examanalysis_db`.`students`
        LEFT JOIN `examanalysis_db`.`students_has_classes` ON ((`examanalysis_db`.`students`.`student_id` = `examanalysis_db`.`students_has_classes`.`student_id`)))
        LEFT JOIN `examanalysis_db`.`student_classes` ON ((`examanalysis_db`.`student_classes`.`class_id` = `examanalysis_db`.`students_has_classes`.`class_id`)))
    GROUP BY `examanalysis_db`.`student_classes`.`class_name`
    ORDER BY `examanalysis_db`.`student_classes`.`class_name`

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `examanalysis_db`.`sumoffemalestudents` AS
    SELECT 
        COUNT(`examanalysis_db`.`students`.`student_id`) AS `NUMBER OF FEMALE STUDENTS`
    FROM
        `examanalysis_db`.`students`
    WHERE
        ((`examanalysis_db`.`students`.`student_gender` = 'F')
            AND `examanalysis_db`.`students`.`student_id` IN (SELECT 
                `examanalysis_db`.`examsofstudentsdetails`.`student_id`
            FROM
                `examanalysis_db`.`examsofstudentsdetails`))

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
select median as "MEDIAN OF GRADES";

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
        SET g=(n * 100 / ende);
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