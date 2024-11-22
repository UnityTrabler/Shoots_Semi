
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
values (user_seq.nextval, 'test', '1', '강성현',  000305, 4, '01097117305', 'shk7357@naver.com', null, null, current_timestamp, 'common');

insert into regular_user
values (user_seq.nextval, 'test1', '1', '강강강',  990101, 1, '01000001234', 'nid@naver.com', null, null, current_timestamp, 'common');

insert into regular_user
values (user_seq.nextval, 'test2', '1', '김동휘',  020102, 3, '01099829384', 'gid@gmail.com', null, null, current_timestamp, 'common');

insert into regular_user
values (user_seq.nextval, 'test3', '1', '임현빈',  880910, 2, '01026374637', 'did@daum.net', null, null, current_timestamp, 'common');

insert into regular_user
values (user_seq.nextval, 'test4', '1', '최영수',  890207, 2, '01026737374', 'sidi@naver.com', null, null, current_timestamp, 'common');

insert into regular_user
values (user_seq.nextval, 'test5', '1', '최주경',  981215, 1, '01092837465', 'lkjfd@naver.com', null, null, current_timestamp, 'common');

insert into regular_user
values (user_seq.nextval, 'test6', '1', '김임최',  840506, 2, '01083848384', 'iudhsf7@naver.com', null, null, current_timestamp, 'common');

insert into regular_user
values (user_seq.nextval, 'test7', '1', '강김임최',  980919, 2, '01098723231', 'uiasdf@naver.com', null, null, current_timestamp, 'common');

insert into regular_user
values (user_seq.nextval, 'test8', '1', '강김임',  910203, 1, '01083848181', 'opghjk@naver.com', null, null, current_timestamp, 'common');

insert into regular_user
values (user_seq.nextval, 'Admin', '1', '관리자',  990101, 1, '01074839283', 'admin@gmail.com', null, null, current_timestamp, 'admin');


select * from regular_user u
join payment p on u.idx = p.buyer
where p.match_id = 31 and p.status = 'SUCCESS';