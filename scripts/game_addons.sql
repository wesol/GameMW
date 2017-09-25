USE gameMW;

CREATE TABLE IF NOT EXISTS gameMW.events (
    id_ev INT AUTO_INCREMENT,
    id_ra INT,
    id_cl INT,
    name VARCHAR(15) NOT NULL,
    attack TINYINT,
    defence TINYINT,
    description VARCHAR(160),
    PRIMARY KEY (id_ev),
    FOREIGN KEY (id_ra)
        REFERENCES gameMW.race (id_ra),
    FOREIGN KEY (id_cl)
        REFERENCES gameMW.class (id_cl)
);

#drop table gameMW.events;

load data local infile 'D:/Rkfr/__projects/GameMW/GameMW/tables/events.csv' 
	into table characters
	FIELDS TERMINATED BY ';' 
  	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
    (id_ra, id_cl, name, attack, defence, description)
    SET 
    id_ra = if(id_ra='', null, id_we_lh),
    id_cl = if(id_cl='', null, id_we_lh)
;
