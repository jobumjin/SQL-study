-- 5.join.sql

/*
1. 조인이란?
	다수의 table간에  공통된 데이터를 기준으로 검색하는 명령어
	다수의 table이란?
		동일한 table을 논리적으로 다수의 table로 간주
			- self join
			- emp의 mgr 즉 상사의 사번으로 이름(ename) 검색
				: emp 하나의 table의 사원 table 상사 table로 간주

		물리적으로 다른 table간의 조인
			- emp의 deptno라는 부서번호 dept의 부서번호를 기준으로 부서의 이름/위치 정보 검색
  
2. 사용 table 
	1. emp & dept 
	  : deptno 컬럼을 기준으로 연관되어 있음

	 2. emp & salgrade
	  : sal 컬럼을 기준으로 연관되어 있음

  
3. table에 별칭 사용 
	검색시 다중 table의 컬럼명이 다를 경우 table별칭 사용 불필요, 
	서로 다른 table간의 컬럼명이 중복된 경우,
	컬럼 구분을 위해 오라클 엔진에게 정확한 table 소속명을 알려줘야 함
	- table명 또는 table별칭
	- 주의사항 : 컬럼별칭 as[옵션], table별칭 as 사용 불가


4. 조인 종류 
	1. 동등 조인
		 = 동등비교 연산자 사용
		 : 사용 빈도 가장 높음
		 : 테이블에서 같은 조건이 존재할 경우의 값 검색 

	2. not-equi 조인
		: 100% 일치하지 않고 특정 범위내의 데이터 조인시에 사용
		: between ~ and(비교 연산자)

	3. self 조인 
		: 동일 테이블 내에서 진행되는 조인
		: 동일 테이블 내에서 상이한 칼럼 참조
			emp의 empno[사번]과 mgr[사번] 관계

	4. outer 조인 
		: 조인시 조인조건이 불충분해도 검색가능하게 하는 조인
		: 두개 이상의 테이블이 조인될때 특정 데이터가 모든 테이블에 존재하지 않고 컬럼은 존재하나 null값을 보유한 경우
		  검색되지 않는 문제를 해결하기 위해 사용되는 조인
		  null 값이기 때문에 배제된 행을 결과에 포함 할 수 있드며 (+) 기호를 조인 조건에서 정보가 부족한 컬럼쪽에 적용
		
		: oracle DB의 sql인 경우 데이터가 null 쪽 table 에 + 기호 표기 */

-- 1. dept table의 구조 검색
desc dept;

-- dept, emp, salgrade table의 모든 데이터 검색
select * from dept;
select * from emp;
select * from salgrade;


--*** 1. 동등 조인 ***
-- = 동등 비교
-- 2. SMITH 의 이름(ename), 사번(empno), 근무지역(부서위치)(loc) 정보를 검색
-- emp/dept
-- 비교 기준 데이터를 검색 조건에 적용해서 검색
select ename, empno, loc
from emp, dept
where emp.deptno = dept.deptno;

-- table 명이 너무 복잡한 경우 별칭 권장
select ename, empno, loc
from emp e, dept d
where e.deptno = d.deptno;

-- 에러 사유? deptno는 어떤 table의 컬럼? 모호
/*
select ename, empno, loc, deptno
from emp e, dept d
where e.deptno = d.deptno;
*/

select ename, empno, loc, e.deptno
from emp e, dept d
where e.deptno = d.deptno;

-- * : 와일드카드/에스터리스크/아스타/별 ...
-- 3. deptno가 동일한 모든 데이터(*) 검색
-- emp & dept 
-- 존재하는 각 table의 모든 컬럼 만큼 기준점 없이 검색
-- 즉 조인시에는 기준이 되는 조건비교가 필요
-- 논리적인 오류
select * from emp, dept;


-- 4. 2+3 번 항목 결합해서 SMITH에 대한 모든 정보(ename, empno, sal, comm, deptno, loc) 검색하기
select ename, empno, sal, comm, d.deptno, loc 
from emp e, dept d
where e.deptno = d.deptno and ename = 'SMITH'; 


-- 5.  SMITH에 대한 이름(ename)과 부서번호(deptno), 부서명(dept의 dname) 검색하기
select ename, e.deptno, dname
from emp e, dept d
where e.deptno = d.deptno and ename = 'SMITH';

-- 6. 조인을 사용해서 뉴욕에 근무하는 사원의 이름과 급여를 검색 
-- loc='NEW YORK', ename, sal
select ename, sal
from emp, dept
where loc = 'NEW YORK' and emp.deptno = dept.deptno;


-- 7. 조인 사용해서 ACCOUNTING 부서(dname)에 소속된 사원의 이름과 입사일 검색
select ename, hiredate
from emp, dept
where dname = 'ACCOUNTING' and dept.deptno = emp.deptno;


-- 8. 직급이 MANAGER인 사원의 이름, 부서명 검색
select ename, dname
from emp, dept
where job = 'MANAGER' and dept.deptno = emp.deptno;


-- *** 2. not-equi 조인 ***

-- salgrade table(급여 등급 관련 table)
select * from salgrade;

-- 9. 사원의 급여가 몇 등급인지 검색
-- between ~ and : 포함 
select ename, sal from emp;

select ename, grade, sal
from emp e, salgrade s
where sal between losal and hisal;

