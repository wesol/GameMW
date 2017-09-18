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