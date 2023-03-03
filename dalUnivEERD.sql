-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Department` (
  `deptId` INT NOT NULL,
  `deptName` VARCHAR(45) NULL,
  `phoneNo` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `website` VARCHAR(45) NULL,
  `hod` VARCHAR(45) NULL,
  PRIMARY KEY (`deptId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Staff` (\\
  `staff_id` INT NOT NULL,\\
  `firstName` VARCHAR(45) NULL,\\
  `lastName` VARCHAR(45) NULL,\\
  `email` VARCHAR(45) NULL,\\
  `phoneNo` VARCHAR(45) NULL,\\
  `dob` VARCHAR(45) NULL,\\
  `Department_deptId` INT NOT NULL,\\
  PRIMARY KEY (`staff_id`),\\
  INDEX `fk_Staff_Department1_idx` (`Department_deptId` ASC) VISIBLE,\\
  CONSTRAINT `fk_Staff_Department1`\\
    FOREIGN KEY (`Department_deptId`)\\
    REFERENCES `mydb`.`Department` (`deptId`)\\
    ON DELETE NO ACTION\\
    ON UPDATE NO ACTION)\\
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Campus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Campus` (\\
  `campusId` INT NOT NULL,\\
  `campusName` VARCHAR(45) NULL,\\
  `location` VARCHAR(45) NULL,\\
  `areaInSqFt` VARCHAR(45) NULL,\\
  PRIMARY KEY (`campusId`))\\
ENGINE = InnoDB;\\


