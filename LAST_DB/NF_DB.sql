-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema examanalysis_NF
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema examanalysis_NF
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `examanalysis_NF` DEFAULT CHARACTER SET latin5 ;
USE `examanalysis_NF` ;

-- -----------------------------------------------------
-- Table `examanalysis_NF`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`students` (
  `student_id` INT NOT NULL,
  `student_sid` VARCHAR(11) NOT NULL,
  `student_name` VARCHAR(45) NOT NULL,
  `student_surname` VARCHAR(45) NOT NULL,
  `student_gender` CHAR(1) NOT NULL,
  `student_phone` VARCHAR(45) NOT NULL,
  `student_birthday` DATE NOT NULL,
  `guardian_name` VARCHAR(45) NOT NULL,
  `guardian_surname` VARCHAR(45) NOT NULL,
  `guardian_phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`classes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`classes` (
  `class_id` INT NOT NULL,
  `class_name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`class_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`schools`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`schools` (
  `school_id` INT NOT NULL,
  `school_name` VARCHAR(45) NOT NULL,
  `school_number` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`school_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`clubs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`clubs` (
  `club_id` INT NOT NULL,
  `club_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`club_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`projects` (
  `project_id` INT NOT NULL,
  `project_name` VARCHAR(45) NULL,
  PRIMARY KEY (`project_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`cities` (
  `city_id` INT NOT NULL,
  `city_name` VARCHAR(45) NOT NULL,
  `city_zipcode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`city_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`states`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`states` (
  `state_id` INT NOT NULL,
  `state_name` VARCHAR(45) NOT NULL,
  `state_zipcode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`state_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`streets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`streets` (
  `street_id` INT NOT NULL,
  `street_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`street_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`exams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`exams` (
  `exam_id` INT NOT NULL,
  `teacher_id` INT NOT NULL,
  `optic_number` INT NOT NULL,
  `exam_date` DATE NOT NULL,
  PRIMARY KEY (`exam_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`examsofstudentsdetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`examsofstudentsdetails` (
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


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`exams_names`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`exams_names` (
  `name_id` INT NOT NULL,
  `exam_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`teachers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`teachers` (
  `teacher_id` INT NOT NULL,
  `teacher_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`teacher_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`z_students_denormalized`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`z_students_denormalized` (
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


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`z_exams_denormalized`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`z_exams_denormalized` (
  `student_id` INT NULL,
  `optic_number` INT NULL,
  `booklet` CHAR(1) NULL,
  `student_answer` VARCHAR(255) NULL,
  `answer_key` VARCHAR(255) NULL,
  `exam_id` INT NULL,
  `name_id` INT NULL,
  `exam_name` VARCHAR(45) NULL,
  `exam_date` DATE NULL,
  `teacher_id` INT NULL,
  `teacher_name` VARCHAR(45) NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`students_has_classes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`students_has_classes` (
  `student_id` INT NOT NULL,
  `class_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `class_id`),
  INDEX `fk_student_classes_has_students_students1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_student_classes_has_students_student_classes1_idx` (`class_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`students_has_projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`students_has_projects` (
  `student_id` INT NOT NULL,
  `project_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `project_id`),
  INDEX `fk_students_has_student_projects_student_projects1_idx` (`project_id` ASC) VISIBLE,
  INDEX `fk_students_has_student_projects_students1_idx` (`student_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`students_has_clubs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`students_has_clubs` (
  `student_id` INT NOT NULL,
  `club_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `club_id`),
  INDEX `fk_student_clubs_has_students_students1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_student_clubs_has_students_student_clubs1_idx` (`club_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`students_has_schools`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`students_has_schools` (
  `student_id` INT NOT NULL,
  `school_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `school_id`),
  INDEX `fk_students_has_student_schools_student_schools1_idx` (`school_id` ASC) VISIBLE,
  INDEX `fk_students_has_student_schools_students1_idx` (`student_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`students_has_cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`students_has_cities` (
  `student_id` INT NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `city_id`),
  INDEX `fk_students_has_cities_cities1_idx` (`city_id` ASC) VISIBLE,
  INDEX `fk_students_has_cities_students1_idx` (`student_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`students_has_states`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`students_has_states` (
  `student_id` INT NOT NULL,
  `state_id` INT NOT NULL,
  INDEX `fk_states_has_students_students1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_states_has_students_states1_idx` (`state_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`students_has_streets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`students_has_streets` (
  `student_id` INT NOT NULL,
  `street_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `street_id`),
  INDEX `fk_streets_has_students_students1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_streets_has_students_streets1_idx` (`street_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`exams_has_teachers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`exams_has_teachers` (
  `exam_id` INT NOT NULL,
  `teacher_id` INT NOT NULL,
  INDEX `fk_exams_has_teachers_teachers1_idx` (`teacher_id` ASC) VISIBLE,
  INDEX `fk_exams_has_teachers_exams1_idx` (`exam_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_NF`.`exams_has_exams_names`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_NF`.`exams_has_exams_names` (
  `exam_id` INT NOT NULL,
  `name_id` INT NOT NULL,
  INDEX `fk_exams_has_exams_names_exams_names1_idx` (`name_id` ASC) VISIBLE,
  INDEX `fk_exams_has_exams_names_exams1_idx` (`exam_id` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
