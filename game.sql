-- -----------------
-- Create database
-- -----------------

CREATE SCHEMA IF NOT EXISTS gameMW DEFAULT CHARACTER SET utf8 ;
USE gameMW;

create database game;
#drop database game;
use game;
select database();
show tables;

CREATE TABLE weapons (
	id_w INT,
    name_w VARCHAR(10),
    type VARCHAR(15),
    power tinyint,
     primary key(id_w)
	);

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

CREATE TABLE characters (
    id_c INT AUTO_INCREMENT,
    id_w INT,
    name_c VARCHAR(10) not null,
    race SET('human', 'dwarf', 'orc', 'elf') not null,
    type SET('warrior', 'wizard', 'assasin') not null,
    strenght TINYINT DEFAULT 5,
    dexterity TINYINT DEFAULT 5,
    intelligence TINYINT DEFAULT 5,
	PRIMARY KEY (id_c)/*,
	foreign key (id_w) references weapons(id_w)*/
);

describe characters;
#drop table characters;

load data local infile 'D:/Rkfr/__projects/GameMW/characters.csv' 
	into table characters
	FIELDS TERMINATED BY ';' 
   # escaped by ''
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
    (id_w, name_c, race, type, strenght,dexterity,intelligence)
    SET 
    id_w = if(id_w='',1,id_w),
    strenght = if(strenght='',5,strenght),
    dexterity = if(dexterity='',5,dexterity),
    intelligence = if(intelligence='',5,intelligence)
    ;
#update characters set intelligence=deafult where intelligence is null;

/*INSERT INTO CHARACTERS (id_w, name_c, race, type, strenght,intelligence, dexterity) VALUES (3, 'Gimli', 'dwarf', 'warrior', 15, 2, 5);
INSERT INTO CHARACTERS (id_w, name_C, race, type, strenght) VALUES (2, 'Boromir', 'dwarf',  'warrior', 15);
INSERT INTO CHARACTERS (id_w, name_C, race, type, intelligence ) VALUES (15, 'Gur', 'orc',  'warrior', 16);*/

#UPDATE characters SET strenght = (DEFAULT(strenght)+1) where strenght is null;

/*
SELECT 
    *
FROM
    characters;
    
CREATE VIEW suma_nap AS
SELECT (strenght+dexterity)*intelligence as napierdol
FROM characters;

drop view suma_nap;


select * from suma_nap;
>>>>>>> b4ecf53bbbd28fea3de304d56aa402c9a7993627
