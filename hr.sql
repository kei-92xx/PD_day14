select name, birthdate
from student
where BIRTHDATE between '81/01/01' and '83/12/31';

select name, grade, deptno
from student
where DEPTNO in (102, 201);

select * from emp;
select * from student;
select * from PROFESSOR;
select * from employees;

/*����1*/
/*������̺��� ��� �̸� ���� �޿��� ����϶� (���� : �޿� 1500 ~ 5000 �̸鼭 'PRESIDENT', 'ANALYST' �ƴ� ������ ���)*/
SELECT EMPNO, ENAME, JOB, SAL
from EMP
WHERE SAL BETWEEN 1500 and 5000 
and job not in ('PRESIDENT', 'ANALYST');

/*����2*/
/*������̺��� ��� �̸� ���� �޿��� ����϶� (���� : �޿� 1500 ~ 5000 �̸鼭 'PRESIDENT', 'ANALYST'�� ������ ���)*/
SELECT EMPNO, ENAME, JOB, SAL
from EMP
WHERE SAL BETWEEN 1500 and 5000 
and job in ('PRESIDENT', 'ANALYST');

/* �л� ���̺��� �̸��� ������ �����ϴ� �л��� �̸�,�г�,�а���ȣ�� ��� */
SELECT name, grade, deptno
from STUDENT
WHERE name LIKE '��%';

/* �л� ���̺��� �̸��� ������ ������ �л��� �̸�,�г�,�а���ȣ�� ��� */
SELECT name, grade, deptno
from STUDENT
WHERE name LIKE '%��';

/* �л� ���̺��� �̸��� 3����, ���� �达�� ������ ������ �л��� �̸�,�г�,�а���ȣ�� ���*/
SELECT name, grade, deptno
from STUDENT
WHERE name LIKE '��_��';

/* �л� ���̺��� ���л��� �̸�,�г�,�а���ȣ,�ֹι�ȣ�� ���*/
SELECT name, grade, deptno, IDNUM
from STUDENT
WHERE IDNUM LIKE '______2%';

/* escape �ɼ� */
INSERT INTO STUDENT(studno, name)
VALUES (33333, 'Ȳ��_��ȣ');

select name
from student
where name like 'Ȳ��\_%' escape '\';

/* null */
SELECT EMPNO, SAL, COMM
from EMP;
/* null ���� ó������ �ʰ� �հ�� ��� �ϰԵǸ� comm �� null������ �����ϸ� null�� ǥ��Ǿ� ��Ȯ�� ���� ������� ���� */
SELECT EMPNO, SAL+COMM
from EMP;

/*Null�� ��쿡�� ������ ������ ��ġ�ϴ� �Լ� NVL */
/*Null�� ���ο� ���� ������ ������ ��ġ�ϴ� �Լ� NVL2*/
/*Null �����ڸ� �̿��� ���ǰ˻�*/
SELECT NAME, POSITION, COMM
FROM PROFESSOR
WHERE COMM IS NULL; /*COMM Į������ Null�� ��˻� */

SELECT NAME, POSITION, COMM
FROM PROFESSOR
WHERE COMM IS NOT NULL; /*COMM Į������ Null�� �ƴ� ��˻� */

/*������̺��� Ŀ�̼��� ���� �ʰ� �޿��� 2500�̻��̸�, �̸��� ����° A�� �����ϴ� ����� �̸�,�޿�,Ŀ�̼� ���*/
SELECT ENAME, SAL, COMM
FROM emp
WHERE COMM IS NULL 
AND SAL >= 2500
AND ENAME LIKE '__A%';

/*employees ���̺��� Ŀ�̼��� ���� �ʰ�, �޿��� 2500�̻��̸�, �̸��� ����° e�� �����ϴ� */
SELECT FIRST_NAME, SALARY, COMMISSION_PCT
FROM employees
WHERE COMMISSION_PCT IS NULL 
AND SALARY >= 2500
AND FIRST_NAME LIKE '__e%';

