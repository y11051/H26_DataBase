SQL 실습예제 3장 0416 실습예제 4
문제 23.[사원 데이터베이스]
어느 기업의 사원 데이터베이스가 있다. 다음 질문에 대해 SQL문을 작성하시오. Dept는 부서(Department) 테이블로 depno(부서번호),dname(부서이름), loc(위치,location)으로 구성되어
있다. Emp는 사원(Employee)테이블로 empno(사원번호), ename(사원이름), job(업무), mgr
(팀장번호, manager), hiredate(고용날짜), sal(월급여, salary), comm(커미션금액, commission), deptno(부서번호)로 구성되어 있다. 밑줄친 속성은 기본키이고 Emp의 deptno
는 Dept의 deptno를 참조하는 외래키이며, Emp의 mgr은 자신의 상사에 대한 empno를 참조하는 외래키이다.
[실습준비] 시스템 계정으로 demo_scott_system.sql을 실행해 scott계정을 생성한 후
(사용자 이름: C##scott, 비밀번호 : tiger. 이외 madang과 동일). 생성한 계정으로
접속하여 demo_scott.sql을 실행하면 예제테이블과 데이터가 설치된다. Dept(depno NUMBER(2), dname VARCHAR(14), loc VARCHAR(13))
Emp(empno NUMBER(4), ename VARCHAR(10), job VARCHAR(9),
 mgr NUMBER(4), hiredate DATE, sal NUMBER(7,2),
 comm NUMBER(7,2), deptno NUMBER(2))
demo_scott.sql의 내용
SET TERMOUT ON
PROMPT Building demonstration tables. Please wait.
SET TERMOUT OFF
DROP TABLE EMP;
DROP TABLE DEPT;
DROP TABLE BONUS;
DROP TABLE SALGRADE;
DROP TABLE DUMMY;
CREATE TABLE EMP (
EMPNO NUMBER(4) NOT NULL,
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
MGR NUMBER(4),
HIREDATE DATE,
SAL NUMBER(7, 2),
COMM NUMBER(7, 2),
DEPTNO NUMBER(2)
);
INSERT INTO EMP VALUES (7369, 'SMITH', 'CLERK', 7902,TO_DATE('1980-12-17',
'YYYY-MM-DD'), 800, NULL, 20);
INSERT INTO EMP VALUES (7499, 'ALLEN', 'SALESMAN', 7698,TO_DATE('1981-02-20',
'YYYY-MM-DD'), 1600, 300, 30);
INSERT INTO EMP VALUES (7521, 'WARD', 'SALESMAN', 7698,TO_DATE('1981-02-22',
'YYYY-MM-DD'), 1250, 500, 30);
INSERT INTO EMP VALUES (7566, 'JONES', 'MANAGER', 7839,TO_DATE('1981-04-02',
'YYYY-MM-DD'), 2975, NULL, 20);
INSERT INTO EMP VALUES (7654, 'MARTIN', 'SALESMAN', 7698,TO_DATE('1981-09-28',
'YYYY-MM-DD'), 1250, 1400, 30);
INSERT INTO EMP VALUES (7698, 'BLAKE', 'MANAGER', 7839,TO_DATE('1981-05-01',
'YYYY-MM-DD'), 2850, NULL, 30);
INSERT INTO EMP VALUES (7782, 'CLARK', 'MANAGER', 7839,TO_DATE('1981-06-09',
'YYYY-MM-DD'), 2450, NULL, 10);
INSERT INTO EMP VALUES (7788, 'SCOTT', 'ANALYST', 7566,TO_DATE('1982-12-09',
'YYYY-MM-DD'), 3000, NULL, 20);
INSERT INTO EMP VALUES (7839, 'KING', 'PRESIDENT', NULL,TO_DATE('1981-11-17',
'YYYY-MM-DD'), 5000, NULL, 10);
INSERT INTO EMP VALUES (7844, 'TURNER', 'SALESMAN', 7698,TO_DATE('1981-09-08',
'YYYY-MM-DD'), 1500, 0, 30);
INSERT INTO EMP VALUES (7876, 'ADAMS', 'CLERK', 7788,TO_DATE('1983-01-12',
'YYYY-MM-DD'), 1100, NULL, 20);
INSERT INTO EMP VALUES (7900, 'JAMES', 'CLERK', 7698,TO_DATE('1981-12-03',
'YYYY-MM-DD'), 950, NULL, 30);
INSERT INTO EMP VALUES (7902, 'FORD', 'ANALYST', 7566,TO_DATE('1981-12-03',
'YYYY-MM-DD'), 3000, NULL, 20);
INSERT INTO EMP VALUES (7934, 'MILLER', 'CLERK', 7782,TO_DATE('1982-01-23',
'YYYY-MM-DD'), 1300, NULL, 10);
CREATE TABLE DEPT(
DEPTNO NUMBER(2),
DNAME VARCHAR2(14),
LOC VARCHAR2(13)
);
INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');
CREATE TABLE BONUS(
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
SAL NUMBER,
COMM NUMBER
);
CREATE TABLE SALGRADE(
GRADE NUMBER,
LOSAL NUMBER,
HISAL NUMBER
);
INSERT INTO SALGRADE VALUES (1, 700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);
CREATE TABLE DUMMY (DUMMY NUMBER);
INSERT INTO DUMMY VALUES (0);
COMMIT;
SET TERMOUT ON
PROMPT Demonstration table build is complete.
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
SAL NUMBER,
COMM NUMBER
);
CREATE TABLE SALGRADE(
GRADE NUMBER,
LOSAL NUMBER,
HISAL NUMBER
);
INSERT INTO SALGRADE VALUES (1, 700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);
CREATE TABLE DUMMY (DUMMY NUMBER);
INSERT INTO DUMMY VALUES (0);
COMMIT;
SET TERMOUT ON
PROMPT Demonstration table build is complete.

