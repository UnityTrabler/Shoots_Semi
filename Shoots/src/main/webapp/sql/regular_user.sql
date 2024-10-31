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
    register_date DATE DEFAULT SYSDATE 
);

CREATE SEQUENCE user_seq
START WITH 1
INCREMENT BY 1
NOCACHE;