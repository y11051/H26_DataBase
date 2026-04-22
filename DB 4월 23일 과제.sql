4월 23일 [극장 데이터베이스][판매원 데이터베이스]
판매원 테이블
Salesperson(name, age, salary)
고객 테이블
Customer(name, city, industrytype)
주문 테이블
Order(number, custname, salesperson, amount) -- 컬럼 설명
name -- 판매원/고객 이름
age -- 판매원 나이
salary -- 판매원 급여
city -- 고객 거주 도시
industrytype -- 고객 직업
number -- 주문번호
custname -- 주문 고객 이름
salesperson -- 담당 판매원 이름
amount -- 주문 금액
문제 1. 모든 판매원의 이름, 나이, 급여를 보여주는 뷰 v_salesperson_info를 작성하시오. 
select name, age, salary from Salesperson;
문제 2. 급여가 10,000원 이상인 판매원의 이름과 급여를 보여주는 읽기 전용 뷰 v_high_salary_sp를 작성하시오. 
create view v_high_salary_sp as
select name, salary from Salesperson
where salary >= 10000;
문제 3. 나이가 30세 미만인 판매원의 이름, 나이, 급여를 보여주는 뷰 v_young_salesperson을 작성하시오. 
create view v_young_salesperson as
select name, age, salary from Salesperson
where age < 30;
문제 4. 'LA'에 거주하는 고객의 이름, 도시, 직업을 보여주는 읽기 전용 뷰 v_la_customer를 작성하시오. 
create view v_la_customer as
select name, city, industrytype from Customer
where city = 'LA';
문제 5. 직업이 '개발자'인 고객의 이름, 도시, 직업을 보여주는 뷰 v_developer_customer를 작성하시오. 
단, 조건을 벗어나는 데이터는 입력할 수 없도록 설정하시오.   
create view v_developer_customer as
select name, city, industrytype from Customer
where industrytype = '개발자';
문제 6. 주문 금액이 15,000원 이상인 주문의 주문번호, 고객이름, 담당판매원, 주문금액을 보여주는 읽기 전용 뷰 v_high_amount_order를 작성하시오.
create view v_high_amount_order as
select number, custname, salesperson, amount from Order
where amount >= 15000;
문제 7. 급여가 8,000원 이상 12,000원 이하인 판매원의 이름, 나이, 급여를 보여주는 뷰 v_mid_salary_sp를 작성하시오. 
단, 조건을 벗어나는 데이터는 입력할 수 없도록 설정하시오. 
create view v_mid_salary_sp as
select name, age, salary from Salesperson
where salary >= 8000 and salary <= 12000;
문제 8.담당 판매원이 'Tom'인 주문의 주문번호, 고객이름, 담당판매원, 주문금액을 보여주는 뷰 v_tom_order를 작성하시오. 
create view v_tom_order as
select number, custname, salesperson, amount from Order
where salesperson = 'Tom';
문제 9. 이름이 'S'로 시작하는 판매원의 이름, 나이, 급여를 보여주는 읽기 전용 뷰 v_s_salesperson을 작성하시오. 
create view v_s_salesperson as
select name, age, salary from Salesperson
where name like 'S%';
문제 10. 주문 금액이 5,000원 이상 10,000원 이하인 주문의 주문번호, 고객이름, 담당판매원, 주문금액을 보여주는 뷰 v_mid_amount_order를 작성하시오.
단, 조건을 벗어나는 데이터는 입력할 수 없도록 설정하시오.
create view v_mid_amount_order as
select number, custname, salesperson, amount from Order
where amount >= 5000 and amount <= 10000;

(복합 뷰)
문제 1.
판매원별 총 주문금액과 주문 횟수를 보여주는 뷰 v_sp_order_summary를 작성하시오.
(출력 컬럼 : 판매원이름, 총주문금액, 주문횟수)
CREATE OR REPLACE VIEW v_sp_order_summary AS
SELECT s.name AS 판매원이름,
 SUM(o.amount) AS 총주문금액,
 COUNT(o.number) AS 주문횟수
