CREATE TABLE report(
    report_id NUMBER(10) PRIMARY KEY,
    report_type char(1) CHECK (report_type IN ('A', 'B', 'C')),
    report_ref_id number(10),
    reporter number(10)  references regular_user(idx) on delete cascade,
    target number(10)  references regular_user(idx) on delete cascade,
    title varchar2(100) NOT NULL,
    content clob NOT NULL,
    report_file varchar2(50),
    register_date DATE DEFAULT SYSDATE 
);

CREATE SEQUENCE report_seq
START WITH 1
INCREMENT BY 1
NOCACHE;