-- 동등조인 review
-- 10. 사원(emp) 테이블의 부서 번호(deptno)로 부서 테이블을 참조하여 사원명, 부서번호, 부서의 이름(dname) 검색
select ename, emp.deptno, dname
from emp, dept
where emp.deptno = dept.deptno;

-- *** 3. self 조인 ***
-- 11. SMITH 직원의 메니저 이름 검색
/* SMITH 직원 : 사원 table의 사원명이 SMITH
 SMITH직원의 매니져 : 사원 table의 mgr(상사사번)으로 이름 검색
 emp 사원table과 상사table로 구분 = 별칭
*/

select m.ename
from emp e , emp m
where e.ename = 'SMITH' and e.mgr = m.empno;

-- 검색된 데이터 단순 확인용 sql
select empno, ename, mgr from emp;

-- 12. 메니저 이름이 KING(m ename='KING')인 사원들의 이름(e ename)과 직무(e job) 검색
select e.ename 사원명 , e.job, m.ename 상사명
from emp e, emp m
where m.ename = 'KING' and e.mgr = m.empno;

-- 13. SMITH와 동일한 근무지에서 근무하는 사원의 이름 검색

-- SMITH 까지 검색
select my.ename
from emp my, emp you 
where my.ename = 'SMITH' and my.deptno = you.deptno;

-- 단, SMITH 이름은 제외하면서 검색
select you.ename
from emp my, emp you 
where my.ename = 'SMITH' and my.deptno = you.deptno and you.ename != 'SMITH';

--*** 4. outer join ***
-- 14. 모든 사원명, 메니저 명 검색, 단 메니저가 없는 사원도 검색되어야 함

-- step01 : 상사가 없는 KING의 이름 검색이 안되었음!!!
select e.ename, m.ename 상사명
from emp e, emp m
where e.mgr = m.empno;

-- step02 : 
/* 
KING은 상사가 없음 - null
사원 table 관점에선 ename에 KING 존재/총 12명
사원 table 관점에서 mgr이 없는 사람 - KING

null이라는 사번의 상사는 있나요? 없음
= 상사 table의 사번에는 null값 없음

사원의 상사는 null이 존재/상사의 사번에는 null이 없음
결론 : null에 해당하는 정보 자체가 없는 table은 상사 table
	- 상사 table의 empno에는 null이라는 상사사번이 없음
*/	
select e.ename, m.ename 상사명
from emp e, emp m
where e.mgr = m.empno(+);

-- 15. 모든 직원명(ename), 부서번호(deptno), 부서명(dname) 검색
-- 부서 테이블의 40번 부서와 조인할 사원 테이블의 부서 번호가 없지만,
-- outer join이용해서 40번 부서의 부서 이름도 검색하기 
select ename, e.deptno, dname
from emp e, dept d
where e.deptno = d.deptno;

-- 40번 부서 정보 자체가 없는 table(emp)
select ename, e.deptno, dname
from emp e, dept d
where e.deptno(+) = d.deptno;

-- 40번 번호가 나오게 하려면
select ename, d.deptno, dname
from emp e, dept d
where e.deptno(+) = d.deptno;

-- 미션? 부서는 누락하지 않고, 급여가 3000이상인 사원의 정보 검색
-- deptno, dname, loc, empno, ename, job, mgr, hiredate, sal, comm
select d.deptno, dname, loc, empno, ename, job, mgr, hiredate, sal, comm
from emp e, dept d
where sal(+) >= 3000 and e.deptno(+) = d.deptno;

-- 미션? 사원이 없는 부서의 정보를 검색
/*
DEPTNO|DNAME     |LOC   |
------+----------+------+
    40|OPERATIONS|BOSTON|
*/
select d.deptno, dname, loc
from dept d, emp e
where d.deptno = e.deptno(+) and e.empno is null;

-- *** hr/hr 계정에서 test 
--16. 직원의 이름과 직책(job_title)을 출력(검색)
--	단, 사용되지 않는 직책이 있다면 그 직책이 정보도 검색에 포함
--     검색 정보 이름(2개)들과 job_title(직책) 
desc jobs;

select count(*) from employees;
select count(*) from jobs;

select job_id from employees;
select distinct job_id from employees;
select job_id from jobs;

select first_name, job_title
from employees e , jobs j
where e.job_id(+) = j.job_id

	-- 문제 풀이를 위한 table의 컬럼값들 확인해 보기


--17. 직원들의 이름(first_name), 입사일, 부서명(department_name) 검색하기
-- 단, 부서가 없는 직원이 있다면 그 직원 정보도 검색에 포함시키기
/* 경우의 수
1. 사원이 소속된 부서가 없을 수도 있음
2. 부서에 소속된 사원이 한명도 없을 수도 있음

직원 table에는 직원들 존재
단, 직원이 부서에 미포함(부서 id 가 null)되었다 하더라도 모든 검색시에는
departments 에는 null이라는 department_id 값이 없기 때문에 null이라는 id없는 table컬럼쪽에 + 기호 표기
*/
select first_name, hire_date, department_name
from employees e ,  departments d
where e.department_id = d.department_id(+);

-- SCOTT/TIGER
--18. KING을 포함하여 관리자가 없는 사원도 모두 검색 단 사원 번호를 기준으로 오름차순 정렬
-- 사원명, 사번, 상사번호, 상사명
select e.ename 사원명, e.empno 사원번호, m.empno 상사번호, m.ename 상사명
from emp e, emp m
where e.mgr = m.empno(+)
order by e.empno asc;
