USE gameMW;

 CREATE TABLE IF NOT EXISTS gameMW.player1_hand (
	id_ph2 int,
    name VARCHAR(15),
	right_hand varchar(15),
	left_hand varchar(15),
	armor varchar(15),
	race varchar(15),
	class varchar(15),
	min_attack TINYINT,
	max_attack TINYINT,
	defence TINYINT
);
select * from characters;
insert into gameMW.player1_hand (name) values('test');
select * from gameMW.player1_hand;
DROP table gameMW.player1_hand;

insert into gameMW.player2_hand select * from summary_list;
select * from gameMW.player2_hand;
 

Create trigger update_p1 after insert on gameMW.player1_hand for each row
	update gameMW.characters set choice = true where name = new.name;
    

drop trigger update_p2;




















-- --------------------
### Player - operations
-- --------------------
Insert into gameMW.players(login, password, email, first_log, last_log) 
	values  ('input_login', 'input_password', 'input_email@', now(), now()); -- Adding a player
 
UPDATE gameMW.players SET last_log = NOW() WHERE login = 'input_login'; -- Last_log update 















    
select ceil(rand()*2); -- Draw the order of players/ general draw

Insert into gameMW.player1_hand(id_ch) 
	values  (2/*input_id_ch*/);


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 -- --------------------
### Last_log update 
-- --------------------

UPDATE gameMW.players SET last_log = NOW() WHERE login = 'input_login';

 -- --------------------
### Rank update
-- --------------------

UPDATE gameMW.players SET rank = rank + 1 WHERE login = 'input_login';



-- --------------------
### Player - operations
-- --------------------
 
UPDATE gameMW.players SET last_log = NOW() WHERE login = 'input_login'; -- Last_log update 



    
select ceil(rand()*2); -- Draw the order of players/ general draw