(1)교재 질의
⓵사원의 이름과 업무를 출력하시오. 단 사원의 이름은 ‘사원이름’, ‘업무는 ’사원업무‘, 머리글이 나오도록 출력하시오.
select ename as "사원이름", job as "사원업무" from emp;
select ename, sal from emp where deptno = 30;
⓶30번 부서에 근무하는 모든 사원의 이름과 급여를 출력하시오
select ename, sal from emp where deptno = 30;
⓷사원번호와 이름, 현재급여, 증가된 급여분(열 이름은 증가액), 10% 인상된 급여(열 이름은 ’인상된 급여‘)를 사원 번호 순으로 출력하시오. 
select empno, ename, sal, sal*0.1 as "증가액", sal*1.1 as "인상된 급여" from emp;
⓸’S’로 시작하는 모든 사원과 부서번호를 출력하시오. 
select ename, deptno from emp where ename like 'S%';
⑤모든 사원의 최대 및 최소 급여, 합계 및 평균 급여를 출력하시오. 열이름은 각각 MAX,MIN, SUM, AVG로 한다. 단 소수점 이하는 반올림하여 정수로 출력한다. 
select max(sal) as "최대 급여", min(sal) as "최소 급여", sum(sal) as "합계 급여", avg(sal) as "평균 급여" from emp;
⓺업무(job)별로 동일한 업무를 하는 사원의 수를 출력하시오. 열이름은 각각 ‘업무’ 와 ‘업무별 사원수’로 한다. 
select job, count(*) as "업무별 사원수" from emp group by job;
⓻사원의 최대 급여와 최소 급여의 차액을 출력하시오.
select max(sal) - min(sal) as "최대 급여와 최소 급여의 차액" from emp;
⓼30번 부서의 사원 수와 사원들 급여의 합계와 평균을 출력하시오.
select count(*) as "30번 부서의 사원 수", sum(sal) as "30번 부서의 사원들 급여의 합계", avg(sal) as "30번 부서의 사원들 급여의 평균" from emp where deptno = 30;
⓽평균 급여가 가장 높은 부서의 번호를 출력하시오. 
select deptno as "평균 급여가 가장 높은 부서의 번호" from emp group by deptno order by avg(sal) desc limit 1;
⓾세일즈맨(SALESMAN)을 제외하고, 각 업무별 사원의 총급여가 3,000이상인 가가 업무에 대해서, 업무명과 각 업무별 평균 급여를 출력하시오. 
select job, avg(sal) as "각 업무별 평균 급여" from emp where job != 'SALESMAN' group by job having sum(sal) >= 3000;
⑪전체 사원 가운데 직속상관이 있는 사원의 수를 출력하시오. ⑫EMP 테이블에서 이름, 급여, 커미션 금액(comm), 총액(sal*12+comm)을 구하여 총액이 많은 순서대로 출력하시오.
select count(*) as "직속상관이 있는 사원의 수" from emp where mgr is not null;
select ename, sal, comm, sal*12+comm as "총액" from emp order by sal*12+comm desc;
⑬부서별로 같은 업무를 하는 사람의 인원수를 구하여 부서번호, 업무 이름, 인원수를 출력하시오. 
select deptno, job, count(*) as "인원수" from emp group by deptno, job;
⑭사원이 한 명도 없는 부서의 이름을 출력하시오. ⑮같은 업무를 하는 사람의 수가 4명 이상인 업무와 인원수를 출력하시오.
select deptno, job, count(*) as "인원수" from emp group by deptno, job having count(*) >= 4;
⑯사원번호가 7400 이상 7600 이하인 사원의 이름을 출력하시오. 
select ename from emp where empno between 7400 and 7600;
⑰사원의 이름과 사원의 부서이름을 출력하시오. 
select ename, dname from emp join dept on emp.deptno = dept.deptno;
⑱사원의 이름과 팀장(mgr)의 이름을 출력하시오. 
select ename, mgr from emp join emp on emp.mgr = emp.empno;
⑲사원 SCOTT보다 급여를 많이 받는 사람의 이름을 출력하시오.
select ename from emp where sal > (select sal from emp where ename = 'SCOTT');
⑳사원 SCOTT이 일하는 부서번호 혹은 DALLAS 에 있는 부서번호를 출력하시오
select deptno from emp where ename = 'SCOTT' or deptno in (select deptno from dept where loc = 'DALLAS');

