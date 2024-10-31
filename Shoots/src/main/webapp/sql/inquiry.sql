CREATE TABLE inquiry(
    inquiry_id NUMBER(10) PRIMARY KEY,
    inquiry_type char(1) CHECK (inquiry_type IN ('A', 'B')), -- A : 회원, B : 기업
    inquiry_ref_idx NUMBER(10) not null,
    title varchar2(100) NOT NULL,
    content clob NOT NULL,
    inquiry_file varchar2(50),
    register_date DATE DEFAULT SYSDATE 
);

CREATE SEQUENCE inquiry_seq
START WITH 1
INCREMENT BY 1
NOCACHE;