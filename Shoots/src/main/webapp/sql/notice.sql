CREATE TABLE notice(
    notice_id NUMBER(10) PRIMARY KEY,
    writer NUMBER(10) references regular_user(idx) on delete cascade,
    title varchar2(100) NOT NULL,
    content clob NOT NULL,
    notice_file varchar2(50),
    register_date DATE DEFAULT SYSDATE 
);

CREATE SEQUENCE notice_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

ALTER TABLE notice
ADD readcount number;

ALTER TABLE notice
ADD notice_num number;

ALTER TABLE notice DROP COLUMN notice_num

select * from notice 