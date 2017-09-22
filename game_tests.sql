CREATE VIEW summary_list AS
    SELECT 
        ch.name AS name,
        we_rh.name AS right_hand,
        (ch.attack + we_rh.attack + we_rh.attack + ra.attack +cl.attack ) AS attack
    FROM
        characters ch
            JOIN
        weapons we_rh ON ch.id_we_rh = we_rh.id_we
            JOIN
        armors ar ON ch.id_ar = ar.id_ar
            JOIN
        weapons we_lh ON ch.id_we_lh = we_lh.id_we
            JOIN
        race ra ON ch.id_ra = ra.id_ra
            JOIN
        class cl ON ch.id_cl = cl.id_cl
      
;

select * from summary_list;
drop view summary_list;