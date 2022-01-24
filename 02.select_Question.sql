/* 
1. ����Ǯ��
2. ���� ��ü�� �������� ã�ƺ���-������ ������ ����
	
	��� ������ ����
	���� ��ü�� ����
	 
*/
  
/**1.
�μ���ȣ�� 10���� �μ��� ��� �� �����ȣ, �̸�, ������ ����϶�
*/   
select empno, ename, sal
from emp
where deptno = 10;


/**2.
�����ȣ�� 7369�� ��� �� �̸�, �Ի���, �μ� ��ȣ�� ����϶�.
*/
select ename, hiredate, deptno
from emp
where empno = 7369;

/**3.
�̸��� ALLEN�� ����� ��� ������ ����϶�.
*/
select *
from emp
where ename = 'ALLEN';


/**4.
�Ի����� 83/01/12�� ����� �̸�, �μ���ȣ, ������ ����϶�.
*/
select ename, deptno, sal
from emp
where hiredate = '83/01/12';
--����

/**5.
������ MANAGER�� �ƴ� ����� ��� ������ ����϶�.
*/
select *
from emp
where job != 'MANAGER';


/**6.
�Ի����� 81/04/02 ���Ŀ� �Ի��� ����� ������ ����϶�.
*/
select *
from emp
where hiredate > '81/04/02'; --�̻����� �ʰ�����


/**7.
�޿��� 800�̻��� ����� �̸�, �޿�, �μ���ȣ�� ����϶�
*/
select ename, sal, deptno
from emp
where sal >= 800;


/**8.
�μ���ȣ�� 20�� �̻��� ����� ���� ������ ����϶�.
*/
select *
from emp
where deptno >= 20;


/**9. ***
�̸��� K�� �����ϴ� ����� ��������� ����϶�.
*/
select *
from emp
where ename like 'K%';



/**10.
�Ի����� 81/12/09 ���� ���� �Ի��� ������� ��� ������ ����϶�.
*/
select * 
from emp
where hiredate < '81/12/09';



/**11.
�����ȣ�� 7698���� �۰ų� ���� ������� �����ȣ�� �̸��� ����϶�.
*/
select empno, ename
from emp
where empno <= 7698;


/**12.
�Ի����� 81/04/02���� �ʰ�  82/12/09���� ���� ����� �̸�, ����, �μ���ȣ�� ����϶�.
*/
select ename, sal, deptno, hiredate
from emp
where hiredate > '81/04/02' and hiredate < '82/12/09';



/**13.
�޿��� 1600���� ũ��[�ʰ�] 3000���� ����[�̸�] ����� �̸�, ����, �޿��� ����϶�.
*/
select ename, job, sal
from emp
where 1600 < sal and sal < 3000;


/**14.
�����ȣ�� 7654�� 7782���� �̿��� ����� ��� ������ ����϶�.
*/
select * from emp
where empno < 7654 or empno > 7782;

select * from emp
where empno not between 7654 and 7782;

/**15.
������ MANAGER�� SALESMAN�� ����� ��� ������ ����϶�
*/
select * from emp
where job = 'MANAGER' or job = 'SALESMAN';

select * from emp
where job in ('MANAGER','SALESMAN');


/**16.
�μ���ȣ�� 20,30���� ������ ��� ����� �̸�, �����ȣ, �μ���ȣ�� ����϶�.
*/
select ename, empno, deptno
from emp
where deptno != 20 and deptno != 30;



/**17.
�̸��� S�� �����ϴ� ����� �����ȣ, �̸�, �Ի���, �μ���ȣ�� ����϶�.
*/
select empno, ename, hiredate, deptno
from emp
where ename like 'S%'; 



/**18.
�̸��� S�ڰ� �� �ִ� ����� ��� ������ ����϶�.
*/
select * from emp
where ename like '%S%'; 

/**19.
�̸��� S�� �����ϰ� ������ ���ڰ� T�� ����� ������ ����϶�. �� �̸��� ��ü 5�ڸ��̴�.
*/
select * from emp
where ename like 'S___T'; 
--����

/**20.
Ŀ�̼��� null�� ����� ������ ����϶�.
*/
select * from emp
where comm is null;


/**21.
Ŀ�̼��� null�� �ƴ� ����� ������ ����϶�.
*/
select * from emp
where comm is not null;


/**22.
�μ��� 30�� �μ��̰� �޿��� 1500�̻��� ����� �̸�, �μ�, ����(sal)�� ����϶�.
*/
select ename, deptno, sal
from emp
where deptno = 30 and sal > 1500;



/**22.
�̸��� ù���ڰ� K�� �����ϰų� �μ���ȣ�� 30�� ����� �����ȣ, �̸�, �μ���ȣ�� ����϶�.
*/
select empno, ename, deptno
from emp
where deptno = 30 and ename like 'K%';
-- ���� 10���� �ٲٴ��� �̸������� �ٲٴ���..


/**23.
�޿��� 1500�̻��̰� �μ���ȣ�� 30���� ����� ������ MANAGER�� ����� ������ ����϶�.
*/
select * from emp
where sal > 1500 and deptno = 30 and job = 'MANAGER';

/**24.
�μ���ȣ�� 30�� ����� �����ȣ �����϶�.
*/
select * from emp
where deptno = 30
order by empno asc;

/**25.
�޿��� ���� ������ �����϶�.
*/
select * from emp
order by sal desc;

/**26.
�μ���ȣ�� �������� �� �� �޿��� ���� ��� ������ ����϶�.
*/
select * from emp
order by deptno asc, sal desc;

/**27.
�μ���ȣ�� �������� �ϰ� �޿������� ���������϶�.
*/
select * from emp
order by deptno desc, sal desc;
