CREATE TABLE inquiry(
    inquiry_id NUMBER(10) PRIMARY KEY, --문의글 번호 : primary 키
    inquiry_type char(1) CHECK (inquiry_type IN ('A', 'B')), -- A : 회원, B : 기업
    inquiry_ref_idx NUMBER(10) not null, --문의자 식별번호
    title varchar2(100) NOT NULL, --문의 제목
    content clob NOT NULL, --문의 내용
    inquiry_file varchar2(50), --첨부파일
    register_date timestamp DEFAULT current_timestamp --글 등록일
);

CREATE SEQUENCE inquiry_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

Select * from inquiry;

insert into INQUIRY
values (inquiry_seq.nextval, 'A', 1, '참조용 제목', '그래서 이게 작동한다고?', null, current_timestamp);

select * from INQUIRY
order by INQUIRY_id desc;


--1. 문의글을 쓴 글쓴이들의 식별번호 (ref_idx) = 개인회원들의 고유번호 idx 를 join해서 문의글들의 내용을 모두 뽑아오는 커리문.
-- 즉,개인 회원들중 문의글을 쓴 적 있는 사람들의 문의글들의 정보와 그 개인회원의 user_id를 모두 조회하라는 커리문.
select i.*, r.user_id 
from inquiry i 
join regular_user r 
on i.inquiry_ref_idx = r.idx;


--위의 join 커리문과 페이지네이션 (rownum)을 합쳐서 만든 커리문. 위의 커리문 조건에 맞는 문의글들을 해당 페이지에 맞춰서 데이터를 들고옴.
select * from (
SELECT ROWNUM rnum, inquiry_id, inquiry_type, inquiry_ref_idx, title, content, inquiry_file, register_date, user_id
FROM(
	select i.*, r.user_id 
	from inquiry i 
	join regular_user r 
	on i.inquiry_ref_idx = r.idx
	order by inquiry_id desc
	)
where rownum <= 10  -- 1번째 ? 자리. startrow 값 = 읽기 시작할 첫번째 페이지 값( 10페이지씩 보기시 1, 11, 21 ...)
) where rnum >= 1 -- 2번째 ? 자리. endrow 값 = 읽을 마지막 페이지 값 (10페이지 보기 로 선택시 10번째 페이지 10 20 30 40..)


-- 1. 을 다시 들고와서 문의글 쓴 유저들의 정보 (서브커리)를 뽑아 온 뒤 그 중 특정 문의글 (inquiry_id)을 찾아내는 커리문.
select * from(
			select i.*, r.user_id 
			from inquiry i 
			join regular_user r 
			on i.inquiry_ref_idx = r.idx
			order by inquiry_id desc
			)
where inquiry_id = 32;  --DAO 메서드에서 ? 부분. 특정 문의글 번호.



--2. 댓글이 달린 문의글들을 찾고 그 문의글들에 달린 댓글이 몇개인지 세는 커리문
select i.inquiry_id, count(ic.i_comment_id)
from INQUIRY i
inner join INQUIRY_COMMENT ic
on i.inquiry_id = ic.inquiry_id
group by i.inquiry_id;