/*102�а��� �л��߿��� 1�г� �Ǵ� 4�г� �л��� �̸�, �г�, �а���ȣ�� ���*/
SELECT name, grade, deptno
FROM STUDENT
WHERE deptno = 102
AND (grade = '1'
OR grade = '4');

/*102�а��� �л��߿��� 4�г� �л��̰ų� �Ҽ��а��� ������� 1�г� �л��� �̸�, �г�, �а���ȣ�� ���*/
SELECT name, grade, deptno
FROM STUDENT
WHERE deptno = 102
AND grade = '4'
OR grade = '1';

/*1�г��̸鼭 �����԰� 70kg �̻��� �л��� ���հ� 1�г��̸鼭 101�� �а��� �Ҽӵ� �л����� ������ �ΰ��� ���̺� ����*/
CREATE TABLE stud_heavy
AS SELECT *
FROM STUDENT
WHERE weight >=10 
AND GRADE = '1';

CREATE TABLE stud_101
AS SELECT *
FROM STUDENT
WHERE deptno = 101 
AND GRADE = '1';

SELECT * FROM STUD_HEAVY;
SELECT * FROM STUD_101;

SELECT studno, name
FROM STUD_HEAVY
UNION
SELECT studno, name
FROM STUD_101;

SELECT studno, name
FROM STUD_HEAVY
UNION ALL
SELECT studno, name
FROM STUD_101;

SELECT name, USERID, 0 sal /* 0 sal�� �л����̺� sal �÷��� �������� ���� ���� 0�� �ְ� �������� sal�ְ� ���*/
FROM STUDENT
UNION
SELECT name, USERID, sal
FROM PROFESSOR;

/*�ߺ��� Ȯ�� INTERSECT */
SELECT name
from STUD_HEAVY
INTERSECT
SELECT name from STUD_101;

/*���̳ʽ� ����*/
SELECT studno �й�, name �̸�
FROM STUD_HEAVY
MINUS
SELECT studno, name
FROM STUD_101;

SELECT studno �й�, name �̸�
FROM STUD_101
MINUS
SELECT studno, name
FROM STUD_HEAVY;

/*�������̺��� ��ü ������ �޿��� �λ��ϱ� ���� ���� ����� ����Ϸ��� �� minus�� ����Ͽ� ������ ���Ӱ����� ������� �������*/
SELECT NAME �̸�, POSITION ����
FROM PROFESSOR
MINUS
SELECT name, position
FROM PROFESSOR
WHERE POSITION = '���Ӱ���';

/*���� �÷��� �̿��� ���� ORDER by */
/*�л����̺��� �̸��� �����ټ����� ���� ORDER by (��������)*/
SELECT name, grade, tel
FROM STUDENT
ORDER by name;

/*�л����̺��� �г��� ������������ ���� desc(��������)*/
SELECT name, grade, tel
FROM STUDENT
ORDER by GRADE desc;

/*��� ����� �̸��� �޿� �� �μ���ȣ�� ����ϴµ� �μ���ȣ�� ����� ������ �� �޿��� ������������ �����Ͽ� ���*/
SELECT ename, job, deptno, sal
FROM emp
ORDER by deptno, sal desc, ename;

SELECT ename, job, deptno, sal
FROM emp
ORDER by 3, 4 DESC, 1;

/*�μ� 10�� 30�� ���ϴ� ������� �̸��� �μ���ȣ�� �̸��� ���ĺ������� ���ĵǵ��� ���*/
SELECT ename, deptno
FROM emp
WHERE deptno in (10,30)
ORDER by ename;

/*1982�⿡ �Ի��� ������� �̸��� �Ի����� ���϶�*/
SELECT ename, HIREDATE
FROM emp
WHERE HIREDATE like '82/%';

/*���ʽ��� �޴� ������� ���ؼ� �̸�, �޿� �׸��� ���ʽ��� ��� ��, �޿��� ���ʽ��� ���ؼ� �������� ���� 0�� �ƴ� �������*/
SELECT ename, sal, comm
FROM emp
WHERE comm is not null
and comm <> 0
ORDER by sal desc, comm desc;

