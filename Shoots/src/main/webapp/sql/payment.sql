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

INSERT INTO PAYMENT
VALUES (
    payment_seq.nextval, 5, 4, 1, 'kakao', 1000, 
    TO_DATE('2024-11-23 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
    'SUCCESS', '1', '1', 'shit'
);


insert into payment values (payment_seq.nextval, 68, 14, 12, 'card', 1000, sysdate, 'SUCCESS', '111', '111','111');
insert into payment values (payment_seq.nextval, 68, 26, 12, 'card', 1000, sysdate, 'SUCCESS', '111', '111','111');
insert into payment values (payment_seq.nextval, 68, 25, 12, 'card', 1000, sysdate, 'SUCCESS', '111', '111','111');
insert into payment values (payment_seq.nextval, 68, 28, 12, 'card', 1000, sysdate, 'SUCCESS', '111', '111','111');
insert into payment values (payment_seq.nextval, 68, 27, 12, 'card', 1000, sysdate, 'SUCCESS', '111', '111','111');

update payment set seller = 12 where match_id = 84;


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

SELECT * FROM (
    SELECT u.idx, u.user_id, u.name, u.email, COUNT(p.seller) AS payment_count
    FROM regular_user u
    INNER JOIN payment p 
        ON u.idx = p.buyer
    WHERE p.seller = 5 
      AND p.status != 'REFUNDED'
    GROUP BY u.idx, u.user_id, u.name, u.email,p.seller
    ORDER BY payment_count DESC
) 
WHERE ROWNUM <= 10;
