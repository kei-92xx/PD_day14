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

/*문제1*/
/*사원테이블에서 사번 이름 직업 급여를 출력하라 (조건 : 급여 1500 ~ 5000 이면서 'PRESIDENT', 'ANALYST' 아닌 직원을 출력)*/
SELECT EMPNO, ENAME, JOB, SAL
from EMP
WHERE SAL BETWEEN 1500 and 5000 
and job not in ('PRESIDENT', 'ANALYST');

/*문제2*/
/*사원테이블에서 사번 이름 직업 급여를 출력하라 (조건 : 급여 1500 ~ 5000 이면서 'PRESIDENT', 'ANALYST'인 직원을 출력)*/
SELECT EMPNO, ENAME, JOB, SAL
from EMP
WHERE SAL BETWEEN 1500 and 5000 
and job in ('PRESIDENT', 'ANALYST');

/* 학생 테이블에서 이름이 김으로 시작하는 학생의 이름,학년,학과번호를 출력 */
SELECT name, grade, deptno
from STUDENT
WHERE name LIKE '김%';

/* 학생 테이블에서 이름이 영으로 끝나는 학생의 이름,학년,학과번호를 출력 */
SELECT name, grade, deptno
from STUDENT
WHERE name LIKE '%영';

/* 학생 테이블에서 이름이 3글자, 성은 김씨고 영으로 끝나는 학생의 이름,학년,학과번호를 출력*/
SELECT name, grade, deptno
from STUDENT
WHERE name LIKE '김_영';

/* 학생 테이블에서 여학생의 이름,학년,학과번호,주민번호를 출력*/
SELECT name, grade, deptno, IDNUM
from STUDENT
WHERE IDNUM LIKE '______2%';

/* escape 옵션 */
INSERT INTO STUDENT(studno, name)
VALUES (33333, '황보_정호');

select name
from student
where name like '황보\_%' escape '\';

/* null */
SELECT EMPNO, SAL, COMM
from EMP;
/* null 값을 처리하지 않고 합계로 출력 하게되면 comm 이 null값으로 존재하면 null로 표기되어 정확한 값을 출력하지 못함 */
SELECT EMPNO, SAL+COMM
from EMP;

/*Null인 경우에만 지정된 값으로 대치하는 함수 NVL */
/*Null의 여부에 따라 지정한 값으로 대치하는 함수 NVL2*/
/*Null 연산자를 이용한 조건검색*/
SELECT NAME, POSITION, COMM
FROM PROFESSOR
WHERE COMM IS NULL; /*COMM 칼럼값이 Null인 행검색 */

SELECT NAME, POSITION, COMM
FROM PROFESSOR
WHERE COMM IS NOT NULL; /*COMM 칼럼값이 Null이 아닌 행검색 */

/*사원테이블에서 커미션을 받지 않고 급여가 2500이상이며, 이름의 세번째 A를 포함하는 사원의 이름,급여,커미션 출력*/
SELECT ENAME, SAL, COMM
FROM emp
WHERE COMM IS NULL 
AND SAL >= 2500
AND ENAME LIKE '__A%';

/*employees 테이블에서 커미션을 받지 않고, 급여가 2500이상이며, 이름의 세번째 e를 포함하는 */
SELECT FIRST_NAME, SALARY, COMMISSION_PCT
FROM employees
WHERE COMMISSION_PCT IS NULL 
AND SALARY >= 2500
AND FIRST_NAME LIKE '__e%';

/*102학과의 학생중에서 1학년 또는 4학년 학생의 이름, 학년, 학과번호를 출력*/
SELECT name, grade, deptno
FROM STUDENT
WHERE deptno = 102
AND (grade = '1'
OR grade = '4');

/*102학과의 학생중에서 4학년 학생이거나 소속학과의 상관없이 1학년 학생의 이름, 학년, 학과번호를 출력*/
SELECT name, grade, deptno
FROM STUDENT
WHERE deptno = 102
AND grade = '4'
OR grade = '1';

/*1학년이면서 몸무게가 70kg 이상인 학생의 집합과 1학년이면서 101번 학과에 소속된 학생으로 구성된 두개의 테이블 생성*/
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

SELECT name, USERID, 0 sal /* 0 sal은 학생테이블에 sal 컬럼이 존재하지 않음 따라서 0을 주고 별명으로 sal넣고 출력*/
FROM STUDENT
UNION
SELECT name, USERID, sal
FROM PROFESSOR;

/*중복값 확인 INTERSECT */
SELECT name
from STUD_HEAVY
INTERSECT
SELECT name from STUD_101;

