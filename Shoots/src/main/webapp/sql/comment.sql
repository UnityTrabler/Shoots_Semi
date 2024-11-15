<<<<<<< HEAD
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
=======
CREATE TABLE post_comment(
    comment_id NUMBER(10) PRIMARY KEY, --댓글 식별 번호
    post_id NUMBER(10) references post(post_id) on delete cascade, --게시글 아이디
    comment_ref_id NUMBER(10), --부모 댓글 아이디
    writer NUMBER(10) references regular_user(idx) on delete cascade, --작성자
    content clob NOT NULL, --내용
    register_date DATE DEFAULT SYSDATE --등록일
);

CREATE SEQUENCE comment_seq
START WITH 1
INCREMENT BY 1
NOCACHE;




insert into POST_COMMENT
(comment_id, post_id, comment_ref_id, writer, content)
values(1,65,1,1,'ㅎㅇ');





select * from post_comment;
>>>>>>> branch 'main' of https://github.com/JhtaSemi3team/Shoots_semi3.git
