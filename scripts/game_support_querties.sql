USE gameMW;


select login, plays, wons from players;
select * from all_players;
select * from all_players where login != 'guest' and login != 'guest2' ;


SELECT login, CASE WHEN login='guest' THEN True ELSE False END AS bmi FROM gameMW.all_players;
select email from all_players where email = 'g@g.g';

insert into gameMW.players (login, password, email, first_log, last_log)
	values  ('guest1', 'g', 'g@g.g', now(), now());



select login from all_players where login = 'j';

### draw wchich players first
-- --------------

#fight

select * from players card 

### player1_view
/*CREATE VIEW gameMW.player1_view AS
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
        

select * from gamemw.player1_view;*/