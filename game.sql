-- -----------------
-- Database creating
-- -----------------

CREATE SCHEMA IF NOT EXISTS gameMW;
USE gameMW;

#drop database gameMW;

-- -----------------
-- Tables creatingW
-- -----------------

CREATE TABLE IF NOT EXISTS gameMW.weapons (
    id_we INT NOT NULL,
    name VARCHAR(15) NOT NULL,
    attack TINYINT UNSIGNED DEFAULT 5,
    defence TINYINT UNSIGNED DEFAULT 5,
    onehanded BOOLEAN DEFAULT 1,
    PRIMARY KEY (id_we)
);

#drop table gameMW.weapons;

CREATE TABLE IF NOT EXISTS gameMW.armors (
    id_ar INT NOT NULL,
    name VARCHAR(15) NOT NULL,
    defence TINYINT UNSIGNED DEFAULT 0,
    PRIMARY KEY (id_ar)
);

#drop table gameMW.armors;

CREATE TABLE IF NOT EXISTS gameMW.race (
    id_ra INT NOT NULL,
    name varchar(15) NOT NULL,
    attack TINYINT UNSIGNED DEFAULT 0,
    defence TINYINT UNSIGNED DEFAULT 0,
    PRIMARY KEY (id_ra)
);

#drop table gameMW.race;

CREATE TABLE IF NOT EXISTS gameMW.class (
    id_cl INT NOT NULL,
    name VARCHAR(15) NOT NULL,
    attack TINYINT UNSIGNED DEFAULT 0,
    defence TINYINT UNSIGNED DEFAULT 0,
    PRIMARY KEY (id_cl)
);

#drop table gameMW.class;

CREATE TABLE IF NOT EXISTS gameMW.characters (
    id_ch INT AUTO_INCREMENT,
    name VARCHAR(15) NOT NULL,
    attack TINYINT UNSIGNED DEFAULT 5,
    defence TINYINT NULL DEFAULT 5,
    id_we_rh INT NOT NULL,
    id_ar INT NOT NULL,
    id_we_lh INT NOT NULL,
    id_ra INT NOT NULL,
    id_cl INT NOT NULL,
    PRIMARY KEY (id_ch),
    FOREIGN KEY (id_we_rh)
        REFERENCES gameMW.weapons (id_we),
    FOREIGN KEY (id_ar)
        REFERENCES gameMW.armors (id_ar),
    FOREIGN KEY (id_we_lh)
        REFERENCES gameMW.weapons (id_we),
    FOREIGN KEY (id_ra)
        REFERENCES gameMW.race (id_ra),
    FOREIGN KEY (id_cl)
        REFERENCES gameMW.class (id_cl)
);
    
#drop table gameMW.characters;

-- -----------------
-- Data loading
-- -----------------

load data local infile 'D:/Rkfr/__projects/GameMW/weapons.csv' 
	into table gameMW.weapons
	FIELDS TERMINATED BY ';' 
  	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
    (id_we, name, attack, defence, onehanded)
    SET 
    attack = if(attack='', 0, attack),
    defence = if(defence='', 0, defence),
    onehanded = if(onehanded='', 1, onehanded)
;

load data local infile 'D:/Rkfr/__projects/GameMW/armors.csv' 
	into table gameMW.armors
	FIELDS TERMINATED BY ';' 
  	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
    (id_ar, name, defence)
    SET 
    defence = if(defence='', 0, defence)
;

load data local infile 'D:/Rkfr/__projects/GameMW/race.csv' 
	into table gameMW.race
	FIELDS TERMINATED BY ';' 
  	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
    (id_ra, name, attack, defence)
    SET 
    attack = if(attack='', 0, attack),
    defence = if(defence='', 0, defence)
;

load data local infile 'D:/Rkfr/__projects/GameMW/class.csv' 
	into table gameMW.class
	FIELDS TERMINATED BY ';' 
  	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
    (id_cl, name, attack, defence)
    SET 
    attack = if(attack='', 0, attack),
    defence = if(defence='', 0, defence)
;


load data local infile 'D:/Rkfr/__projects/GameMW/characters.csv' 
	into table characters
	FIELDS TERMINATED BY ';' 
  	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
    (name, attack, defence, id_we_rh, id_ar, id_we_lh, id_ra, id_cl)
    SET 
    attack = if(attack='', 5, attack),
    defence = if(defence='', 5, defence),
    id_we_lh = if(id_we_lh='', null, id_we_lh)
;

-- -----------------
-- tables content showing
-- -----------------

select * from weapons;

select * from armors;

select * from race;

select * from class;

select * from characters;

-- -----------------
-- Views creating
-- -----------------

### Summary view
-- --------------

CREATE VIEW summary_list AS
    SELECT 
        ch.name AS name,
        we.name AS right_hand, #if(ch.we_rh=we_id,we.name),
        ar.name AS ar,
        we.name AS left_hand,
        ra.name AS race,
        cl.name AS class
    FROM
        characters ch
        join
        weapons we
        on ch.id_we_rh=we.id_we
        
        join
        
        
        armors ar,
        race ra,
        class cl
;

#drop view summary_list;

select * from summary_list;

select imie, nazwisko data, nazwa, miasto, kraj_s from zawody join skocznie on zawody.id_skoczni=skocznie.id_skocznie join zawodnicy on kraj_s=kraj;


### Players boxes
-- --------------

CREATE VIEW firstPlayer AS
    SELECT 
        *
    FROM
        summary_list
    WHERE
        name = 'Lena'
;



