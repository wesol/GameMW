-- -----------------
-- Database creating
-- -----------------

CREATE SCHEMA IF NOT EXISTS gameMW;
USE gameMW;

#drop database gameMW;

-- -----------------
-- Tables creating
-- -----------------

CREATE TABLE IF NOT EXISTS gameMW.weapons (
    id_we INT AUTO_INCREMENT,
    name VARCHAR(15) NOT NULL,
    min_attack TINYINT UNSIGNED DEFAULT 0,
    max_attack TINYINT UNSIGNED DEFAULT 0,
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
    min_attack TINYINT UNSIGNED DEFAULT 0,
    max_attack TINYINT UNSIGNED DEFAULT 0,
    defence TINYINT UNSIGNED DEFAULT 0,
    PRIMARY KEY (id_ra)
);

#drop table gameMW.race;

CREATE TABLE IF NOT EXISTS gameMW.class (
    id_cl INT NOT NULL,
    name VARCHAR(15) NOT NULL,
    min_attack TINYINT UNSIGNED DEFAULT 0,
    max_attack TINYINT UNSIGNED DEFAULT 0,
    defence TINYINT UNSIGNED DEFAULT 0,
    PRIMARY KEY (id_cl)
);

#drop table gameMW.class;

CREATE TABLE IF NOT EXISTS gameMW.characters (
    id_ch int auto_increment,
    name VARCHAR(15) NOT NULL,
    min_attack TINYINT UNSIGNED DEFAULT 5,
    max_attack TINYINT UNSIGNED DEFAULT 5,
    defence TINYINT NULL DEFAULT 5,
    id_we_rh INT,
    id_ar INT,
    id_we_lh INT,
    id_ra INT,
    id_cl INT,
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


-- --------------
### Players boxes
-- --------------


 CREATE TABLE IF NOT EXISTS gameMW.players (
    login VARCHAR(20),
    password VARCHAR(30),
    email VARCHAR(30),
    first_log DATETIME,
    last_log DATETIME,
    rank INT default 0,
    PRIMARY KEY (login)
);

#drop table gameMW.players;

 CREATE TABLE IF NOT EXISTS gameMW.player1_hand (
    id_p1 INT AUTO_INCREMENT,
    id_ch INT,
    PRIMARY KEY (id_p1),
    FOREIGN KEY (id_ch)
        REFERENCES characters (id_ch)
);

 CREATE TABLE IF NOT EXISTS gameMW.player2_hand (
    id_p2 INT AUTO_INCREMENT,
    id_ch INT,
    PRIMARY KEY (id_p2),
    FOREIGN KEY (id_ch)
        REFERENCES characters (id_ch)
);

-- -----------------
-- Data loadingGameMW/tables/
-- -----------------

load data local infile 'D:/Rkfr/__projects/GameMW/tables/weapons.csv' 
	into table gameMW.weapons
	FIELDS TERMINATED BY ';' 
  	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
    (id_we, name, min_attack, max_attack, defence, onehanded)
    SET 
    min_attack = if(min_attack='', 5, min_attack),
    max_attack = if(max_attack='', 5, max_attack),
    defence = if(defence='', 0, defence),
    onehanded = if(onehanded='', 1, onehanded)
;

load data local infile 'D:/Rkfr/__projects/GameMW/tables/armors.csv' 
	into table gameMW.armors
	FIELDS TERMINATED BY ';' 
  	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
    (id_ar, name, defence)
    SET 
    defence = if(defence='', 0, defence)
;

load data local infile 'D:/Rkfr/__projects/GameMW/tables/race.csv' 
	into table gameMW.race
	FIELDS TERMINATED BY ';' 
  	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
    (id_ra, name, min_attack, max_attack, defence)
    SET 
    min_attack = if(min_attack='', 5, min_attack),
    max_attack = if(max_attack='', 5, max_attack),
    defence = if(defence='', 0, defence)
;

load data local infile 'D:/Rkfr/__projects/GameMW/tables/class.csv' 
	into table gameMW.class
	FIELDS TERMINATED BY ';' 
  	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
    (id_cl, name, min_attack, max_attack, defence)
    SET 
    min_attack = if(min_attack='', 5, min_attack),
    max_attack = if(max_attack='', 5, max_attack),
    defence = if(defence='', 0, defence)
;


load data local infile 'D:/Rkfr/__projects/GameMW/tables/characters.csv' 
	into table characters
	FIELDS TERMINATED BY ';' 
  	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
    (name, min_attack, max_attack, defence, id_we_rh, id_ar, id_we_lh, id_ra, id_cl)
    SET 
    min_attack = if(min_attack='', 5, min_attack),
    max_attack = if(max_attack='', 5, max_attack),
    defence = if(defence='', 5, defence),
    id_we_lh = if(id_we_lh='', null, id_we_lh),
    id_we_rh = if(id_we_rh='', null, id_we_rh)
;


-- -----------------
-- tables content showing
-- -----------------


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
        ch.id_ch AS ID,
        ch.name AS name,
        we_rh.name AS right_hand,
        we_lh.name AS left_hand,
        ar.name AS armor,
        ra.name AS race,
        cl.name AS class,
        (ch.min_attack + we_rh.min_attack + we_rh.min_attack + ra.min_attack + cl.min_attack) AS min_attack,
        (ch.max_attack + we_rh.max_attack + we_rh.max_attack + ra.max_attack + cl.max_attack) AS max_attack,
        (ch.defence + we_rh.defence + ar.defence + we_rh.defence + ra.defence + cl.defence) AS defence
    FROM
        characters ch
            LEFT JOIN
        weapons we_rh ON ch.id_we_rh = we_rh.id_we
            LEFT JOIN
        armors ar ON ch.id_ar = ar.id_ar
            LEFT JOIN
        weapons we_lh ON ch.id_we_lh = we_lh.id_we
            LEFT JOIN
        race ra ON ch.id_ra = ra.id_ra
            LEFT JOIN
        class cl ON ch.id_cl = cl.id_cl;
        
#drop view summary_list;
select * from summary_list order by name desc;


### player1_view


CREATE VIEW gameMW.player1_view AS
    SELECT 
        ch.id_ch AS ID,
        ch.name AS name,
        we_rh.name AS right_hand,
        we_lh.name AS left_hand,
        ar.name AS armor,
        ra.name AS race,
        cl.name AS class,
        (ch.min_attack + we_rh.min_attack + we_rh.min_attack + ra.min_attack + cl.min_attack) AS min_attack,
        (ch.max_attack + we_rh.max_attack + we_rh.max_attack + ra.max_attack + cl.max_attack) AS max_attack,
        (ch.defence + we_rh.defence + ar.defence + we_rh.defence + ra.defence + cl.defence) AS defence
    FROM
        player1_hand p1
            LEFT JOIN
        characters ch ON P1.id_ch = ch.id_ch
            LEFT JOIN
        weapons we_rh ON ch.id_we_rh = we_rh.id_we
            LEFT JOIN
        armors ar ON ch.id_ar = ar.id_ar
            LEFT JOIN
        weapons we_lh ON ch.id_we_lh = we_lh.id_we
            LEFT JOIN
        race ra ON ch.id_ra = ra.id_ra
            LEFT JOIN
        class cl ON ch.id_cl = cl.id_cl;





