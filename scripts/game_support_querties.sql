CREATE DATABASE IF NOT EXISTS test;
USE test;
#drop database test
;
create table tabela1 (
	kol1 int,
    kol2 int
);
create table tabela2 (
	kol1 tinyint,
    kol2 tinyint
);

create view view1 as (select * from tabela1);


insert into tabela1 values (1,2);

insert into tabela2 select * from view1;
select * from tabela1;
select * from tabela2;

update gameMW.characters set choice = true where id_ch= 2;

-- --------------------
### Triggers
-- --------------------
Create trigger update_p1 after insert on gameMW.player1_hand for each row
	update gameMW.characters set choice = true where name = new.name;

Create trigger update_p2 after insert on gameMW.player2_hand for each row
	update gameMW.characters set choice = true where name = new.name;