(2)단순질의
⓵comm(커미션)이 NULL이 아닌 사원의 이름과 커미션을 출력하시오. 
select ename, comm from emp where comm is not null;
⓶급여가 1500이상 3000 이하인 사원의 이름과 급여를 급여 오름차순으로 출력하시오. 
select ename, sal from emp where sal between 1500 and 3000 order by sal asc;
⓷1981년에 입사한 사원의 이름과 입사일을 출력하시오. 
select ename, hiredate from emp where hiredate between '1981-01-01' and '1981-12-31';
⓸이름의 세 번째 글자가 ‘A’인 사원을 출력하시오. 
select ename from emp where ename like '__A%';
⑤사원의 이름을 소문자로 출력하시오. 
select lower(ename) as "사원의 이름" from emp;

⓺사원 이름, 입사일, 오늘까지의 근무 개월 수를 출력하시오. 
select ename, hiredate, trunc(months_between(sysdate, hiredate)) as "오늘까지의 근무 개월 수" from emp;
⓻사원 이름과 이름의 글자 수를 글자 수 내림차순으로 출력하시오. 
select ename, length(ename) as "이름의 글자 수" from emp order by length(ename) desc;
⓼comm이 NULL이면 0으로 대체하여 총소득(sal+comm)을 출력하시오. 
select ename, sal+nvl(comm, 0) as "총소득" from emp;
⓽ANALYST 또는 PRESIDENT인 사원의 이름, 업무, 급여를 출력하시오. 
select ename, job, sal from emp where job in ('ANALYST', 'PRESIDENT');
⓾이름 길이가 긴 순, 같으면 알파벳 순으로 사원 이름을 출력하시오.
select ename from emp order by length(ename) desc, ename asc;
(3)부속질의
⓵JONES와 같은 부서에 근무하는 사원의 이름을 출력하시오(JONES본인 제외)
select ename from emp where deptno = (select deptno from emp where ename = 'JONES') and ename != 'JONES';
⓶각 부서에서 가장 높은 급여를 받는 사원의 이름, 급여, 부서번호를 출력하시오. 
select ename, sal, deptno from emp where (deptno, sal) in (select deptno, max(sal) from emp group by deptno);
⓷30번 부서 평균 급여보다 급여가 높은 사원의 이름과 급여를 출력하시오. 
select ename, sal from emp where deptno = 30 and sal > (select avg(sal) from emp where job = 'MANAGER');
⓸MANAGER 직급 평균 급여보다 적은 CLERK 사원의 이름과 급여를 출력하시오. 
select ename, sal from emp where job = 'CLERK' and sal < (select avg(sal) from emp where job = 'MANAGER');
⑤업무별 최고 급여를 받는 사원의 이름, 업무, 급여를 출력하시오. 
select ename, job, sal from emp where (job, sal) in (select job, max(sal) from emp group by job);
⓺KING에게 직접 보고하는 사원의 이름과 업무를 출력하시오. 
select ename, job from emp where mgr = (select empno from emp where ename = 'KING');
⓻입사일이 가장 최근인 사원과 가장 오래된 사원을 함께 출력하시오. 
select ename, hiredate from emp order by hiredate desc limit 1;
select ename, hiredate from emp order by hiredate asc limit 1;
⓼전체 평균 급여보다 급여가 높고 직위가 MANAGER인 사원을 출력하시오. 
select ename, sal from emp where sal > (select avg(sal) from emp) and job = 'MANAGER';
⓾BLAKE와 같은 직위(job)를 가진 사원의 이름과 급여를 출력하시오(BLAKE 본인 제외)
select ename, sal from emp where job = (select job from emp where ename = 'BLAKE') and ename != 'BLAKE';
⑪30번 부서에 속한 사원과 같은 직위(job)를 가진 모든 사원을 출력하시오.
select ename, job from emp where deptno = 30 and job in (select job from emp where deptno = 30);
⑫급여가 모든 CLERK보다 많은 사원의 이름과 급여를 출력하시오(ALL)
select ename, sal from emp where sal > all (select sal from emp where job = 'CLERK');
⑬SALESMAN 중 누구보다도 급여가 많은 사원의 이름과 급여를 출력하시오.(ANY)
select ename, sal from emp where job = 'SALESMAN' and sal > any (select sal from emp where job = 'SALESMAN');
⑭부하 직원이 존재하는 (관리자인) 사원의 이름과 직위를 출력하시오(EXITS)
select ename, job from emp where exists (select * from emp where mgr = emp.empno);
⑮급여 상위 3위 안에 드는 사원의 이름과 급여를 출력하시오.
select ename, sal from emp order by sal desc limit 3;
(4)조인질의
⓵사원의 이름과 소속 부서 이름을 출력하시오. 
select ename, dname from emp join dept on emp.deptno = dept.deptno;
⓶사원의 이름과 팀장의 이름을 출력하시오.(셀프 조인)
select ename, mgr from emp join emp on emp.mgr = emp.empno;
⓷사원이 한 명도 없는 부서의 이름을 출력하시오. 
select dname from dept where deptno not in (select deptno from emp);
⓸NEW YORK에 근무하는 사원의 이름과 업무를 출력하시오. 
select ename, job from emp join dept on emp.deptno = dept.deptno where loc = 'NEW YORK';
⑤사원이름, 급여, 급여 등급을 출력하시오.(SALGRADE 활용)
select ename, sal, grade from emp join salgrade on emp.sal between salgrade.losal and salgrade.hisal;
⓺사원이름, 급여, 급여 등급, 부서 이름을 한 번에 출력하시오. 
select ename, sal, grade, dname from emp join salgrade on emp.sal between salgrade.losal and salgrade.hisal join dept on emp.deptno = dept.deptno;
⓻자신의 상관보다 급여가 높은 사원의 이름과 두 사람의 급여를 출력하시오. 
select ename, sal from emp join emp on emp.mgr = emp.empno where emp.sal > emp.sal;
⓼사원 이름, 부서이름, 근무 도시를 출력하시오. 
select ename, dname, loc from emp join dept on emp.deptno = dept.deptno;
⓽CHOICAGO에 근무하는 사원 수를 출력하시오. 
select count(*) from emp join dept on emp.deptno = dept.deptno where loc = 'CHOICAGO';
⓾부서별 인원 수가 많은 순으로 부서번호, 부서이름, 인원수를 출력하시오. 
select deptno, dname, count(*) as "인원수" from emp join dept on emp.deptno = dept.deptno group by deptno, dname order by count(*) desc;
⑪부서별 평균 급여를 부서이름과 함께 출력하시오. 
select dname, avg(sal) as "평균 급여" from emp join dept on emp.deptno = dept.deptno group by deptno, dname;
⑫급여 등급이 3등급인 사원의 이름, 급여, 부서이름을 출력하시오. 
select ename, sal, dname from emp join salgrade on emp.sal between salgrade.losal and salgrade.hisal join dept on emp.deptno = dept.deptno where grade = 3;
⑬사원의 이음, 입사일, 입사 요일을 부서이름과 함께 출력하시오. 
select ename, hiredate, to_char(hiredate, 'DAY') as "입사 요일", dname from emp join dept on emp.deptno = dept.deptno;
⑭같은 부서에서 근무하는 사원끼리 이름을 나란히 출력하시오.(셀프 조인, 중복제거)
select ename, mgr from emp join emp on emp.mgr = emp.empno;
⑮사원이름, 상관이름, 상관의 부서이름을 출력하시오(셀프+DEPTt조인)
select ename, mgr, dname from emp join emp on emp.mgr = emp.empno join dept on emp.deptno = dept.deptno;

