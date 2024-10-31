CREATE TABLE faq(
    faq_id NUMBER(10) PRIMARY KEY,
    writer NUMBER(10) references regular_user(idx) on delete cascade,
    title varchar2(100) NOT NULL,
    content clob NOT NULL,
    faq_file varchar2(50),
    register_date DATE DEFAULT SYSDATE 
);

CREATE SEQUENCE faq_seq
START WITH 1
INCREMENT BY 1
NOCACHE;