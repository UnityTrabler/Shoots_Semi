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


--1. 문의댓글을 쓴 사람 (writer)의 모든 문의댓글 정보와 그 작성자의 닉네임 (user_id)를 조회하는 조인 커리문 (writer = idx면 select) 
select ic.*, r.user_id
from inquiry_comment ic
join regular_user r
on ic.writer = r.idx;

--2. 위의 1번 에서 문의글 번호 (inquiry_id)가 23번인 문의댓글의 정보들과 그 댓글의 작성자 닉네임 (user_id)을 뽑아내는 커리문 + 내림차순 정렬 (신규 댓글이 밑으로)
select * from (
	select ic.*, r.user_id
	from inquiry_comment ic
	join regular_user r
	on ic.writer = r.idx)
where inquiry_id = 23
order by i_comment_id asc;