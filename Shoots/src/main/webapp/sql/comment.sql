/*
CREATE TABLE post_comment(
    comment_id NUMBER(10) PRIMARY KEY, --댓글 식별 번호
    post_id NUMBER(10) references post(post_id) on delete cascade, --게시글 아이디
    comment_ref_id NUMBER(10), --부모 댓글 아이디
    writer NUMBER(10) references regular_user(idx) on delete cascade, --작성자
    content clob NOT NULL, --내용
    register_date DATE DEFAULT SYSDATE --등록일
);
*/


CREATE TABLE post_comment (
    comment_id NUMBER(10) PRIMARY KEY, -- 댓글 식별 번호
    post_id NUMBER(10) REFERENCES post(post_id) ON DELETE CASCADE, -- 게시글 아이디
    comment_ref_id NUMBER(10) REFERENCES post_comment(comment_id), -- 부모 댓글 아이디 (자기참조)
    writer NUMBER(10) REFERENCES regular_user(idx) ON DELETE CASCADE, -- 작성자
    content CLOB NOT NULL, -- 내용
    register_date DATE DEFAULT SYSDATE -- 등록일
);



CREATE SEQUENCE comment_seq
START WITH 1
INCREMENT BY 1
NOCACHE;



drop table post_comment;
drop sequence comment_seq;




insert into POST_COMMENT
(comment_id, post_id, comment_ref_id, writer, content)
values(1, 65, null,1,'ㅎㅇ');

insert into POST_COMMENT
(comment_id, post_id, comment_ref_id, writer, content)
values(2, 65, null, 1, 'ㅎㅇ');

insert into POST_COMMENT
(comment_id, post_id, comment_ref_id, writer, content)
values(3, 65, null, 3, 'ㅎㅇ');



select * from post_comment;




SELECT co.*, r.user_id
FROM post_comment co
JOIN regular_user r ON co.writer = r.idx
WHERE co.post_id = 65
ORDER BY co.comment_id ASC;