-- -----------------------------------------------------
-- Table `mydb`.`Classroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Classroom` (\\
  `classroomNo` INT NOT NULL,\\
  `availability` VARCHAR(45) NULL,\\
  `buildingName` VARCHAR(45) NULL,\\
  `floorNo` VARCHAR(45) NULL,\\
  `capacity` VARCHAR(45) NULL,\\
  `Campus_campusId` INT NOT NULL,\\
  PRIMARY KEY (`classroomNo`),\\
  INDEX `fk_Classroom_Campus_idx` (`Campus_campusId` ASC) VISIBLE,\\
  CONSTRAINT `fk_Classroom_Campus`\\
    FOREIGN KEY (`Campus_campusId`)\\
    REFERENCES `mydb`.`Campus` (`campusId`)\\
    ON DELETE NO ACTION\\
    ON UPDATE NO ACTION)\\
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Student` (\\
  `studentId` INT NOT NULL,\\
  `name` VARCHAR(45) NULL,\\
  `gender` VARCHAR(45) NULL,\\
  `batch` VARCHAR(45) NULL,\\
  `dob` VARCHAR(45) NULL,\\
  `Department_deptId` INT NOT NULL,\\
  PRIMARY KEY (`studentId`),\\
  INDEX `fk_Student_Department1_idx` (`Department_deptId` ASC) VISIBLE,\\
  CONSTRAINT `fk_Student_Department1`\\
    FOREIGN KEY (`Department_deptId`)\\
    REFERENCES `mydb`.`Department` (`deptId`)\\
    ON DELETE NO ACTION\\
    ON UPDATE NO ACTION)\\
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Course` (\\
  `crnNumber` INT NOT NULL,\\
  `name` VARCHAR(45) NULL,\\
  `title` VARCHAR(45) NULL,\\
  `code` VARCHAR(45) NULL,\\
  `prerequisites` VARCHAR(45) NULL,\\
  `credits` VARCHAR(45) NULL,\\
  `Staff_staff_id` INT NOT NULL,\\
  `Student_studentId` INT NOT NULL,\\
  PRIMARY KEY (`crnNumber`),\\
  INDEX `fk_Course_Staff1_idx` (`Staff_staff_id` ASC) VISIBLE,\\
  INDEX `fk_Course_Student1_idx` (`Student_studentId` ASC) VISIBLE,\\
  CONSTRAINT `fk_Course_Staff1`\\
    FOREIGN KEY (`Staff_staff_id`)\\
    REFERENCES `mydb`.`Staff` (`staff_id`)\\
    ON DELETE NO ACTION\\
    ON UPDATE NO ACTION,\\
  CONSTRAINT `fk_Course_Student1`\\
    FOREIGN KEY (`Student_studentId`)\\
    REFERENCES `mydb`.`Student` (`studentId`)\\
    ON DELETE NO ACTION\\
    ON UPDATE NO ACTION)\\
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Service` (\\
  `serviceId` INT NOT NULL,\\
  `location` VARCHAR(45) NULL,\\
  `workingHours` VARCHAR(45) NULL,\\
  `description` VARCHAR(45) NULL,\\
  `Student_studentId` INT NOT NULL,\\
  PRIMARY KEY (`serviceId`),\\
  INDEX `fk_Service_Student1_idx` (`Student_studentId` ASC) VISIBLE,\\
  CONSTRAINT `fk_Service_Student1`\\
    FOREIGN KEY (`Student_studentId`)\\
    REFERENCES `mydb`.`Student` (`studentId`)\\
    ON DELETE NO ACTION\\
    ON UPDATE NO ACTION)\\
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Library`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Library` (\\
  `libraryId` INT NOT NULL,\\
  `location` VARCHAR(45) NULL,\\
  `workingHours` VARCHAR(45) NULL,\\
  `contactInfo` VARCHAR(45) NULL,\\
  `Campus_campusId` INT NOT NULL,\\
  PRIMARY KEY (`libraryId`),\\
  INDEX `fk_Library_Campus1_idx` (`Campus_campusId` ASC) VISIBLE,\\
  CONSTRAINT `fk_Library_Campus1`\\
    FOREIGN KEY (`Campus_campusId`)\\
    REFERENCES `mydb`.`Campus` (`campusId`)\\
    ON DELETE NO ACTION\\
    ON UPDATE NO ACTION)\\
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Book` (\\
  `bookId` INT NOT NULL,\\
  `isbn` VARCHAR(45) NULL,\\
  `title` VARCHAR(45) NULL,\\
  `author` VARCHAR(45) NULL,\\
  `availabiltiy` VARCHAR(45) NULL,\\
  `publisher` VARCHAR(45) NULL,\\
  `Library_libraryId` INT NOT NULL,\\
  PRIMARY KEY (`bookId`),\\
  INDEX `fk_Book_Library1_idx` (`Library_libraryId` ASC) VISIBLE,\\
  CONSTRAINT `fk_Book_Library1`\\
    FOREIGN KEY (`Library_libraryId`)\\
    REFERENCES `mydb`.`Library` (`libraryId`)\\
    ON DELETE NO ACTION\\
    ON UPDATE NO ACTION)\\
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SocialClubs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SocialClubs` (\\
  `clubId` INT NOT NULL,\\
  `clubName` VARCHAR(45) NULL,\\
  `type` VARCHAR(45) NULL,\\
  `website` VARCHAR(45) NULL,\\
  `description` VARCHAR(45) NULL,\\
  `Student_studentId` INT NOT NULL,\\
  PRIMARY KEY (`clubId`),\\
  INDEX `fk_SocialClubs_Student1_idx` (`Student_studentId` ASC) VISIBLE,\\
  CONSTRAINT `fk_SocialClubs_Student1`\\
    FOREIGN KEY (`Student_studentId`)\\
    REFERENCES `mydb`.`Student` (`studentId`)\\
    ON DELETE NO ACTION\\
    ON UPDATE NO ACTION)\\
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Exam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Exam` (\\
  `date` INT NOT NULL,\\
  `duration` VARCHAR(45) NULL,\\
  `name` VARCHAR(45) NULL,\\
  `Student_studentId` INT NOT NULL,\\
  PRIMARY KEY (`date`),\\
  INDEX `fk_Exam_Student1_idx` (`Student_studentId` ASC) VISIBLE,\\
  CONSTRAINT `fk_Exam_Student1`\\
    FOREIGN KEY (`Student_studentId`)\\
    REFERENCES `mydb`.`Student` (`studentId`)\\
    ON DELETE NO ACTION\\
    ON UPDATE NO ACTION)\\
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
