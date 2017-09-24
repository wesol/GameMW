CREATE TABLE IF NOT EXISTS gameMW.characters (
    id_ch INT AUTO_INCREMENT,
    name VARCHAR(15) NOT NULL,
    attack TINYINT UNSIGNED DEFAULT 5,
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
    

load data local infile 'D:/Rkfr/__projects/GameMW/characters.csv' 
	into table characters
	FIELDS TERMINATED BY ';' 
  	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
    (name, attack, defence, id_we_rh, id_ar, id_we_lh, id_ra, id_cl)
    SET 
    attack = if(attack='', 5, attack),
    defence = if(defence='', 5, defence),
    id_we_lh = if(id_we_lh='', null, id_we_lh),
    id_we_rh = if(id_we_rh='', null, id_we_rh)
;

select * from characters;

drop table gameMW.characters;