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