/*���ʽ��� �޿��� 20%�̻��̰� �μ���ȣ�� 30�� ��� ����� ���ؼ� �̸�, �޿� �׸��� ���ʽ��� ���*/
SELECT ename, sal, comm
FROM emp
WHERE comm >= sal*0.2 and deptno =30;

/*������̺��� �޿��� 1000 ~ 5000�̰� ������ PRESIDENT�� ANALYST�� �ƴϸ鼭 ���ʽ���
�޿��� 10%�̻��� ��� ����� ���� job �������� sal ��������*/
SELECT EMPNO ���, ENAME "����� �̸�", JOB ����, SAL �޿�
from EMP
WHERE SAL BETWEEN 1000 and 5000 
and job not in ('PRESIDENT', 'ANALYST')
and comm >= sal*0.1 
ORDER by job desc, sal desc;

/*�����, CHAR, VARCHAR2 ��*/
CREATE TABLE ex_type  /*���̺����*/
(c CHAR(10), V VARCHAR2(10));

INSERT into ex_type  /*�ุ���*/
VALUES('sql', 'sql');

SELECT * FROM EX_TYPE
WHERE C='sql';

/*������ Ÿ���� �ٸ��⶧���� ������� ����*/
SELECT * FROM EX_TYPE
WHERE C=v;

/*sysdate*/
SELECT sysdate from dual;

/*rowid ������ Ÿ�� Ȯ��*/
SELECT * FROM emp;
select rowid, empno, ename
from emp
where rowid = 'AAAE5oAAEAAAAGsAAM'

select rowid, name from professor;
select rowid, name from STUDENT;

create table ex_time
(id             NUMBER(2),
basictime       TIMESTAMP,
standardtime    TIMESTAMP WITH TIME ZONE,
localtime       TIMESTAMP WITH LOCAL TIME ZONE);

INSERT INTO ex_time VALUES(1, sysdate, sysdate, sysdate);

set linesize 100
select * from ex_time;


/*DUAL ���̺�*/
desc SYS.DUAL;

select DUMMY FROM DUAL;

select 20*30 FROM STUDENT;

select sysdate 
FROM dual;

/*���� : ���� ���� ������ ���*/
select sysdate-1 YESTERDA, sysdate TODAY, sysdate+1 TOMORROW
FROM dual;

/*��ҹ��� ��ȯ �Լ� INITCAT*/
SELECT name, userid, INITCAP(userid)
FROM student
WHERE name = '�迵��';

SELECT empno, ename
from emp
WHERE INITCAP(ename) = 'Smith';

select userid, LOWER(userid)/*LOWER�� �ҹ��ڷ� ��ȯ�Լ�*/, UPPER(userid)/*UPPER�� �빮�ڷ� ��ȯ�Լ�*/
FROM student
where studno = 20101;

select ename, job, deptno
from emp
where job = 'MANAGER'
order by ename;

select dname, LENGTH(dname)/*LENGTH�� ���ڼ�*/, LENGTHB(dname) /*LENGTHB�� ����Ʈ ��*/
from department;

SELECT *
FROM nls_database_parameters
WHERE parameter = 'NLS_CHARACTERSET';

/*�������� �Լ� CONCAT*/
select concat(concat(concat(name,'�� ��å�� '),position),'�� �Դϴ�')
from professor;

/*�������� �Լ� SUBSTR*/
select name, idnum, substr(idnum, 1,6) birth_date,
                    substr(idnum, 3,2) birth_mon,
                    substr(name, 1,1) name_f
from student
where grade = '1'


select name, idnum, substr(idnum, 1,6) birth_date,
                    substr(idnum, 3,2) birth_mon
from student
where grade = '1'
and substr(idnum, 7, 1) =2;

/*����*/
select INITCAP(ename) "NAME",
        LENGTH(ename) "Length"
from emp
where substr(ename, 1, 1) in ('J', 'A', 'M');

/*INSTR �Լ�*/
select dname, INSTR(dname, '��')
from department;

/*LPAD, RPAD �Լ�*/
select position, LPAD(position, 10, '*') lpad_position,
       userid, RPAD(userid, 12, '+') rpad_userid
