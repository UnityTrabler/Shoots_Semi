CREATE TABLE inquiry(
    inquiry_id NUMBER(10) PRIMARY KEY, --문의글 번호 : primary 키
    inquiry_type char(1) CHECK (inquiry_type IN ('A', 'B')), -- A : 회원, B : 기업
    inquiry_ref_idx NUMBER(10) not null, --문의자 식별번호
    title varchar2(100) NOT NULL, --문의 제목
    content clob NOT NULL, --문의 내용
    inquiry_file varchar2(50), --첨부파일
    register_date DATE DEFAULT SYSDATE --글 등록일
);

CREATE SEQUENCE inquiry_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

Select * from inquiry;

insert into INQUIRY
values (inquiry_seq.nextval, 'A', 1, '참조용 제목', '그래서 이게 작동한다고?', null, sysdate);