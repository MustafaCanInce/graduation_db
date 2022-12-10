-- ExamAnalysis_DB_SQL
-- Adem VAROL - 200709078
-- Mustafa Can İNCE - 200709081
-- Cihan Sezer ÖZKAMER - 200709601 
-- ----------------------------------- UPDATE ----------------------------------------------
call updateGrades();
-- --------------------------------- QUESTIONS ---------------------------------------------
-- 1. What is the total number of female students among the students who took all the exams?
select * from sumoffemalestudents;

select count(students.student_id) AS "NUMBER OF FEMALE STUDENTS" from students
where students.student_gender= "F" and students.student_id in
(select examsofstudentsdetails.student_id from examsofstudentsdetails);

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
-- call percentCalculate("2020-01-01", "Math", "12-F");
-- call percentCalculate("2020-04-04", "Chemistry", "11-D");

-- 10. What is a list of students in a given exam?
call examList("2020-01-01", "Math");
call examList("2020-04-04", "Chemistry");

-- 11. What is the total number of students in the classes?
select * from numberofclasses;

select student_classes.class_name, count(student_classes.class_name) from students 
left join students_has_classes on students.student_id=students_has_classes.student_id
left join student_classes on student_classes.class_id=students_has_classes.class_id
group by student_classes.class_name order by student_classes.class_name;

-- 12. Who is the eldest of the students who took a given exam?
call eldeststudent("2020-01-01", "Math");
call eldeststudent("2020-04-04", "Chemistry");

-- 13. What is the list of all students who took the exam on a given date?
call examlistwithDate("2021-05-05");
call examlistwithDate("2020-01-01");