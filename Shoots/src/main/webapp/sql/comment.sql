CREATE TABLE post_comment(
    comment_id NUMBER(10) PRIMARY KEY,
    post_id NUMBER(10) references post(post_id) on delete cascade,
    comment_ref_id NUMBER(10),
    writer NUMBER(10) references regular_user(idx) on delete cascade,
    content clob NOT NULL,
    register_date DATE DEFAULT SYSDATE 
);

CREATE SEQUENCE comment_seq
START WITH 1
INCREMENT BY 1
NOCACHE;
