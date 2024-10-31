CREATE TABLE business_user (
    business_idx NUMBER(10) PRIMARY KEY,
    business_id VARCHAR2(30) NOT NULL,
    password VARCHAR2(20) NOT NULL,
    business_name VARCHAR2(20) NOT NULL,
    business_number NUMBER(13) NOT NULL,
    req NUMBER(15) NOT NULL,
    email VARCHAR2(30) NOT NULL,
    post number(6) NOT NULL,
    address VARCHAR2(100) NOT NULL,
    description clob,
    business_file varchar2(50),
    register_date DATE DEFAULT SYSDATE 
);

CREATE SEQUENCE business_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

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


SELECT * FROM business_user;