FROM Salesperson s
JOIN "Order" o ON s.name = o.salesperson
GROUP BY s.name;
문제 2.
고객별 총 주문금액과 주문 횟수를 보여주는 뷰 v_cust_order_summary를 작성하시오.
(출력 컬럼 : 고객이름, 도시, 총주문금액, 주문횟수)
CREATE OR REPLACE VIEW v_cust_order_summary AS
SELECT c.name AS 고객이름,
 c.city AS 도시,
 SUM(o.amount) AS 총주문금액,
 COUNT(o.number) AS 주문횟수
FROM Customer c
JOIN "Order" o ON c.name = o.custname
GROUP BY c.name, c.city;
문제 3.
판매원의 평균 급여보다 높은 급여를 받는 판매원의
이름, 나이, 급여를 보여주는 뷰 v_above_avg_salary를 작성하시오. CREATE OR REPLACE VIEW v_above_avg_salary AS
SELECT name AS 이름,
 age AS 나이,
 salary AS 급여
FROM Salesperson
WHERE salary > (
 SELECT AVG(salary)
 FROM Salesperson
);
문제 4.
한 번도 주문을 받지 못한 판매원의
이름, 나이, 급여를 보여주는 뷰 v_no_order_sp를 작성하시오. CREATE OR REPLACE VIEW v_no_order_sp AS
SELECT s.name AS 이름,
 s.age AS 나이,
 s.salary AS 급여
FROM Salesperson s
LEFT JOIN "Order" o ON s.name = o.salesperson
WHERE o.number IS NULL;
문제 5.
'LA'에 거주하는 고객으로부터 주문을 받은 판매원의
이름, 나이, 급여를 보여주는 뷰 v_la_order_sp를 작성하시오. CREATE OR REPLACE VIEW v_la_order_sp AS
SELECT DISTINCT s.name AS 이름,
 s.age AS 나이,
 s.salary AS 급여
FROM Salesperson s
JOIN "Order" o ON s.name = o.salesperson
JOIN Customer c ON o.custname = c.name
WHERE c.city = 'LA';
문제 6.
판매원별 평균 주문금액을 계산하여
전체 평균 주문금액보다 높은 판매원의 이름과 평균주문금액을 보여주는
뷰 v_above_avg_order_sp를 작성하시오. CREATE OR REPLACE VIEW v_above_avg_order_sp AS
SELECT s.name AS 판매원이름,
 ROUND(AVG(o.amount), 2) AS 평균주문금액
FROM Salesperson s
JOIN "Order" o ON s.name = o.salesperson
GROUP BY s.name
HAVING AVG(o.amount) > (
 SELECT AVG(amount)
 FROM "Order"
);
문제 7.
한 번도 주문하지 않은 고객의 이름, 도시, 직업을 보여주는 뷰 v_no_order_cust를 작성하시오. CREATE OR REPLACE VIEW v_no_order_cust AS
SELECT c.name AS 이름,
 c.city AS 도시,
 c.industrytype AS 직업
FROM Customer c
LEFT JOIN "Order" o ON c.name = o.custname
WHERE o.number IS NULL;
문제 8.
2건 이상 주문을 받은 판매원의
이름과 주문 횟수, 총 주문금액을 보여주는 뷰 v_frequent_sp를 작성하시오. CREATE OR REPLACE VIEW v_frequent_sp AS
SELECT s.name AS 이름,
 COUNT(o.number) AS 주문횟수,
 SUM(o.amount) AS 총주문금액
FROM Salesperson s
JOIN "Order" o ON s.name = o.salesperson
GROUP BY s.name
HAVING COUNT(o.number) >= 2;
문제 9.
고객의 도시별 총 주문금액과 주문 건수를 보여주는
뷰 v_city_order_stats를 작성하시오.
(출력 컬럼 : 도시, 총주문금액, 주문건수)
CREATE OR REPLACE VIEW v_city_order_stats AS
SELECT c.city AS 도시,
 SUM(o.amount) AS 총주문금액,
 COUNT(o.number) AS 주문건수
