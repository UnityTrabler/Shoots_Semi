<<<<<<< HEAD
drop table refund;

CREATE TABLE refund(
    refund_id NUMBER(10) PRIMARY KEY,
    payment_id NUMBER(10) references payment(payment_id),
    buyer NUMBER(10) references regular_user(idx),
    seller NUMBER(10) references business_user(business_idx),
    reason varchar2(100) NOT NULL,
    amount number(10) NOT NULL,
    refund_date DATE DEFAULT SYSDATE,
    status varchar2(10) NOT NULL,
    apply_num varchar2(30) NOT NULL,
    imp_uid varchar2(30) NOT NULL
);

CREATE SEQUENCE refund_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

select * from REFUND order by refund_id desc ;
=======
drop table refund;

CREATE TABLE refund(
    refund_id NUMBER(10) PRIMARY KEY,
    payment_id NUMBER(10) references payment(payment_id),
    buyer NUMBER(10) references regular_user(idx),
    seller NUMBER(10) references business_user(business_idx),
    reason varchar2(100) NOT NULL,
    amount number(10) NOT NULL,
    refund_date DATE DEFAULT SYSDATE,
    status varchar2(10) NOT NULL,
    apply_num varchar2(30) NOT NULL,
    imp_uid varchar2(30) NOT NULL
);

CREATE SEQUENCE refund_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

select * from REFUND order by refund_id desc ;

select * from REFUND where buyer = 6 ;

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'REFUND';

alter table refund drop constraint SYS_C007282;
>>>>>>> branch 'main' of https://github.com/JhtaSemi3team/Shoots_semi3.git
