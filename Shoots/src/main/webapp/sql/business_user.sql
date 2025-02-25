DROP TABLE business_user CASCADE CONSTRAINTS PURGE;
CREATE TABLE business_user (
    business_idx NUMBER(10) PRIMARY KEY,
    business_id VARCHAR2(30) NOT NULL,
    password VARCHAR2(20) NOT NULL,
    business_name VARCHAR2(100) NOT NULL,
    business_number NUMBER(13) NOT NULL,
    tel NUMBER(15) NOT NULL,
    email VARCHAR2(30) NOT NULL,
    post number(6) NOT NULL,
    address VARCHAR2(100) NOT NULL,
    description clob,
    business_file varchar2(50),
   	register_date timestamp DEFAULT current_timestamp,
   	login_status varchar2(9) DEFAULT 'pending'
);

DROP SEQUENCE business_seq;
CREATE SEQUENCE business_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

select * from business_user;

update business_user set password = 'a1';

update business_user
set login_status = 'approved'
where business_id = 'aa';

ALTER TABLE business_user RENAME COLUMN req TO tel;

ALTER TABLE BUSINESS_USER
MODIFY business_name VARCHAR2(100);

INSERT INTO BUSINESS_USER 
VALUES (
    business_seq.nextval, 
    'qwerty1', 
    '1234', 
    '종로구 풋살장 A', 
    '1234567891', 
    '01092837483', 
    'JongRsc@gmail.com',
    '10882', 
    '서울시 종로구 종로3가', 
    null,  
    null,  
    SYSDATE,
    'approved'
);

INSERT INTO BUSINESS_USER 
VALUES (
    business_seq.nextval, 
    'qwerty2', 
    '1234', 
    '강남구 풋살장 B', 
    '1234567891', 
    '01092834523', 
    '222@gmail.com',
    '06090', 
    '서울특별시 강남구 학동로 426 (삼성동, 강남구청)', 
    null,  
    null,  
    SYSDATE,
    'approved'
);

INSERT INTO BUSINESS_USER 
VALUES (
    business_seq.nextval, 
    'qwerty3', 
    '1234', 
    '강남구 풋살장 C', 
    '1234567891', 
    '01092567483', 
    '222@gmail.com',
    '06090', 
    '서울특별시 강남구 학동로 426 (삼성동, 강남구청)', 
    null,  
    null,  
    SYSDATE,
    'approved'
);

INSERT INTO BUSINESS_USER 
VALUES (
    business_seq.nextval, 
    'qwerty4', 
    'a1', 
    'testsetstest', 
    '0987654321232', 
    '01092343234', 
    'JongRsc@gmail.com',
    '10882', 
    '서울시 종로구 종로3가', 
    null,  
    null,  
    SYSDATE,
    'pending'
);

delete from business_user where business_id = 'qwerty4';
SELECT * FROM business_user;

update business_user set tel = '01099999999';


alter table business_user add login_status varchar2(9) DEFAULT 'pending';