/*마이너스 연산*/
SELECT studno 학번, name 이름
FROM STUD_HEAVY
MINUS
SELECT studno, name
FROM STUD_101;

SELECT studno 학번, name 이름
FROM STUD_101
MINUS
SELECT studno, name
FROM STUD_HEAVY;

/*교수테이블에서 전체 교수의 급여를 인상하기 위한 직원 명단을 출력하려고 함 minus를 사용하여 직급이 전임강상인 사람들은 명단제외*/
SELECT NAME 이름, POSITION 직급
FROM PROFESSOR
MINUS
SELECT name, position
FROM PROFESSOR
WHERE POSITION = '전임강사';

/*단일 컬럼을 이용한 정렬 ORDER by */
/*학생테이블에서 이름을 가나다순으로 정렬 ORDER by (오름차순)*/
SELECT name, grade, tel
FROM STUDENT
ORDER by name;

/*학생테이블에서 학년을 내림차순으로 정렬 desc(내림차순)*/
SELECT name, grade, tel
FROM STUDENT
ORDER by GRADE desc;

/*모든 사원의 이름과 급여 및 부서번호를 출력하는데 부서번호로 결과를 정렬한 뒤 급여는 내림차순으로 정렬하여 출력*/
SELECT ename, job, deptno, sal
FROM emp
ORDER by deptno, sal desc, ename;

SELECT ename, job, deptno, sal
FROM emp
ORDER by 3, 4 DESC, 1;

/*부서 10과 30에 속하는 모든사원의 이름과 부서번호를 이름의 알파벱순으로 정렬되도록 출력*/
SELECT ename, deptno
FROM emp
WHERE deptno in (10,30)
ORDER by ename;

/*1982년에 입사한 모든사원의 이름과 입사일을 구하라*/
SELECT ename, HIREDATE
FROM emp
WHERE HIREDATE like '82/%';

/*보너스를 받는 모든사원에 대해서 이름, 급여 그리고 보너스를 출력 단, 급여와 보너스에 대해서 내림차순 정렬 0이 아닌 사람제외*/
SELECT ename, sal, comm
FROM emp
WHERE comm is not null
and comm <> 0
ORDER by sal desc, comm desc;

/*보너스가 급여의 20%이상이고 부서번호가 30인 모든 사원에 대해서 이름, 급여 그리고 보너스를 출력*/
SELECT ename, sal, comm
FROM emp
WHERE comm >= sal*0.2 and deptno =30;

/*사원테이블에서 급여가 1000 ~ 5000이고 직무가 PRESIDENT나 ANALYST가 아니면서 보너스가
급여의 10%이상인 모든 사원에 대해 job 내림차순 sal 내림차순*/
SELECT EMPNO 사번, ENAME "사원의 이름", JOB 직무, SAL 급여
from EMP
WHERE SAL BETWEEN 1000 and 5000 
and job not in ('PRESIDENT', 'ANALYST')
and comm >= sal*0.1 
ORDER by job desc, sal desc;

/*상수값, CHAR, VARCHAR2 비교*/
CREATE TABLE ex_type  /*테이블만들기*/
(c CHAR(10), V VARCHAR2(10));

INSERT into ex_type  /*행만들기*/
VALUES('sql', 'sql');

SELECT * FROM EX_TYPE
WHERE C='sql';

/*데이터 타입이 다르기때문에 결과값이 거짓*/
SELECT * FROM EX_TYPE
WHERE C=v;

/*sysdate*/
SELECT sysdate from dual;

/*rowid 데이터 타입 확인*/
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


/*DUAL 테이블*/
desc SYS.DUAL;

select DUMMY FROM DUAL;

select 20*30 FROM STUDENT;

select sysdate 
FROM dual;

/*문제 : 어제 오늘 내일을 출력*/
select sysdate-1 YESTERDA, sysdate TODAY, sysdate+1 TOMORROW
FROM dual;

/*대소문자 변환 함수 INITCAT*/
SELECT name, userid, INITCAP(userid)
FROM student
WHERE name = '김영균';

SELECT empno, ename
from emp
WHERE INITCAP(ename) = 'Smith';

select userid, LOWER(userid)/*LOWER은 소문자로 변환함수*/, UPPER(userid)/*UPPER은 대문자로 변환함수*/
FROM student
where studno = 20101;

select ename, job, deptno
from emp
where job = 'MANAGER'
order by ename;

