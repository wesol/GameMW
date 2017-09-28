USE gameMW;

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






