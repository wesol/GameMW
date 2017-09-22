-- -----------------
-- Create database
-- -----------------

CREATE SCHEMA IF NOT EXISTS gameMW DEFAULT CHARACTER SET utf8 ;
USE gameMW;


-- -----------------
-- Create tabels
-- -----------------

CREATE TABLE IF NOT EXISTS gameMW.weapons (
    id_we INT NOT NULL,
    name VARCHAR(15) NOT NULL,
    power INT NULL DEFAULT 5,
    defence INT NULL DEFAULT 5,
    onehanded TINYINT NULL,
    PRIMARY KEY (id_we)
);


CREATE TABLE IF NOT EXISTS gameMW.armor (
    id_ar INT NOT NULL,
    name VARCHAR(15) NOT NULL,
    power INT NULL DEFAULT 5,
    defence INT NULL DEFAULT 5,
    PRIMARY KEY (id_ar)
);


-- -----------------------------------------------------
-- Table `mydb`.`race`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`race` (
  `id_ar` INT NOT NULL,
  `name` VARCHAR(15) NOT NULL,
  `power` INT NULL DEFAULT 5,
  `defence` INT NULL DEFAULT 5,
  PRIMARY KEY (`id_ar`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`charakters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`charakters` (
  `id_ch` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(15) NOT NULL,
  `power` INT NULL DEFAULT 5,
  `defence` INT NULL DEFAULT 5,
  weapons_id INT NOT NULL,
  armor_id INT NOT NULL,
  race_id INT NOT NULL,
  PRIMARY KEY (`id_ch`),
  INDEX `fk_charakters_weapons_idx` (`weapons_id_we` ASC),
  INDEX `fk_charakters_armor1_idx` (`armor_id_ar` ASC),
  INDEX `fk_charakters_race1_idx` (`race_id_ar` ASC),
  CONSTRAINT `fk_charakters_weapons`
    FOREIGN KEY (`weapons_id_we`)
    REFERENCES `mydb`.`weapons` (`id_we`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_charakters_armor1`
    FOREIGN KEY (`armor_id_ar`)
    REFERENCES `mydb`.`armor` (`id_ar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_charakters_race1`
    FOREIGN KEY (`race_id_ar`)
    REFERENCES `mydb`.`race` (`id_ar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- View `mydb`.`view1`
-- -----------------------------------------------------
USE `mydb`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