select dname, LENGTH(dname)/*LENGTH는 글자수*/, LENGTHB(dname) /*LENGTHB는 바이트 수*/
from department;

SELECT *
FROM nls_database_parameters
WHERE parameter = 'NLS_CHARACTERSET';

/*문자조작 함수 CONCAT*/
select concat(concat(concat(name,'의 직책은 '),position),'님 입니다')
from professor;

/*문자조작 함수 SUBSTR*/
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

/*문제*/
select INITCAP(ename) "NAME",
        LENGTH(ename) "Length"
from emp
where substr(ename, 1, 1) in ('J', 'A', 'M');

/*INSTR 함수*/
select dname, INSTR(dname, '과')
from department;

/*LPAD, RPAD 함수*/
select position, LPAD(position, 10, '*') lpad_position,
       userid, RPAD(userid, 12, '+') rpad_userid
from professor;

/*LTRIM,RTRIM 함수*/
select LTRIM('xyxXxyLAST WORD','xy')
from dual;

select RTRIM('TURNERyxXxy','xy')
from dual;

/*부서 테이블에서 부서 이름의 마지막 글자인 '과'를 삭제 후 출력*/
select dname, RTRIM(dname, '과')
from department;

/*숫자함수*/
/*ROUND 함수 : 지정한 자리 이하에서 반올림한 결과 값을 반환하는 함수*/
select name, sal, sal/22, ROUND(sal/22), ROUND(sal/22, 2),
        ROUND(sal/22, -1)
from professor
where deptno = 101

/*TRUNC 함수 : 지정한 소수점 자리수 이하를 적삭한 결과 값을 반환하는 함수*/
select name, sal, sal/22, TRUNC(sal/22), ROUND(sal/22, 2),
        TRUNC(sal/22, -1)
from professor
where deptno = 101

/*MOD 함수 : 나누기 연산 후 나머지를 출력하는 함수*/
select name, sal, comm, MOD(sal,comm)
from professor
where deptno = 101;

/*CEIL, FLOOR 함수 */
select CEIL(19.7),/*CEIL : 지정한 숫자보다 크거나 같은 정수 중에 최소값을 출력하는 함수*/
       FLOOR(12.345)/*FLOOR : 지정한 숫자보다 작거나 같은 정수 중에서 최대값을 출력하는 함수*/
from dual;

/*날짜함수*/
/*날짜 계산 예*/
SELECT name, hiredate, hiredate+30, hiredate+60
from professor
where profno = 9908;

/*MONTHS_BETWEEN, ADD_MONTHS 예*/
SELECT profno, hiredate,
    MONTHS_BETWEEN(SYSDATE, hiredate) TENURE,
    ADD_MONTHS(hiredate, 6) REVIEW
FROM professor
WHERE MONTHS_BETWEEN(SYSDATE, hiredate) < 360;


/*문제풀이*/
/*1. 학생 테이블에서 이름이 '진'으로 끝나고, 지도교수가 배정되지 않는 101번 학과 학생의 아이디, 이름, 학년, 학과 번호를 출력하세요.*/
select userid "학생의 아이디", name 이름, grade 학년, studno "학과 번호"
from student
WHERE name LIKE '%진'
AND PROFNO is NULL;

/*2. MANAGER이거나 SALESMAN이며 급여가 $1500, $3000 또는 5000이 아닌 모든 사원에 대해서 이름, 업무, 그리고 급여를 출력하세요.
 ENAME      JOB              SAL
----------- --------- ----------
 JONES      MANAGER         2975
 BLAKE      MANAGER         2850*/
select ENAME 이름, JOB 업무, SAL 급여
FROM emp
WHERE SAL not in (1500, 3000, 5000)
and job in ('MANAGER', 'SALESMAN');

/* 3. 사원 테이블에서 2월에 입사한 사원을 출력해 보세요.(substr 사용) */
select ENAME 이름, hiredate 입사일자, 
        substr(hiredate, 4,2) "입사 월"
from emp
where substr(hiredate, 4,2) =02;

/* 4. 직급이 'manager'인 사원을 검색하려고 아래와 같은 질의문을 작성하였으나,'선택된 레코드가 없습니다.'라고 나옴
      이유를 설명하고 직급이 'manager'인 사원을 검색하도록 질의문을 수정해 보세요.
SELECT 	empno, ename, job
FROM	emp
WHERE 	job='manager';*/ /*데이터 테이블이 대문자이기때문에 소문자로는 값이 출력되지 않음*/
select ENAME 이름, JOB 업무
FROM emp
WHERE job in ('MANAGER');
