-- SCOTT/TIGER
-- 검색 문장 학습(select)
/*
1. select 문장 기본 syntax
    select절
    from절;

2. 정렬 포함
    select절
    from절
    order by절;

3. 조건절 포함
    select절
    from절
    where절;

* 참고
    - dual table
        - 잉여 table/데이터 없음/syntax로 from 절이 필요시 사용
        - 예시
            시스템의 현재 시간 검색
                select sysdate from dual;

*/

--1. 해당 계정이 사용 가능한 모든 table 검색
select * from tab;

--2. emp table의 모든 내용(모든 사원(row), 속성(컬럼)) 검색
select * form emp;

--3. emp의 구조 검색
desc emp;

--4. emp의 사번?(empno)만 검색
select empno from emp;

--5. emp의 사번(empno), 이름(ename)만 검색
select empno, ename from emp;

--6. emp의 사번(empno), 이름(ename)만 검색(별칭 적용)
select empno as 사번, ename as 이름 from emp;

--7. 부서 번호(deptno) 검색
select deptno from emp;

--8. 중복 제거된 부서 번호 검색
select distinct deptno from emp;

--9. 8 + 오름차순 정렬(order by)해서 검색
-- 오름 차순 : asc / 내림차순 : desc

-- 실행 순서 : from -> select -> order by
select distinct deptno 
from emp
order by deptno asc;

--10. ? 사번(empno)과 이름(ename) 검색 단 사번은 내림차순(desc) 정렬
select empno as 사번, ename as 이름
from emp
order by empno desc;

--11. ? dept(부서) table의 deptno(부서번호) 값만 검색 단 오름차순(asc)으로 검색
select deptno as 부서 번호
from dept
order by deptno asc;

--12. 입사일(hiredate) 검색, 입사일이 오래된 직원부터 검색
-- 고려사항 : date 타입도 정렬(order by) 기능 여부 확인
select hiredate as 입사일
from emp
order by hiredate asc;

--13. 모든사원의 이름과 월 급여와 연봉 검색
select ename, sal, sal*12 as 연봉
from emp;

--14. ?모든 사원의 이름과 월급여(sal)와 연봉(sal*12) 검색;
-- 단 comm도 고려 (+comm) = 연봉(sal*12) + comm
-- comm SALESMAN 만 유의미한 데이터
-- 발생된 문제 : null도 연산...
-- 1. comm 존재 확인
select comm from emp;
select * from emp;

-- comm이 연산 가능함을 확인
-- null값 철저히 무시
select job, comm, comm + 10 from emp;

-- comm과 데이터 보유한 컬럼간에 연산 확인
-- 데이터 보유 컬럼과 null 보유한 컬럼 연산
select sal, comm, sal+comm from emp;

-- null값과 연산시에는 모든 데이터가 null
-- 해결책 : null을 0값으로 대체..
-- 모든 db는 지원하는 내장 함수
-- oracle에서는 null -> 숫자값으로 대체하는 함수 : nvl(null보유컬럼명, 대체값)
select comm, nvl(comm, 0) from emp;

select ename as 사원이름, sal as 월급여,nvl(comm,0) as 보너스, sal*12+nvl(comm,0) as 연봉
from emp;

-- *** 조건식 ***
--15. comm이 null인 사원들의 이름과 comm만 검색
-- where 절 : 조건식 의미
select ename, comm from emp where comm is null;
select ename, comm from emp;

--16. comm이 null이 아닌 사원들과 이름과 comm만 검색
-- where 절 : 조건식 의미
-- 아니다 라는 부정 연산자 : not
select ename, comm from emp where comm is not null;

--17. ? 사원명이 스미스인 사원의 이름과 사번만 검색
-- = : db에서는 동등비교 연산자
-- 참고 : 자바에선 == 동등비교 연산자 / = 대입연산자
-- 데이터는 대소문자 매우 중요 / select 대소문자 구분 없음 
select ename, empno 
from emp 
where ename = 'SMITH';

--18. 부서번호가 10번인 부서의 직원들 이름, 사번, 부서번호 검색
-- 단, 사번은 내림차순 검색
/* 10번 부서 조건 : where / ename, empno, deptno / 내림차순(order by ? desc)
*/ 
select deptno from emp;
select ename, empno, deptno
from emp
where deptno = 10
order by empno desc;

--19. ? 기본 syntax를 기반으로 emp table을 사용하면서 문제 만들기
-- ename, empno, deptno + 연봉 10명 검색 단 사번은 내림차순  limit 사용.

--20. 급여가 900 이상인 사원들 이름, 사번, 급여 검색
select ename, empno, sal from emp where sal >=900;

--21. deptno 10 , job 은 manager(대문자로) 이름, 사번, deptno, job 검색
-- 동등비교 연산자(=) / 조건식이 두개다 true (and)
select ename, empno, deptno, job
from emp
where deptno = 10 and job = 'MANAGER'; --""은 안됨

-- 대소문자 구분 없이 검색을 위한 해결책(대소문자 호환 함수)
-- upper() : 소문자 -> 대문자 lower() : 대문자 -> 소문자
/* 함수 - 독립적으로 개발되는 기능 / 참조 변수없이 함수명만으로 호출
   메소드 - 클래스 내부에 구현되는 기능/객체 참조 변수로 호출 */
select ename, empno, deptno, job
from emp
where deptno = 10 and job = upper('manager');

--22. deptno가 10 아닌 직원들 사번, 부서번호만 검색
-- 부정연산자 not / != / <>
select ename, empno, deptno, job from emp where deptno != 10;
select ename, empno, deptno, job from emp where deptno <> 10;
select ename, empno, deptno, job from emp where not deptno = 10;

--23. sal이 2000이하(sal <= 2000) 이거나 3000이상 (sal >= 3000) 사원명 급여 검색
select ename, sal from emp;

select ename, sal from emp where sal <= 2000 or sal >= 3000;
-- 데이터 건수가 엄청 많을 경우 어떻게 확인?

-- 7건수 검색 
select ename, sal from emp where sal <= 2000;
-- 2건수 검색
select ename, sal from emp where sal >= 3000;
-- 7+2 = 9건수

--24. comm이 300 or 500 or 1400인 사원명 검색
select ename, comm
from emp
where comm = 300 or comm = 500 or comm = 1400;

-- in 연산식 사용해서 좀 더 개선된 코드
select ename, comm
from emp
where comm in (300, 500, 1400);

--25. ? comm이 300 or 500 or 1400이 아닌 사원명 검색
select ename, comm
from emp
where comm not in (300, 500, 1400);

select ename, comm
from emp
where not comm in (300, 500, 1400);

--26. 81/09/28 날 입사한 사원 이름, 사번 검색
-- data 타입 비교 학습
-- data 타입은 '' 표현식 가능
-- yy/mm/dd 포멧은 차후에 변경 예정(함수)
select ename, empno, hiredate
from emp
where hiredate = '81/09/28';
-- date 타입의 yy mm dd 의 구분자는 /, - 다 ok
select ename, empno, hiredate
from emp
where hiredate = '81-09-28';

--27. 날짜 타입의 범위를 기준으로 검색
-- 범위비교시 연산자 : between ~ and
select ename, empno, hiredate
from emp
where hiredate between '80/12/17' and '81/02/22';

--28. 검색시 포함된 모든 데이터 검색하는 기술
-- like 연산자 사용
-- % : 철자 개수 무관하게 검색 / _ : 철자 개수 의미
select enmae from emp
where ename like 'S%';

select enmae from emp
where ename like 'S_';

