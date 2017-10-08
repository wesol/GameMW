USE gameMW;

<<<<<<< HEAD

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
### Triggers
-- --------------------


/*Create trigger rank_update after update on gameMW.characters for each row
	UPDATE gameMW.players SET rank = rank + 1 WHERE login = 'input_login'; -- ### Rank update
    */
#drop trigger rank_update;


Create trigger XXX after insert on gameMW.player1_hand for each row
	delete from gameMW.characters where id_ch= 2 /*input id*/;



select * from players;
select * from player1_hand;
select * from player1_view;
=======
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
select * from gameMW.players;
-- --------------------
### Wprowadzanie gracza
-- --------------------
Insert into gameMW.players(login, password, email, first_log, last_log) 
	values  ('input_login', 'input_password', 'input_email@', now(), now());
 
 -- --------------------
### Last_log update 
-- --------------------

UPDATE gameMW.players SET last_log = NOW() WHERE login = 'input_login';

 -- --------------------
### Rank update
-- --------------------

UPDATE gameMW.players SET rank = rank + 1 WHERE login = 'input_login';




>>>>>>> dc8e36eb1332bc52f45a59b4f85e258416d24ef2