from professor;

/*LTRIM,RTRIM �Լ�*/
select LTRIM('xyxXxyLAST WORD','xy')
from dual;

select RTRIM('TURNERyxXxy','xy')
from dual;

/*�μ� ���̺��� �μ� �̸��� ������ ������ '��'�� ���� �� ���*/
select dname, RTRIM(dname, '��')
from department;

/*�����Լ�*/
/*ROUND �Լ� : ������ �ڸ� ���Ͽ��� �ݿø��� ��� ���� ��ȯ�ϴ� �Լ�*/
select name, sal, sal/22, ROUND(sal/22), ROUND(sal/22, 2),
        ROUND(sal/22, -1)
from professor
where deptno = 101

/*TRUNC �Լ� : ������ �Ҽ��� �ڸ��� ���ϸ� ������ ��� ���� ��ȯ�ϴ� �Լ�*/
select name, sal, sal/22, TRUNC(sal/22), ROUND(sal/22, 2),
        TRUNC(sal/22, -1)
from professor
where deptno = 101

/*MOD �Լ� : ������ ���� �� �������� ����ϴ� �Լ�*/
select name, sal, comm, MOD(sal,comm)
from professor
where deptno = 101;

/*CEIL, FLOOR �Լ� */
select CEIL(19.7),/*CEIL : ������ ���ں��� ũ�ų� ���� ���� �߿� �ּҰ��� ����ϴ� �Լ�*/
       FLOOR(12.345)/*FLOOR : ������ ���ں��� �۰ų� ���� ���� �߿��� �ִ밪�� ����ϴ� �Լ�*/
from dual;

/*��¥�Լ�*/
/*��¥ ��� ��*/
SELECT name, hiredate, hiredate+30, hiredate+60
from professor
where profno = 9908;

/*MONTHS_BETWEEN, ADD_MONTHS ��*/
SELECT profno, hiredate,
    MONTHS_BETWEEN(SYSDATE, hiredate) TENURE,
    ADD_MONTHS(hiredate, 6) REVIEW
FROM professor
WHERE MONTHS_BETWEEN(SYSDATE, hiredate) < 360;


/*����Ǯ��*/
/*1. �л� ���̺��� �̸��� '��'���� ������, ���������� �������� �ʴ� 101�� �а� �л��� ���̵�, �̸�, �г�, �а� ��ȣ�� ����ϼ���.*/
select userid "�л��� ���̵�", name �̸�, grade �г�, studno "�а� ��ȣ"
from student
WHERE name LIKE '%��'
AND PROFNO is NULL;

/*2. MANAGER�̰ų� SALESMAN�̸� �޿��� $1500, $3000 �Ǵ� 5000�� �ƴ� ��� ����� ���ؼ� �̸�, ����, �׸��� �޿��� ����ϼ���.
 ENAME      JOB              SAL
----------- --------- ----------
 JONES      MANAGER         2975
 BLAKE      MANAGER         2850*/
select ENAME �̸�, JOB ����, SAL �޿�
FROM emp
WHERE SAL not in (1500, 3000, 5000)
and job in ('MANAGER', 'SALESMAN');

/* 3. ��� ���̺��� 2���� �Ի��� ����� ����� ������.(substr ���) */
select ENAME �̸�, hiredate �Ի�����, 
        substr(hiredate, 4,2) "�Ի� ��"
from emp
where substr(hiredate, 4,2) =02;

/* 4. ������ 'manager'�� ����� �˻��Ϸ��� �Ʒ��� ���� ���ǹ��� �ۼ��Ͽ�����,'���õ� ���ڵ尡 �����ϴ�.'��� ����
      ������ �����ϰ� ������ 'manager'�� ����� �˻��ϵ��� ���ǹ��� ������ ������.
SELECT 	empno, ename, job
FROM	emp
WHERE 	job='manager';*/ /*������ ���̺��� �빮���̱⶧���� �ҹ��ڷδ� ���� ��µ��� ����*/
select ENAME �̸�, JOB ����
FROM emp
WHERE job in ('MANAGER');
