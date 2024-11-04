CREATE TABLE match_post(
    match_id NUMBER(10) PRIMARY KEY,
    writer NUMBER(10) references business_user(business_idx) on delete cascade,
    match_date date NOT NULL,
    match_time varchar2(5) NOT NULL,
    player_max NUMBER(2) NOT NULL,
    player_min NUMBER(2) NOT NULL,
    player_gender char(1) NOT NULL,
    price NUMBER(10) NOT NULL,
    register_date DATE DEFAULT SYSDATE 
);

CREATE SEQUENCE match_seq
START WITH 1
INCREMENT BY 1
NOCACHE;


select * from match_post order by match_id desc;               