CREATE TABLE inquiry_comment(
    i_comment_id NUMBER(10) PRIMARY KEY,
    inquiry_id NUMBER(10) references inquiry(inquiry_id) on delete cascade,
    writer NUMBER(10) not null,
    content clob NOT NULL,
    comment_file varchar2(50),
    register_date timestamp DEFAULT current_timestamp 
);

CREATE SEQUENCE inquiry_comment_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

select * from inquiry_comment;