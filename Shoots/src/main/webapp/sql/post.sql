CREATE TABLE post (
    post_id NUMBER(10) PRIMARY KEY,
    writer NUMBER(10) NOT NULL,
    category char(1) CHECK (category IN ('A', 'B')),
    title VARCHAR2(100) NOT NULL,
    content clob NOT NULL,
    post_file VARCHAR2(50),
    price NUMBER(10),
    register_date DATE DEFAULT SYSDATE 
);

CREATE SEQUENCE post_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

ALTER TABLE post
ADD readcount number;