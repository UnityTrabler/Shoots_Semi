CREATE TABLE report(
    report_id NUMBER(10) PRIMARY KEY, --신고글 번호
    report_type char(1) CHECK (report_type IN ('A', 'B', 'C')), --신고글 카테고리 A/B/C = 게시글/댓글/매칭선수
    report_ref_id number(10), -- 카테고리에 따라 참조해올 글의 식별번호: A/B/C = post_id / comment_id / match_id
    reporter number(10)  references regular_user(idx) on delete cascade, --신고하는
    target number(10)  references regular_user(idx) on delete cascade, --신고 당하는
    title varchar2(100) NOT NULL, --신고제목
    content clob NOT NULL, --신고내용
    report_file varchar2(50), --첨부파일, 현재 안쓸것.
    register_date timestamp DEFAULT current_timestamp  --신고일
);

CREATE SEQUENCE report_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

select * from REPORT;