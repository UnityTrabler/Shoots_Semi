CREATE TABLE payment(
    payment_id NUMBER(10) PRIMARY KEY,
    match_id NUMBER(10) references match_post(match_id),
    buyer NUMBER(10) references regular_user(idx),
    seller NUMBER(10) references business_user(business_idx),
    payment_method varchar2(20) NOT NULL,
    amount number(10) NOT NULL,
    payment_date DATE DEFAULT SYSDATE,
    status varchar2(10) NOT NULL,
    apply_num varchar2(30) NOT NULL,
    imp_uid varchar2(30) NOT NULL
);

CREATE SEQUENCE payment_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

alter table payment add merchant_uid varchar2(30) not null;

select * from payment order by payment_id desc;

delete from payment;

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'PAYMENT';

alter table payment drop constraint SYS_C007220;
alter table payment drop constraint SYS_C007222;

update payment set status = 'SUCCESS' where buyer = 6 and payment_id = 55;
update payment set status = 'SUCCESS' where buyer = 6 and payment_id = 69;

select * from payment where buyer = 6 and status = 'SUCCESS';

delete from payment where buyer = 6 and match_id = 31;
