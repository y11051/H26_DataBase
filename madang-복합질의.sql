[복합 뷰]
문제 1.
부서별 평균 급여와 최고 급여, 최저 급여를 보여주는 뷰 v_dept_salary_stats를 작성하
시오.
CREATE OR REPLACE VIEW v_dept_salary_stats
AS
SELECT 
    d.deptname AS 부서명, 
    AVG(e.salary) AS 평균급여, 
    MAX(e.salary) AS 최고급여, 
    MIN(e.salary) AS 최저급여
FROM 
    Department d, Employee e
WHERE 
    d.deptno = e.deptno  -- 이 부분이 FK 관계를 이용한 조인입니다
GROUP BY 
    d.deptname;

(출력 컬럼: 부서명, 평균급여, 최고급여, 최저급여)
문제 2.
각 사원이 참여한 프로젝트 수와 총 투입시간을 보여주는 뷰 v_emp_project_summary
를 작성하시오.
CREATE OR REPLACE VIEW v_emp_project_summary
AS
SELECT 
    e.name AS 사원이름, 
    COUNT(p.projectname) AS 참여프로젝트수, 
    SUM(p.hours) AS 총투입시간
FROM 
    Employee e, Project p, EmployeeProject ep
WHERE 
    e.empno = ep.empno AND
    p.projectno = ep.projectno
GROUP BY 
    e.name;
(출력 컬럼: 사원이름, 참여프로젝트수, 총투입시간)
문제 3.
부서별 예산 대비 해당 부서 사원들의 평균 급여 비율을 보여주는 뷰
v_dept_budget_ratio를 작성하시오.
(출력 컬럼: 부서명, 부서예산, 평균급여, 급여예산비율)
단, 급여예산비율은 소수점 2자리까지 표시한다.
CREATE OR REPLACE VIEW v_dept_budget_ratio
AS
SELECT 
    d.deptname AS 부서명, 
    d.budget AS 부서예산, 
    AVG(e.salary) AS 평균급여, 
    (AVG(e.salary) / d.budget) * 100 AS 급여예산비율
FROM 
    Department d, Employee e
WHERE 
    d.deptno = e.deptno
GROUP BY 
    d.deptname, d.budget;
 문제 4.
현재 진행 중인 프로젝트에 참여하고 있는 사원의 이름, 부서명, 프로젝트명, 담당역할을
보여주는 뷰 v_active_project_emp를 작성하시오. 
CREATE OR REPLACE VIEW v_active_project_emp
AS
SELECT 
    e.name AS 사원이름, 
    d.deptname AS 부서명, 
    p.projectname AS 프로젝트명, 
    ep.role AS 담당역할
FROM 
    Employee e, Department d, Project p, EmployeeProject ep
문제 5.
한 번도 프로젝트에 참여하지 않은 사원의 사원번호, 이름, 부서명, 직급을 보여주는 뷰
v_no_project_emp를 작성하시오. 
CREATE OR REPLACE VIEW v_no_project_emp
AS
SELECT 
    e.empno AS 사원번호, 
    e.name AS 사원이름, 
    d.deptname AS 부서명, 
    e.position AS 직급
FROM 
    Employee e, Department d
WHERE 
    e.deptno = d.deptno AND
    NOT EXISTS (
        SELECT 1 
        FROM EmployeeProject ep 
        WHERE ep.empno = e.empno
    );
문제 6.
프로젝트별 참여 사원 수와 총 투입시간, 평균 투입시간을 보여주는 뷰 v_project_stats를
작성하시오.
(출력 컬럼: 프로젝트명, 참여사원수, 총투입시간, 평균투입시간)
CREATE OR REPLACE VIEW v_project_stats
AS
SELECT 
    p.projectname AS 프로젝트명, 
    COUNT(ep.empno) AS 참여사원수, 
    SUM(ep.hours) AS 총투입시간, 
    AVG(ep.hours) AS 평균투입시간
FROM 
    Project p, EmployeeProject ep
WHERE 
    p.projectno = ep.projectno
GROUP BY 
    p.projectname;
문제 7.
자신이 속한 부서의 평균 급여보다 높은 급여를 받는 사원의 이름, 부서명, 급여, 부서평
균급여를 보여주는 뷰 v_above_dept_avg를 작성하시오. 
CREATE OR REPLACE VIEW v_above_dept_avg
AS
SELECT 
    e.name AS 사원이름, 
    d.deptname AS 부서명, 
    e.salary AS 급여, 
    AVG(e.salary) OVER (PARTITION BY d.deptno) AS 부서평균급여
FROM 
    Employee e, Department d    
WHERE 
    e.deptno = d.deptno AND
    e.salary > AVG(e.salary) OVER (PARTITION BY d.deptno);
문제 8.
각 부서에서 가장 오래 근무한 사원의 이름, 부서명, 입사일, 근속연수를 보여주는 뷰
v_longest_serving를 작성하시오. 
CREATE OR REPLACE VIEW v_longest_serving
AS
SELECT 
    e.name AS 사원이름, 
    d.deptname AS 부서명, 
    e.hiredate AS 입사일, 
    EXTRACT(YEAR FROM SYSDATE - e.hiredate) AS 근속연수
FROM 
    Employee e, Department d
WHERE 
    e.deptno = d.deptno
GROUP BY 
    e.name, d.deptname, e.hiredate
HAVING 
    EXTRACT(YEAR FROM SYSDATE - e.hiredate) = (
        SELECT MAX(EXTRACT(YEAR FROM SYSDATE - hiredate)) 
        FROM Employee 
        WHERE deptno = d.deptno
문제 9.
2개 이상의 프로젝트에 참여하면서 총 투입시간이 100시간 이상인 사원의 이름, 참여프로
젝트수, 총투입시간을 보여주는 뷰 v_active_emp를 작성하시오. 문제 10.
부서별로 'PM' 역할을 맡은 사원 수와 해당 부서의 평균 급여를 보여주는 뷰
v_dept_pm_stats를 작성하시오.
(출력 컬럼: 부서명, PM수, 부서평균급여)
CREATE OR REPLACE VIEW v_dept_pm_stats
AS
SELECT 
    d.deptname AS 부서명, 
    COUNT(ep.empno) AS PM수, 
    AVG(e.salary) AS 부서평균급여
FROM 
    Department d, Employee e, EmployeeProject ep
WHERE 
    d.deptno = e.deptno AND
    e.empno = ep.empno AND