FROM Customer c
JOIN "Order" o ON c.name = o.custname
GROUP BY c.city;
문제 10.
판매원별 최고 주문금액, 최저 주문금액, 평균 주문금액과
자신의 급여 대비 총 주문금액 비율을 보여주는
뷰 v_sp_order_stats를 작성하시오.
(출력 컬럼 : 판매원이름, 급여, 최고주문금액, 최저주문금액, 평균주문금액, 급여대비주문비율)
CREATE OR REPLACE VIEW v_sp_order_stats AS
SELECT s.name AS 판매원이름,
 s.salary AS 급여,
 MAX(o.amount) AS 최고주문금액,
 MIN(o.amount) AS 최저주문금액,
 ROUND(AVG(o.amount), 2) AS 평균주문금액,
 ROUND(SUM(o.amount) / s.salary * 100, 2) AS 급여대비주문비율
FROM Salesperson s
JOIN "Order" o ON s.name = o.salesperson
GROUP BY s.name, s.salary;
문제 11.
직업별 총 주문금액과 평균 주문금액을 보여주는
뷰 v_industry_order_stats를 작성하시오.
(출력 컬럼 : 직업, 총주문금액, 평균주문금액)
CREATE OR REPLACE VIEW v_industry_order_stats AS
SELECT c.industrytype AS 직업,
 SUM(o.amount) AS 총주문금액,
 ROUND(AVG(o.amount), 2) AS 평균주문금액
FROM Customer c
JOIN "Order" o ON c.name = o.custname
GROUP BY c.industrytype;
문제 12.
판매원 중 자신의 급여보다 총 주문금액이 더 높은 판매원의
이름, 급여, 총주문금액을 보여주는 뷰 v_sp_order_over_salary를 작성하시오. CREATE OR REPLACE VIEW v_sp_order_over_salary AS
SELECT s.name AS 판매원이름,
 s.salary AS 급여,
 SUM(o.amount) AS 총주문금액
FROM Salesperson s
JOIN "Order" o ON s.name = o.salesperson
GROUP BY s.name, s.salary
HAVING SUM(o.amount) > s.salary;
문제 13.
각 판매원이 주문을 받은 고객의 수(서로 다른 고객만)와
총 주문금액을 보여주는 뷰 v_sp_cust_count를 작성하시오.
(출력 컬럼 : 판매원이름, 담당고객수, 총주문금액)
CREATE OR REPLACE VIEW v_sp_cust_count AS
SELECT s.name AS 판매원이름,
 COUNT(DISTINCT o.custname) AS 담당고객수,
 SUM(o.amount) AS 총주문금액
FROM Salesperson s
JOIN "Order" o ON s.name = o.salesperson
GROUP BY s.name;
문제 14.
주문 금액이 가장 높은 주문을 한 고객의
이름, 도시, 직업, 주문금액을 보여주는 뷰 v_max_order_cust를 작성하시오. CREATE OR REPLACE VIEW v_max_order_cust AS
SELECT c.name AS 고객이름,
 c.city AS 도시,
 c.industrytype AS 직업,
 o.amount AS 주문금액
FROM Customer c
JOIN "Order" o ON c.name = o.custname
WHERE o.amount = (
 SELECT MAX(amount)
 FROM "Order"
);
문제 15.
판매원별로 주문금액의 합계를 구하고, 전체 주문금액 대비 각 판매원의 주문 비중을 보여주는
뷰 v_sp_order_ratio를 작성하시오.
(출력 컬럼 : 판매원이름, 총주문금액, 전체주문금액, 주문비중)
CREATE OR REPLACE VIEW v_sp_order_ratio AS
SELECT s.name AS 판매원이름,
 SUM(o.amount) AS 총주문금액,
 (SELECT SUM(amount) FROM "Order") AS 전체주문금액,
 ROUND(SUM(o.amount) / (SELECT SUM(amount) FROM "Order") * 100, 2) AS
주문비중
FROM Salesperson s
JOIN "Order" o ON s.name = o.salesperson
GROUP BY s.name;