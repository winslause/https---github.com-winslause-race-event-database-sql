
-- Wed Nov  2 21:50:37 2022
-- Model: racing Full    Version: 2.0


SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema racing
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema racing
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `racing` ;
USE `racing` ;

-- -----------------------------------------------------
-- Table `racing`.`racingteam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `racing`.`racingteam` (
  `teamname` VARCHAR(45) NOT NULL,
  `headquarteraddress` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`teamname`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `racing`.`racecourse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `racing`.`racecourse` (
  `date` DATE NOT NULL,
  `starttime` VARCHAR(45) NOT NULL,
  `coursename` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `length` INT NOT NULL,
  PRIMARY KEY (`coursename`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `racing`.`day`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `racing`.`day` (
  `day` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`day`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `racing`.`race`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `racing`.`race` (
  `racename` VARCHAR(45) NOT NULL,
  `lapsnumber` INT NOT NULL,
  `length` INT NOT NULL,
  `racecourse_coursename` VARCHAR(45) NOT NULL,
  `day_day` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`racename`, `racecourse_coursename`, `day_day`),
  INDEX `fk_race_racecourse1_idx` (`racecourse_coursename` ASC),
  INDEX `fk_race_day1_idx` (`day_day` ASC),
  CONSTRAINT `fk_race_racecourse1`
    FOREIGN KEY (`racecourse_coursename`)
    REFERENCES `racing`.`racecourse` (`coursename`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_race_day1`
    FOREIGN KEY (`day_day`)
    REFERENCES `racing`.`day` (`day`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `racing`.`car`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `racing`.`car` (
  `caridentifier` INT NOT NULL,
  `tyrestype` VARCHAR(45) NOT NULL,
  `racingnumber` INT NOT NULL,
  `enginetype` VARCHAR(45) NOT NULL,
  `racingteam_teamname` VARCHAR(45) NOT NULL,
  `race_racename` INT NOT NULL,
  `race_racecourse_coursename` VARCHAR(45) NOT NULL,
  `race_day_day` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`caridentifier`, `racingteam_teamname`, `race_racename`, `race_racecourse_coursename`, `race_day_day`),
  INDEX `fk_car_racingteam1_idx` (`racingteam_teamname` ASC),
  INDEX `fk_car_race1_idx` (`race_racename` ASC, `race_racecourse_coursename` ASC, `race_day_day` ASC),
  CONSTRAINT `fk_car_racingteam1`
    FOREIGN KEY (`racingteam_teamname`)
    REFERENCES `racing`.`racingteam` (`teamname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_car_race1`
    FOREIGN KEY (`race_racename` , `race_racecourse_coursename` , `race_day_day`)
    REFERENCES `racing`.`race` (`racename` , `racecourse_coursename` , `day_day`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `racing`.`driver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `racing`.`driver` (
  `identifier` INT NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `nationality` VARCHAR(45) NOT NULL,
  `DOB` DATE NOT NULL,
  `arrivalplace` VARCHAR(45) NOT NULL,
  `cartype` VARCHAR(45) NOT NULL,
  `racetype` VARCHAR(45) NOT NULL,
  `racingteam_teamname` VARCHAR(45) NOT NULL,
  `car_caridentifier` INT NOT NULL,
  PRIMARY KEY (`identifier`, `racingteam_teamname`, `car_caridentifier`),
  INDEX `fk_driver_racingteam1_idx` (`racingteam_teamname` ASC),
  INDEX `fk_driver_car1_idx` (`car_caridentifier` ASC),
  CONSTRAINT `fk_driver_racingteam1`
    FOREIGN KEY (`racingteam_teamname`)
    REFERENCES `racing`.`racingteam` (`teamname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_driver_car1`
    FOREIGN KEY (`car_caridentifier`)
    REFERENCES `racing`.`car` (`caridentifier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `racing`.`lap`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `racing`.`lap` (
  `laptime` VARCHAR(45) NULL,
  `fuelconcuption` VARCHAR(45) NULL,
  `race_racename` INT NOT NULL,
  `race_racecourse_coursename` VARCHAR(45) NOT NULL,
  `car_caridentifier` INT NOT NULL,
  `car_racingteam_teamname` VARCHAR(45) NOT NULL,
  `car_race_racename` INT NOT NULL,
  `car_race_racecourse_coursename` VARCHAR(45) NOT NULL,
  `car_race_day_day` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`race_racename`, `race_racecourse_coursename`, `car_caridentifier`, `car_racingteam_teamname`, `car_race_racename`, `car_race_racecourse_coursename`, `car_race_day_day`),
  INDEX `fk_lap_car1_idx` (`car_caridentifier` ASC, `car_racingteam_teamname` ASC, `car_race_racename` ASC, `car_race_racecourse_coursename` ASC, `car_race_day_day` ASC),
  CONSTRAINT `fk_lap_race1`
    FOREIGN KEY (`race_racename` , `race_racecourse_coursename`)
    REFERENCES `racing`.`race` (`racename` , `racecourse_coursename`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lap_car1`
    FOREIGN KEY (`car_caridentifier` , `car_racingteam_teamname` , `car_race_racename` , `car_race_racecourse_coursename` , `car_race_day_day`)
    REFERENCES `racing`.`car` (`caridentifier` , `racingteam_teamname` , `race_racename` , `race_racecourse_coursename` , `race_day_day`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `racing`.`retirement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `racing`.`retirement` (
  `lapnumber` INT NOT NULL,
  `reason` VARCHAR(45) NOT NULL,
  `racetype` VARCHAR(45) NOT NULL,
  `lap_race_racename` INT NOT NULL,
  `lap_race_racecourse_coursename` VARCHAR(45) NOT NULL,
  `lap_car_caridentifier` INT NOT NULL,
  `lap_car_racingteam_teamname` VARCHAR(45) NOT NULL,
  `lap_car_race_racename` INT NOT NULL,
  `lap_car_race_racecourse_coursename` VARCHAR(45) NOT NULL,
  `lap_car_race_day_day` VARCHAR(45) NOT NULL,
  `car_caridentifier` INT NOT NULL,
  `car_racingteam_teamname` VARCHAR(45) NOT NULL,
  `car_race_racename` INT NOT NULL,
  `car_race_racecourse_coursename` VARCHAR(45) NOT NULL,
  `car_race_day_day` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`lap_race_racename`, `lap_race_racecourse_coursename`, `lap_car_caridentifier`, `lap_car_racingteam_teamname`, `lap_car_race_racename`, `lap_car_race_racecourse_coursename`, `lap_car_race_day_day`, `car_caridentifier`, `car_racingteam_teamname`, `car_race_racename`, `car_race_racecourse_coursename`, `car_race_day_day`),
  INDEX `fk_retirement_car1_idx` (`car_caridentifier` ASC, `car_racingteam_teamname` ASC, `car_race_racename` ASC, `car_race_racecourse_coursename` ASC, `car_race_day_day` ASC),
  CONSTRAINT `fk_retirement_lap1`
    FOREIGN KEY (`lap_race_racename` , `lap_race_racecourse_coursename` , `lap_car_caridentifier` , `lap_car_racingteam_teamname` , `lap_car_race_racename` , `lap_car_race_racecourse_coursename` , `lap_car_race_day_day`)
    REFERENCES `racing`.`lap` (`race_racename` , `race_racecourse_coursename` , `car_caridentifier` , `car_racingteam_teamname` , `car_race_racename` , `car_race_racecourse_coursename` , `car_race_day_day`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_retirement_car1`
    FOREIGN KEY (`car_caridentifier` , `car_racingteam_teamname` , `car_race_racename` , `car_race_racecourse_coursename` , `car_race_day_day`)
    REFERENCES `racing`.`car` (`caridentifier` , `racingteam_teamname` , `race_racename` , `race_racecourse_coursename` , `race_day_day`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `racing`.`pitstop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `racing`.`pitstop` (
  `itemschanged` VARCHAR(45) NOT NULL,
  `duration` VARCHAR(45) NOT NULL,
  `car_caridentifier` INT NOT NULL,
  `car_racingteam_teamname` VARCHAR(45) NOT NULL,
  `car_race_racename` INT NOT NULL,
  `car_race_racecourse_coursename` VARCHAR(45) NOT NULL,
  `car_race_day_day` VARCHAR(45) NOT NULL,
  `lap_race_racename` INT NOT NULL,
  `lap_race_racecourse_coursename` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`car_caridentifier`, `car_racingteam_teamname`, `car_race_racename`, `car_race_racecourse_coursename`, `car_race_day_day`, `lap_race_racename`, `lap_race_racecourse_coursename`),
  INDEX `fk_pitstop_lap1_idx` (`lap_race_racename` ASC, `lap_race_racecourse_coursename` ASC),
  CONSTRAINT `fk_pitstop_car1`
    FOREIGN KEY (`car_caridentifier` , `car_racingteam_teamname` , `car_race_racename` , `car_race_racecourse_coursename` , `car_race_day_day`)
    REFERENCES `racing`.`car` (`caridentifier` , `racingteam_teamname` , `race_racename` , `race_racecourse_coursename` , `race_day_day`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pitstop_lap1`
    FOREIGN KEY (`lap_race_racename` , `lap_race_racecourse_coursename`)
    REFERENCES `racing`.`lap` (`race_racename` , `race_racecourse_coursename`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
