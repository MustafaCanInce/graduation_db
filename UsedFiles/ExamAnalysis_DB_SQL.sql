-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema examanalysis_DB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema examanalysis_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `examanalysis_DB` DEFAULT CHARACTER SET utf8 ;
USE `examanalysis_DB` ;

-- -----------------------------------------------------
-- Table `examanalysis_DB`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`students` (
  `student_id` INT NOT NULL,
  `class_id` INT NOT NULL,
  `school_id` INT NOT NULL,
  `club_id` INT NOT NULL,
  `project_id` INT NOT NULL,
  `city_id` INT NOT NULL,
  `state_id` INT NOT NULL,
  `street_id` INT NOT NULL,
  `ssid` VARCHAR(11) NOT NULL,
  `studentname` VARCHAR(45) NOT NULL,
  `studentsurname` VARCHAR(45) NOT NULL,
  `studentgender` CHAR(1) NOT NULL,
  `studentphone` VARCHAR(45) NOT NULL,
  `studentbirthday` DATE NOT NULL,
  `guardianname` VARCHAR(45) NOT NULL,
  `guardiansurname` VARCHAR(45) NOT NULL,
  `guardianphone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`student_id`, `class_id`, `school_id`, `club_id`, `project_id`, `city_id`, `state_id`, `street_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_DB`.`student_classes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`student_classes` (
  `class_id` INT NOT NULL,
  `class_name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`class_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_DB`.`student_schools`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`student_schools` (
  `school_id` INT NOT NULL,
  `school_name` VARCHAR(45) NOT NULL,
  `school_number` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`school_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_DB`.`student_clubs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`student_clubs` (
  `club_id` INT NOT NULL,
  `club_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`club_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_DB`.`student_projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`student_projects` (
  `project_id` INT NOT NULL,
  `project_name` VARCHAR(45) NULL,
  PRIMARY KEY (`project_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_DB`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`cities` (
  `city_id` INT NOT NULL,
  `city_name` VARCHAR(45) NOT NULL,
  `city_zipcode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`city_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_DB`.`state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`state` (
  `state_id` INT NOT NULL,
  `state_name` VARCHAR(45) NOT NULL,
  `state_zipcode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`state_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_DB`.`streets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`streets` (
  `street_id` INT NOT NULL,
  `street_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`street_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_DB`.`exams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`exams` (
  `exam_id` INT NOT NULL,
  `examname_id` INT NOT NULL,
  `teacher_id` INT NOT NULL,
  `optic_number` INT NOT NULL,
  `examdate` DATE NULL,
  PRIMARY KEY (`exam_id`, `examname_id`, `teacher_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_DB`.`examsofstudentsdetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`examsofstudentsdetails` (
  `details_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  `exam_id` INT NOT NULL,
  `booklet` CHAR(1) NOT NULL,
  `studentanswer` VARCHAR(255) NOT NULL,
  `answerkey` VARCHAR(255) NOT NULL,
  `questionsubject` VARCHAR(255) NULL,
  PRIMARY KEY (`details_id`),
  INDEX `fk_examsofstudentsdetails_students1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_examsofstudentsdetails_exams1_idx` (`exam_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_DB`.`exams_names`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`exams_names` (
  `examname_id` INT NOT NULL,
  `exam_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`examname_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `examanalysis_DB`.`teachers_name`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `examanalysis_DB`.`teachers_name` (
  `teacher_id` INT NOT NULL,
  `teacher_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`teacher_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `examanalysis_DB`.`students`
-- -----------------------------------------------------
START TRANSACTION;
USE `examanalysis_DB`;
INSERT INTO `examanalysis_DB`.`students` (`student_id`, `class_id`, `school_id`, `club_id`, `project_id`, `city_id`, `state_id`, `street_id`, `ssid`, `studentname`, `studentsurname`, `studentgender`, `studentphone`, `studentbirthday`, `guardianname`, `guardiansurname`, `guardianphone`) VALUES (20210001, 1, 1, 1, 1, 1, 1, 1, '10910874752', 'Almıla', 'Gökçe', 'F', '5396396379', '2007-3-14', 'Ferah', 'Yıldırım', '5327766379');

COMMIT;


-- -----------------------------------------------------
-- Data for table `examanalysis_DB`.`student_classes`
-- -----------------------------------------------------
START TRANSACTION;
USE `examanalysis_DB`;
INSERT INTO `examanalysis_DB`.`student_classes` (`class_id`, `class_name`) VALUES (1, '9-A');

COMMIT;


-- -----------------------------------------------------
-- Data for table `examanalysis_DB`.`student_schools`
-- -----------------------------------------------------
START TRANSACTION;
USE `examanalysis_DB`;
INSERT INTO `examanalysis_DB`.`student_schools` (`school_id`, `school_name`, `school_number`) VALUES (1, 'Ortaca Anadolu Lisesi', '964098');

COMMIT;


-- -----------------------------------------------------
-- Data for table `examanalysis_DB`.`student_clubs`
-- -----------------------------------------------------
START TRANSACTION;
USE `examanalysis_DB`;
INSERT INTO `examanalysis_DB`.`student_clubs` (`club_id`, `club_name`) VALUES (1, 'Volleyball');

COMMIT;


-- -----------------------------------------------------
-- Data for table `examanalysis_DB`.`student_projects`
-- -----------------------------------------------------
START TRANSACTION;
USE `examanalysis_DB`;
INSERT INTO `examanalysis_DB`.`student_projects` (`project_id`, `project_name`) VALUES (1, 'Math');

COMMIT;


-- -----------------------------------------------------
-- Data for table `examanalysis_DB`.`cities`
-- -----------------------------------------------------
START TRANSACTION;
USE `examanalysis_DB`;
INSERT INTO `examanalysis_DB`.`cities` (`city_id`, `city_name`, `city_zipcode`) VALUES (1, 'Muğla', '48000');

COMMIT;


-- -----------------------------------------------------
-- Data for table `examanalysis_DB`.`state`
-- -----------------------------------------------------
START TRANSACTION;
USE `examanalysis_DB`;
INSERT INTO `examanalysis_DB`.`state` (`state_id`, `state_name`, `state_zipcode`) VALUES (1, 'Ortaca', '48600');

COMMIT;


-- -----------------------------------------------------
-- Data for table `examanalysis_DB`.`streets`
-- -----------------------------------------------------
START TRANSACTION;
USE `examanalysis_DB`;
INSERT INTO `examanalysis_DB`.`streets` (`street_id`, `street_name`) VALUES (1, 'Kemaliye');

COMMIT;


-- -----------------------------------------------------
-- Data for table `examanalysis_DB`.`exams`
-- -----------------------------------------------------
START TRANSACTION;
USE `examanalysis_DB`;
INSERT INTO `examanalysis_DB`.`exams` (`exam_id`, `examname_id`, `teacher_id`, `optic_number`, `examdate`) VALUES (1, 1, 1, 95, '2020-10-13');

COMMIT;


-- -----------------------------------------------------
-- Data for table `examanalysis_DB`.`examsofstudentsdetails`
-- -----------------------------------------------------
START TRANSACTION;
USE `examanalysis_DB`;
INSERT INTO `examanalysis_DB`.`examsofstudentsdetails` (`details_id`, `student_id`, `exam_id`, `booklet`, `studentanswer`, `answerkey`, `questionsubject`) VALUES (1, 20210501, 1, 'A', 'DCEAEBCABEDCDDECECEE', 'DEAACECBEADEBDCCDEEB', 'M0102151014141113151815121513151418151114');

COMMIT;


-- -----------------------------------------------------
-- Data for table `examanalysis_DB`.`exams_names`
-- -----------------------------------------------------
START TRANSACTION;
USE `examanalysis_DB`;
INSERT INTO `examanalysis_DB`.`exams_names` (`examname_id`, `exam_name`) VALUES (1, 'Math');

COMMIT;


-- -----------------------------------------------------
-- Data for table `examanalysis_DB`.`teachers_name`
-- -----------------------------------------------------
START TRANSACTION;
USE `examanalysis_DB`;
INSERT INTO `examanalysis_DB`.`teachers_name` (`teacher_id`, `teacher_name`) VALUES (1, 'Selçuk ÖS');

COMMIT;

