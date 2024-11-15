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

SELECT * FROM business_user;

ALTER TABLE business_user RENAME COLUMN req TO tel;


INSERT INTO BUSINESS_USER 
VALUES (
    business_seq.nextval, 
    'businessAdmin', 
    '1234', 
    '기업관리자', 
    '1234567891', 
    '0319090909', 
    'htaFoot@gmail.com',
    '12345', 
    '서울시 종로구', 
    null,  
    null,  
    SYSDATE
);

ALTER TABLE BUSINESS_USER
MODIFY business_name VARCHAR2(100);

INSERT INTO BUSINESS_USER 
VALUES (
    business_seq.nextval, 
    'qwerty1', 
    '1234', 
    '종로구 풋살장 A', 
    '1234567891', 
    '028088080', 
    'JongRsc@gmail.com',
    '10882', 
    '서울시 종로구 종로3가', 
    null,  
    null,  
    SYSDATE
);

INSERT INTO BUSINESS_USER 
VALUES (
    business_seq.nextval, 
    'qwerty2', 
    '1234', 
    '강남구 풋살장 B', 
    '1234567891', 
    '354345', 
    '222@gmail.com',
    '06090', 
    '서울특별시 강남구 학동로 426 (삼성동, 강남구청)', 
    null,  
    null,  
    SYSDATE
);

INSERT INTO BUSINESS_USER 
VALUES (
    business_seq.nextval, 
    'qwerty3', 
    '1234', 
    '강남구 풋살장 C', 
    '1234567891', 
    '354345', 
    '222@gmail.com',
    '06090', 
    '서울특별시 강남구 학동로 426 (삼성동, 강남구청)', 
    null,  
    null,  
    SYSDATE
);


