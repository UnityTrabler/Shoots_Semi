DROP TABLE regular_user CASCADE CONSTRAINTS PURGE;
CREATE TABLE regular_user (
    idx NUMBER(10) PRIMARY KEY,
    user_id VARCHAR2(30) NOT NULL,
    password VARCHAR2(20) NOT NULL,
    name VARCHAR2(20) NOT NULL,
    jumin NUMBER(6) NOT NULL,
    gender NUMBER(1) CHECK (gender IN (1, 2, 3, 4)),
    tel VARCHAR2(15) NOT NULL,
    email VARCHAR2(30) NOT NULL,
    nickname VARCHAR2(20),
    user_file VARCHAR2(50),
    register_date timestamp DEFAULT current_timestamp,
    role VARCHAR2(10) DEFAULT 'common' not null
);

DROP SEQUENCE user_seq;
CREATE SEQUENCE user_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

select * from regular_user;

--테이블 수정사항 : role 이라는 컬럼 추가. 기본값 common (모든 회원), admin 값을 가지고 있으면 관리자.
alter table regular_user
add role varchar2(10) default 'common' not null;


--아이디가 admin 일 경우 role을 admin으로 업데이트
update REGULAR_USER
set role = 'admin'
where user_id = 'admin';

--임의의 데이터 3개 삽입 (로그인 전 테스트 위함)
insert into regular_user
values (user_seq.nextval, 'youngsoo1', '1', '일수',  111111, 1, '01012345678', '1@1.com', null, null, current_timestamp, 'common');

insert into regular_user
values (user_seq.nextval, 'youngsoo2', '2', '이수',  222222, 2, '01012345678', '2@2.com', null, null, current_timestamp, 'common');

insert into regular_user
values (user_seq.nextval, 'youngsoo3', '3', '삼수',  333333, 3, '01012345678', '3@3.com', null, null, current_timestamp, 'common');

-- 결제 테스트 위함
insert into regular_user
values (user_seq.nextval, 'test', '1234', '강성현',  000305, 4, '01097117305', 'shk7357@naver.com', null, null, current_timestamp, 'common');

insert into regular_user
values (user_seq.nextval, 'test2', '1234', '강성현',  000305, 4, '01097117305', 'shk7357@naver.com', null, null, current_timestamp, 'common');

insert into regular_user
values (user_seq.nextval, 'test3', '1234', '강성현',  000305, 4, '01097117305', 'shk7357@naver.com', null, null, current_timestamp, 'common');

insert into regular_user
values (user_seq.nextval, 'test4', '1234', '강성현',  000305, 4, '01097117305', 'shk7357@naver.com', null, null, current_timestamp, 'common');

insert into regular_user
values (user_seq.nextval, 'test5', '1234', '강성현',  000305, 4, '01097117305', 'shk7357@naver.com', null, null, current_timestamp, 'common');

insert into regular_user
values (user_seq.nextval, 'test6', '1234', '강성현',  000305, 4, '01097117305', 'shk7357@naver.com', null, null, current_timestamp, 'common');


