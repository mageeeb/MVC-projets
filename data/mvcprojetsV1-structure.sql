-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mvcprojet_mageeb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mvcprojet_mageeb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mvcprojet_mageeb` DEFAULT CHARACTER SET utf8 ;
USE `mvcprojet_mageeb` ;

-- -----------------------------------------------------
-- Table `mvcprojet_mageeb`.`utilisateur`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mvcprojet_mageeb`.`utilisateur` ;

CREATE TABLE IF NOT EXISTS `mvcprojet_mageeb`.`utilisateur` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(80) NOT NULL COMMENT 'identifiant',
  `usermail` VARCHAR(200) NOT NULL,
  `userpwd` VARCHAR(255) NOT NULL COMMENT 'mot de passe',
  `userscreen` VARCHAR(400) NOT NULL COMMENT 'affichge de l\'user',
  `useriduniq` VARCHAR(120) NULL COMMENT 'identifiant unique',
  `actif` TINYINT UNSIGNED NULL DEFAULT 0 COMMENT '0 => inactif\n1=> actif\n2=> banni',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `usermail_UNIQUE` (`usermail` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mvcprojet_mageeb`.`articles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mvcprojet_mageeb`.`articles` ;

CREATE TABLE IF NOT EXISTS `mvcprojet_mageeb`.`articles` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `contenus` TEXT NOT NULL,
  `datecreate` DATETIME NULL DEFAULT now(),
  `visible` TINYINT NOT NULL DEFAULT 0,
  `utilisateur_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_articles_utilisateur_idx` (`utilisateur_id` ASC) VISIBLE,
  CONSTRAINT `fk_articles_utilisateur`
    FOREIGN KEY (`utilisateur_id`)
    REFERENCES `mvcprojet_mageeb`.`utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mvcprojet_mageeb`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mvcprojet_mageeb`.`category` ;

CREATE TABLE IF NOT EXISTS `mvcprojet_mageeb`.`category` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `contenus` VARCHAR(800) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mvcprojet_mageeb`.`articles_has_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mvcprojet_mageeb`.`articles_has_category` ;

CREATE TABLE IF NOT EXISTS `mvcprojet_mageeb`.`articles_has_category` (
  `articles_id` INT UNSIGNED NOT NULL,
  `category_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`articles_id`, `category_id`),
  INDEX `fk_articles_has_category_category1_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_articles_has_category_articles1_idx` (`articles_id` ASC) VISIBLE,
  CONSTRAINT `fk_articles_has_category_articles1`
    FOREIGN KEY (`articles_id`)
    REFERENCES `mvcprojet_mageeb`.`articles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_articles_has_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `mvcprojet_mageeb`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