(5)집계질의
⓵업무별 최고, 최소, 평균 급여와 사원 수를 출력하시오. 
select job, max(sal) as "최대 급여", min(sal) as "최소 급여", avg(sal) as "평균 급여", count(*) as "사원 수" from emp group by job;
⓶부서별, 업무별 인원수를 출력하시오. 
select deptno, job, count(*) as "인원수" from emp group by deptno, job;
⓷직원별 총 급여(sal*12+comm)를 내림차순으로 출력하시오. 
select ename, sal*12+nvl(comm, 0) as "총 급여" from emp order by sal*12+nvl(comm, 0) desc;
⓸평균 급여보다 높은 급여를 받는 부서(번호)와 해당 부서의 평균 급여를 출력하시오
select deptno, avg(sal) as "평균 급여" from emp group by deptno having avg(sal) > (select avg(sal) from emp);
⑤입사년도별 사원 수를 출력하시오. 
select to_char(hiredate, 'YYYY') as "입사년도", count(*) as "사원 수" from emp group by to_char(hiredate, 'YYYY');
⓺급여 등급별 사원 수와 평균 급여를 출력하시오
select grade, count(*) as "사원 수", avg(sal) as "평균 급여" from emp join salgrade on emp.sal between salgrade.losal and salgrade.hisal group by grade;
⓻총급여가 5000 이상인 부서의 번호와 합계를 출력하시오. 
select deptno, sum(sal) as "합계" from emp group by deptno having sum(sal) >= 5000;
⓼각 사원의 급여가 전체 급여 합계에서 차지하는 비율(%)을 출력하시오. 
select ename, sal, sal/(select sum(sal) from emp)*100 as "비율" from emp;
⓽근속 연수 10년 이상인 사원의 이름, 입사일, 근속 연수를 출력하시오. 
select ename, hiredate, trunc(months_between(sysdate, hiredate)/12) as "근속 연수" from emp where trunc(months_between(sysdate, hiredate)/12) >= 10;
⓾급여 상위 5명의 사원 이름과 급여를 출력하시오
select ename, sal from emp order by sal desc limit 5;