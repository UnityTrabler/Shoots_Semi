CREATE TABLE regular_user (
    idx NUMBER(10) PRIMARY KEY,
    user_id VARCHAR2(30) NOT NULL,
    password VARCHAR2(20) NOT NULL,
    name VARCHAR2(20) NOT NULL,
    jumin NUMBER(6) NOT NULL,
    gender NUMBER(1) CHECK (gender IN (1, 2, 3, 4)),
    tel VARCHAR2(15) NOT NULL,
    email VARCHAR2(30) NOT NULL,
    nickname VARCHAR2(20),
    user_file VARCHAR2(50),
    register_date timestamp DEFAULT current_timestamp
);

CREATE SEQUENCE user_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

select * from regular_user;

insert into regular_user
values (user_seq.nextval, 'youngsoo1', '1', '일수',  111111, 1, '01012345678', '1@1.com', null, null, current_timestamp);

insert into regular_user
values (user_seq.nextval, 'youngsoo2', '2', '이수',  222222, 2, '01012345678', '2@2.com', null, null, current_timestamp);

insert into regular_user
values (user_seq.nextval, 'youngsoo3', '3', '삼수',  333333, 3, '01012345678', '3@3.com', null, null, current_timestamp);