CREATE TABLE refund(
    refund_id NUMBER(10) PRIMARY KEY,
    payment_id NUMBER(10) references payment(payment_id),
    buyer NUMBER(10) references regular_user(idx),
    seller NUMBER(10) references business_user(business_idx),
    reason varchar2(100) NOT NULL,
    amount number(10) NOT NULL,
    refund_date DATE DEFAULT SYSDATE,
    status varchar2(10) NOT NULL,
    transaction_id varchar2(30)
);

CREATE SEQUENCE refund_seq
START WITH 1
INCREMENT BY 1
NOCACHE;