--10.view.sql
/*
* view 사용을 위한 필수 선행 설정
	1단계 : admin 계정으로 접속
	2단계 : view 생성해도 되는 사용자 계정에게 생성 권한 부여
		> connect system/manager
		> grant create view to SCOTT;
		> conn SCOTT/TIGER

1. view 에 대한 학습
	- 물리적으로는 미 존재, 단 논리적으로 존재
	- 물리적(create table)
	- 논리적(존재하는 table들에 종속적인 가상 table)
		- emp 또는 dept 처럼 create table이라는 명령어로 table 생성 안함
		- 이미 존재하는 table 하는 table로 파생되는 가상의 table
		- 원본 table 없이는 생성 불가

2. 개념
	- 보안을 고려해야 하는 table의 특정 컬럼값 은닉
	또는 여러개의 table의 조인된 데이터를 다수 활용을 해야 할 경우
	특정 컬럼 은닉, 다수 table 조인된 결과의 새로운 테이블 자체를 
	가상으로 db내에 생성시킬수 있는 기법 

3. 문법
	- create와 drop : create view/drop view
	- crud는 table과 동일

4. view 기반으로 crud 반영시 실제 원본 table에도 반영이 된다.

5. 종류
	5-1. 단일 view : 별도의 조인 없이 하나의 table로 부터 파생된 view
	5-2. 복합 view : 다수의 table에 조인 작업의 결과값을 보유하는 view
	5-3. 인라인 view : sql의 from 절에 view 문장  

6. 실습 table
	-dept01 table생성 -> dept01_v view 를 생성 -> crud -> view select/dept01 select 
*/
--1. test table생성
drop table dept01;
create table dept01 as select * from dept;
select * from dept01;

--2. dept01 table상의 view를 생성
-- SCOTT 계정으로 view 생성 권한 받은 직후에만 가능 (grant create view to SCOTT;)
-- dept table로 dept01_v
create view dept01_v as select * from dept;
select * from dept01_v;

--3. ? emp table에서 comm을 제외한 emp01_v 라는 view 생성
create view emp01_v as select empno, ename, hiredate, sal, deptno from emp;
desc emp01_v;


--4. dept01_v에 crud : dep01_v와 dept01 table 변화 동시 검색
-- view table 변경시 원본 table도 함꼐 변화됨
select * from dept01_v;
insert into dept01_v values(50, '교육부', '홍대');
select * from dept01_v;
select * from dept01;

update dept01_v set loc='마포' where deptno=50;
select * from dept01_v;
select * from dept01;

delete from dept01_v where deptno=50;
select * from dept01_v;
select * from dept01; 


--5. 모든 end user가 빈번히 사용하는 sql문장으로 "해당 직원의 모든 정보 검색(empno, ename, deptno, loc)"하기
-- join 된 sql문장을 위한 view는 사용빈도가 높음
-- insert / update / delete는 잘 안하고 select 위주로 검색시에 권장
/*jobin 로직 필요시 개발 방법
방법 1 - 필요시마다 원본 table로 직접 select
방법 2 - 이미 조인해서 생성한 view에 select
*/

/* 개발 방법
- 두개의 join 필수
방법1 : 필요시 늘 join하는 sql문장 실행
방법2 : 이미 조인된 구조의 view를 생성 해 놓고, 필요시 view만 select */
drop table emp01;
drop table dept01;

create table emp01 as select empno, ename, deptno, sal from emp;
create table dept01 as select * from dept;

-- join해서 생성
create view emp01_dept01_v 
as
select empno, ename, emp01.deptno, loc
from emp01, dept01
where emp01.deptno = dept01.deptno; 


select * from emp01_dept01_v;


--6. 논리적인 가상의 table이 어떤 구조로 되어 있는지 확인 가능한 oracle  자체 table
	-- view는 text 기반으로 명령어가 저장 
		-- table 생성 명령어는 별도로 저장하지 않음 view 명령어는 내부적으로 text로 저장해 놓음 
	-- oracle 자체적인 사전 table
select * from user_views;


--7. view 삭제
drop view dept01_v;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


