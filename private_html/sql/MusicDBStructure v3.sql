-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema TeamJoston_DB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `TeamJoston_DB`;
CREATE SCHEMA IF NOT EXISTS `TeamJoston_DB` DEFAULT CHARACTER SET latin1 ;
USE `TeamJoston_DB` ;

-- -----------------------------------------------------
-- Schema TeamJoston_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TeamJoston_DB` DEFAULT CHARACTER SET latin1 ;
USE `TeamJoston_DB` ;

-- -----------------------------------------------------
-- Table `TeamJoston_DB`.`Genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TeamJoston_DB`.`Genre` (
  `Genre_ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Genre_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Genre_ID`),
  UNIQUE INDEX `Genre_Name_UNIQUE` (`Genre_Name` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `TeamJoston_DB`.`Album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TeamJoston_DB`.`Album` (
  `Album_ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Album_Name` VARCHAR(200) NOT NULL,
  `Image_URL` VARCHAR(200) NULL,
  `Genre_FK` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`Album_ID`),
  UNIQUE INDEX `Album_Name_UNIQUE` (`Album_Name` ASC),
  INDEX `Genre_Album_FK` (`Genre_FK` ASC),
  CONSTRAINT `Genre_Album_FK`
    FOREIGN KEY (`Genre_FK`)
    REFERENCES `TeamJoston_DB`.`Genre` (`Genre_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `TeamJoston_DB`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TeamJoston_DB`.`User` (
  `User_ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Password` CHAR(40) NOT NULL,
  `Salt` VARCHAR(16) NULL,
  `First_Name` VARCHAR(50) NOT NULL,
  `Last_Name` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  `Is_Admin` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`User_ID`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `TeamJoston_DB`.`Review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TeamJoston_DB`.`Review` (
  `Review_ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Comment` VARCHAR(200) NOT NULL,
  `Stars` TINYINT(3) UNSIGNED NOT NULL,
  `Timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `User_FK` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`Review_ID`),
  INDEX `User_Review_FK` (`User_FK` ASC),
  CONSTRAINT `User_Review_FK`
    FOREIGN KEY (`User_FK`)
    REFERENCES `TeamJoston_DB`.`User` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `TeamJoston_DB`.`Album_Review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TeamJoston_DB`.`Album_Review` (
  `Album_FK` BIGINT(20) UNSIGNED NOT NULL,
  `Review_FK` BIGINT(20) UNSIGNED NOT NULL,
  INDEX `Review_AlbumReviewFK` (`Review_FK` ASC),
  INDEX `Album_AlbumReview_FK` (`Album_FK` ASC),
  PRIMARY KEY (`Album_FK`, `Review_FK`),
  CONSTRAINT `Album_AlbumReview_FK`
    FOREIGN KEY (`Album_FK`)
    REFERENCES `TeamJoston_DB`.`Album` (`Album_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Review_AlbumReviewFK`
    FOREIGN KEY (`Review_FK`)
    REFERENCES `TeamJoston_DB`.`Review` (`Review_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `TeamJoston_DB`.`Artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TeamJoston_DB`.`Artist` (
  `Artist_ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Artist_Name` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`Artist_ID`),
  UNIQUE INDEX `Artist_Name_UNIQUE` (`Artist_Name` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `TeamJoston_DB`.`Artist_Review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TeamJoston_DB`.`Artist_Review` (
  `Artist_FK` BIGINT(20) UNSIGNED NOT NULL,
  `Review_FK` BIGINT(20) UNSIGNED NOT NULL,
  INDEX `Artist_ArtistReview_FK` (`Artist_FK` ASC),
  INDEX `Review_ArtistReview_FK` (`Review_FK` ASC),
  PRIMARY KEY (`Artist_FK`, `Review_FK`),
  CONSTRAINT `Artist_ArtistReview_FK`
    FOREIGN KEY (`Artist_FK`)
    REFERENCES `TeamJoston_DB`.`Artist` (`Artist_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Review_ArtistReview_FK`
    FOREIGN KEY (`Review_FK`)
    REFERENCES `TeamJoston_DB`.`Review` (`Review_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `TeamJoston_DB`.`Media_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TeamJoston_DB`.`Media_Type` (
  `Media_Type_ID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Media_Type` VARCHAR(45) NOT NULL,
  `Constraint` TINYINT UNSIGNED NOT NULL COMMENT '1 = time-based, 2=filesize-based',
  `Media_Limit` INT NULL,
  PRIMARY KEY (`Media_Type_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TeamJoston_DB`.`Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TeamJoston_DB`.`Playlist` (
  `Playlist_ID` BIGINT(20) UNSIGNED NOT NULL,
  `Playlist_Name` VARCHAR(100) NOT NULL,
  `Media_Type_FK` BIGINT UNSIGNED NULL COMMENT 'Music CD (the limit would be time), Music DVD (the limit would be time), or thumbdrive (the limit would be size)',
  PRIMARY KEY (`Playlist_ID`),
  INDEX `Media_Type_Playlist_FOREIGN_idx` (`Media_Type_FK` ASC),
  CONSTRAINT `Media_Type_Playlist_FOREIGN`
    FOREIGN KEY (`Media_Type_FK`)
    REFERENCES `TeamJoston_DB`.`Media_Type` (`Media_Type_ID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `TeamJoston_DB`.`Song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TeamJoston_DB`.`Song` (
  `Song_ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(200) NOT NULL,
  `Length` SMALLINT(5) UNSIGNED NULL DEFAULT NULL COMMENT 'Time lenght',
  `Filesize` INT NULL COMMENT 'If uploaded, this should contain the filesize.',
  `Artist_FK` BIGINT(20) UNSIGNED NULL DEFAULT NULL,
  `Song_URL` VARCHAR(100) NULL,
  `Album_FK` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`Song_ID`),
  INDEX `Artist_Song_FK` (`Artist_FK` ASC),
  INDEX `Album_Song_FK` (`Album_FK` ASC),
  CONSTRAINT `Album_Song_FK`
    FOREIGN KEY (`Album_FK`)
    REFERENCES `TeamJoston_DB`.`Album` (`Album_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Artist_Song_FK`
    FOREIGN KEY (`Artist_FK`)
    REFERENCES `TeamJoston_DB`.`Artist` (`Artist_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `TeamJoston_DB`.`Song_In_Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TeamJoston_DB`.`Song_In_Playlist` (
  `Song_In_Playlist_ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Playlist_FK` BIGINT(20) UNSIGNED NOT NULL,
  `Song_FK` BIGINT(20) UNSIGNED NOT NULL,
  `Order_Number` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Song_In_Playlist_ID`),
  INDEX `Song_SongInPlaylist_FK` (`Song_FK` ASC),
  INDEX `Playlist_SongInPlaylist_FK` (`Playlist_FK` ASC),
  CONSTRAINT `Playlist_SongInPlaylist_FK`
    FOREIGN KEY (`Playlist_FK`)
    REFERENCES `TeamJoston_DB`.`Playlist` (`Playlist_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Song_SongInPlaylist_FK`
    FOREIGN KEY (`Song_FK`)
    REFERENCES `TeamJoston_DB`.`Song` (`Song_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `TeamJoston_DB`.`Song_Review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TeamJoston_DB`.`Song_Review` (
  `Song_FK` BIGINT(20) UNSIGNED NOT NULL,
  `Review_FK` BIGINT(20) UNSIGNED NOT NULL,
  INDEX `Song_SongReview_FK` (`Song_FK` ASC),
  INDEX `Review_SongReview_FK` (`Review_FK` ASC),
  PRIMARY KEY (`Song_FK`, `Review_FK`),
  CONSTRAINT `Review_SongReview_FK`
    FOREIGN KEY (`Review_FK`)
    REFERENCES `TeamJoston_DB`.`Review` (`Review_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Song_SongReview_FK`
    FOREIGN KEY (`Song_FK`)
    REFERENCES `TeamJoston_DB`.`Song` (`Song_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `TeamJoston_DB`.`User_Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TeamJoston_DB`.`User_Playlist` (
  `User_FK` BIGINT(20) UNSIGNED NOT NULL,
  `Playlist_FK` BIGINT(20) UNSIGNED NOT NULL,
  INDEX `User_UserPlaylist_FK` (`User_FK` ASC),
  INDEX `Playlist_UserPlaylist_FK` (`Playlist_FK` ASC),
  PRIMARY KEY (`User_FK`, `Playlist_FK`),
  CONSTRAINT `Playlist_UserPlaylist_FK`
    FOREIGN KEY (`Playlist_FK`)
    REFERENCES `TeamJoston_DB`.`Playlist` (`Playlist_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `User_UserPlaylist_FK`
    FOREIGN KEY (`User_FK`)
    REFERENCES `TeamJoston_DB`.`User` (`User_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `TeamJoston_DB`.`User_Song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TeamJoston_DB`.`User_Song` (
  `User_FK` BIGINT UNSIGNED NOT NULL,
  `Song_FK` BIGINT UNSIGNED NOT NULL,
  `Date_Added` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`User_FK`, `Song_FK`),
  INDEX `Song_User_Song_FOREIGN_idx` (`Song_FK` ASC),
  CONSTRAINT `User_User_Song_FOREIGN`
    FOREIGN KEY (`User_FK`)
    REFERENCES `TeamJoston_DB`.`User` (`User_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Song_User_Song_FOREIGN`
    FOREIGN KEY (`Song_FK`)
    REFERENCES `TeamJoston_DB`.`Song` (`Song_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TeamJoston_DB`.`User_Album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TeamJoston_DB`.`User_Album` (
  `User_FK` BIGINT UNSIGNED NOT NULL,
  `Album_FK` BIGINT UNSIGNED NOT NULL,
  `Date_Added` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`User_FK`, `Album_FK`),
  INDEX `Album_User_Album_FOREIGN_idx` (`Album_FK` ASC),
  CONSTRAINT `User_User_Album_FOREIGN`
    FOREIGN KEY (`User_FK`)
    REFERENCES `TeamJoston_DB`.`User` (`User_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Album_User_Album_FOREIGN`
    FOREIGN KEY (`Album_FK`)
    REFERENCES `TeamJoston_DB`.`Album` (`Album_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TeamJoston_DB`.`User_Artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TeamJoston_DB`.`User_Artist` (
  `User_FK` BIGINT UNSIGNED NOT NULL,
  `Artist_FK` BIGINT UNSIGNED NOT NULL,
  `Date_Added` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`User_FK`, `Artist_FK`),
  INDEX `Artist_User_Artist_FOREIGN_idx` (`Artist_FK` ASC),
  CONSTRAINT `User_User_Artist_FOREIGN`
    FOREIGN KEY (`User_FK`)
    REFERENCES `TeamJoston_DB`.`User` (`User_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Artist_User_Artist_FOREIGN`
    FOREIGN KEY (`Artist_FK`)
    REFERENCES `TeamJoston_DB`.`Artist` (`Artist_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
