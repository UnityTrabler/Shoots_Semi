CREATE TABLE inquiry_comment(
    i_comment_id NUMBER(10) PRIMARY KEY,
    inquiry_id NUMBER(10) references inquiry(inquiry_id) on delete cascade,
    writer NUMBER(10) not null,
    content clob NOT NULL,
    register_date timestamp DEFAULT current_timestamp 
);

CREATE SEQUENCE inquiry_comment_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

drop table inquiry_comment cascade constraint;
drop sequence inquiry_comment_seq;

select * from inquiry_comment;