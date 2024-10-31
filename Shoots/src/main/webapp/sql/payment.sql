CREATE TABLE payment(
    payment_id NUMBER(10) PRIMARY KEY,
    match_id NUMBER(10) references match_post(match_id),
    buyer NUMBER(10) references regular_user(idx),
    seller NUMBER(10) references business_user(business_idx),
    payment_method varchar2(20) NOT NULL,
    amount number(10) NOT NULL,
    payment_date DATE DEFAULT SYSDATE,
    status varchar2(10) NOT NULL,
    transaction_id varchar2(30)
);

CREATE SEQUENCE payment_seq
START WITH 1
INCREMENT BY 1
NOCACHE;