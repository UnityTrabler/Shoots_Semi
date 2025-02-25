CREATE TABLE match_post(
    match_id NUMBER(10) PRIMARY KEY,
    writer NUMBER(10) references business_user(business_idx) on delete cascade,
    match_date date NOT NULL,
    match_time varchar2(5) NOT NULL,
    player_max NUMBER(2) NOT NULL,
    player_min NUMBER(2) NOT NULL,
    player_gender char(1) NOT NULL,
    price NUMBER(10) NOT NULL,
    description clob, -- 추가 (11/25)
    register_date DATE DEFAULT SYSDATE 
);

CREATE SEQUENCE match_seq
START WITH 1
INCREMENT BY 1
NOCACHE;


select * from match_post order by match_id desc;

select count(*) from match_post where writer = 5;

select count(*) from match_post where writer = 5
				and extract(year from match_date) = 2024
				and extract(month from match_date) = 11

select * from 
			(select rownum rnum, j.*
					from (SELECT mp.*, b.business_name
			                FROM match_post mp
			                JOIN business_user b ON mp.writer = b.business_idx
			                AND EXTRACT(YEAR FROM mp.match_date) = 2024
			                AND EXTRACT(MONTH FROM mp.match_date) = 11
			             
			                ORDER BY mp.match_date DESC) j 
			where rownum <= 10)
where rnum >= 1 and rnum <= 10

SELECT * FROM (
                SELECT ROWNUM rnum, mp.*, b.business_name
                FROM match_post mp
                JOIN business_user b ON mp.writer = b.business_idx
                AND EXTRACT(YEAR FROM mp.match_date) = 2024
                AND EXTRACT(MONTH FROM mp.match_date) = 11
             
                ORDER BY mp.match_date DESC
	            ) p
	            WHERE p.rnum BETWEEN 1 AND 10
	            
update match_post set match_date = '2024-11-25' where match_id = 31;

delete from match_post;

select * from match_post 
				where match_date = TO_CHAR(SYSDATE, 'YYYY-MM-DD')
				order by match_time ASC
				
alter table match_post drop constraint SYS_C007215;

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'MATCH_POST';

select TABLE_NAME FROM USER_CONSTRAINTS where CONSTRAINT_NAME = 'SYS_C007220';

select mp.*, COALESCE(p.playerCount, 0) AS playerCount 
				from match_post mp
				left join (SELECT match_id, COUNT(*) AS playerCount
						     FROM payment 
						     WHERE status = 'SUCCESS'
						     GROUP BY match_id) p 
				on mp.match_id = p.match_id
				where match_date = TO_CHAR(SYSDATE, 'YYYY-MM-DD')
				order by match_time ASC;
				
SELECT * FROM match_post 
WHERE writer = 5
AND EXTRACT(YEAR FROM match_date) = 2024
AND EXTRACT(MONTH FROM match_date) = 11;

alter table match_post add description clob;

