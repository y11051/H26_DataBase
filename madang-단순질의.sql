
문제 1
고객별 총 주문금액과 주문 횟수를 보여주는 뷰 v_cust_order_summary를 작성하시오.
(출력 컬럼: 고객이름, 총주문금액, 주문횟수)
CREATE OR REPLACE VIEW v_cust_order_summary
AS
SELECT 
    c.name AS 고객이름, 
    SUM(o.saleprice) AS 총주문금액, 
    COUNT(o.orderid) AS 주문횟수
FROM 
    Customer c, Orders o
WHERE 
    c.custid = o.custid  -- 이 부분이 FK 관계를 이용한 조인입니다
GROUP BY 
    c.name;

문제 2.
각 도서의 도서명, 출판사, 판매된 총 수량(주문 횟수), 총 판매금액을 보여주는 뷰
v_book_sales를 작성하시오.
CREATE OR REPLACE VIEW v_book_sales
AS
SELECT 
    b.bookname AS 도서명, 
    b.publisher AS 출판사, 
    COUNT(o.orderid) AS 총판매수량, 
    SUM(o.saleprice) AS 총판매금액
FROM 
    Book b, Orders o
WHERE 
    b.bookid = o.bookid  -- 이 부분이 FK 관계를 이용한 조인입니다
GROUP BY 
    b.bookname, b.publisher;

문제 3.
주문한 적 있는 고객의 이름, 주소, 가장 최근 주문일을 보여주는 뷰 v_cust_last_order
를 작성하시오. 
CREATE OR REPLACE VIEW v_cust_last_order
AS
SELECT 
    c.name AS 고객이름, 
    c.address AS 주소, 
    MAX(o.orderdate) AS 최근주문일
FROM 
    Customer c, Orders o
WHERE 
    c.custid = o.custid  -- 이 부분이 FK 관계를 이용한 조인입니다
GROUP BY 
    c.name, c.address;

문제 4.
도서 정가보다 할인된 금액으로 판매된 주문 내역을 보여주는 뷰 v_discounted_orders를
작성하시오.
(출력 컬럼: 주문번호, 고객이름, 도서명, 정가, 판매가, 할인금액)
CREATE OR REPLACE VIEW v_discounted_orders
AS
SELECT 
    o.orderid AS 주문번호, 
    c.name AS 고객이름, 
    b.bookname AS 도서명, 
    b.price AS 정가, 
    o.saleprice AS 판매가, 
    (b.price - o.saleprice) AS 할인금액
FROM 
    Orders o, Book b, Customer c
WHERE 
    o.bookid = b.bookid  -- 이 부분이 FK 관계를 이용한 조인입니다
    AND o.custid = c.custid  -- 이 부분이 FK 관계를 이용한 조인입니다
    AND o.saleprice < b.price;  -- 할인된 금액으로 판매된 주문 내역을 필터링하는 조건입니다 

문제 5.
출판사별 평균 판매가격과 최고 판매가격을 보여주는 뷰 v_publisher_stats를 작성하시
오.
(출력 컬럼: 출판사, 평균판매가, 최고판매가)
CREATE OR REPLACE VIEW v_publisher_stats
AS
SELECT
    b.publisher AS 출판사, 
    AVG(o.saleprice) AS 평균판매가, 
    MAX(o.saleprice) AS 최고판매가
FROM 
    Book b, Orders o
WHERE 
    b.bookid = o.bookid  -- 이 부분이 FK 관계를 이용한 조인입니다
GROUP BY 
    b.publisher;

문제 6.
총 주문금액이 30,000원 이상인 우수 고객의 이름과 총 주문금액을 보여주는 뷰
v_vip_customer를 작성하시오. 
CREATE OR REPLACE VIEW v_vip_customer
AS
SELECT 
    c.name AS 고객이름, 
    SUM(o.saleprice) AS 총주문금액  
FROM 
    Customer c, Orders o
WHERE 
    c.custid = o.custid  -- 이 부분이 FK 관계를 이용한 조인입니다
GROUP BY 
    c.name
HAVING 
    SUM(o.saleprice) >= 30000;

문제 7.
2024년에 주문된 내역의 고객이름, 도서명, 판매가격, 주문일자를 보여주는 뷰
v_orders_2024를 작성하시오. 
CREATE OR REPLACE VIEW v_orders_2024
AS
SELECT 
    c.name AS 고객이름, 
    b.bookname AS 도서명, 
    o.saleprice AS 판매가격, 
    o.orderdate AS 주문일자
FROM 
    Customer c, Orders o, Book b
WHERE 
    c.custid = o.custid  -- 이 부분이 FK 관계를 이용한 조인입니다
    AND o.bookid = b.bookid  -- 이 부분이 FK 관계를 이용한 조인입니다
    AND EXTRACT(YEAR FROM o.orderdate) = 2024;  -- 2024년에 주문된 내역을 필터링하는 조건입니다

문제 8.
한 번도 주문되지 않은 도서의 도서명과 출판사, 정가를 보여주는 뷰 v_unsold_books를
작성하시오. 
CREATE OR REPLACE VIEW v_unsold_books
AS
SELECT 
    b.bookname AS 도서명, 
    b.publisher AS 출판사, 
    b.price AS 정가
FROM 
    Book b
WHERE 
    b.bookid NOT IN (SELECT o.bookid FROM Orders o);  -- 한 번도 주문되지 않은 도서를 필터링하는 조건입니다

문제 9.
고객별로 가장 비싸게 구매한 도서명과 그 금액을 보여주는 뷰 v_cust_max_order를 작
성하시오.
(출력 컬럼: 고객이름, 도서명, 최고구매금액)
CREATE OR REPLACE VIEW v_cust_max_order
AS
SELECT 
    c.name AS 고객이름, 
    b.bookname AS 도서명, 
    MAX(o.saleprice) AS 최고구매금액

문제 10.
도서명, 고객이름, 판매가, 해당 도서 평균 판매가, 평균 대비 차이를 보여주는 뷰
v_book_price_compare를 작성하시오.
(출력 컬럼: 도서명, 고객이름, 판매가, 도서평균판매가, 차이)
CREATE OR REPLACE VIEW v_book_price_compare
AS
SELECT
    b.bookname AS 도서명, 
    c.name AS 고객이름, 
    o.saleprice AS 판매가, 
    (SELECT AVG(saleprice) FROM Orders WHERE bookid = b.bookid) AS 도서평균판매가, 
    (o.saleprice - (SELECT AVG(saleprice) FROM Orders WHERE bookid = b.bookid)) AS 차이
FROM 
    Orders o, Book b, Customer c
WHERE 
    o.bookid = b.bookid  -- 이 부분이 FK 관계를 이용한 조인입니다
    AND o.custid = c.custid;  -- 이 부분이 FK 관계를 이용한 조인입니다

