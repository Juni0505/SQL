SELECT * FROM emp;

SELECT ename, sal FROM emp;

-- 20번 부서를 제외한 사원 정보를 조회

SELECT * FROM emp 
-- WHERE DEPTNO != 20;
-- where DEPTNO <> 20
--WHERE NOT deptno = 20;
 WHERE deptno NOT IN (20);

 
-- 20번 부서를 제외한 사원중 comm이 null인 사원 정보를 조회
SELECT * FROM emp
WHERE NOT deptno = 20;

-- 10, 20 부서를 사원 정보를 조회
SELECT * FROM emp 
-- WHERE NOT (deptno = 10 OR DEPTNO = 20;);
	WHERE DEPTNO != 10 AND DEPTNO != 20;

-- 10, 20, 30 부서를 사원 정보를 조회
SELECT * FROM emp
-- where deptno = 10 or DEPTNO = 20 or DEPTNO = 30
WHERE DEPTNO  IN (10, 20, 30);

-- QRA - 00933 : SQL 명령어가 올바르게 종료되지 않았습니다.
-- 00933. 00000 - "SQL command not properly ended"


-- 급여를 1800보다 많이 받고 2500보다 적게 받는 직원이름과 급여 조회

-- 'S'로 시작하는 2글자 이름을 가진 직원 이름과 급여 조회 // %는 0개 이상의 글자를 찾아줌
SELECT ename, sal FROM emp WHERE ename LIKE 'S_%';
-- 핸드폰의 앞 네 자리 중 첫 번호가 7인 직원 이름과 전화번호 조회
-- 이름 중 3번째 글자가 'S' 인 직원 이름과 급여 조회
SELECT  ename, sal FROM emp WHERE ename LIKE '__S$';
-- 이름 중 3번째 글자가 '_'인 직원 이름과 급여조회
SELECT ename, sal FROM emp
	-- 이름이 4글자 이상인 직원
	-- where ename like '___%'
	WHERE ename LIKE '__\_%' ESCAPE '\'
		OR job LIKE '__@_%' ESCAPE '@';
-- like '__*_' escape'*'

-- 관리자도 없고 부서 배치도 받지 않은 직원 조회
SELECT * FROM emp WHERE mgr IS NULL AND DEPTNO  IS NULL ;

-- 관리자가 없지만 보너스를 지급받는 직원 조회
SELECT * FROM emp WHERE MGR IS NULL AND COMM IS NOT NULL;

-- 20 부서와 30 부서원들의 이름, 부서코드, 급여 조회
-- in
SELECT ENAME, DEPTNO, SAL FROM emp 
	WHERE DEPTNO IN (20,30);
	-- DEPTNO = 20 or DEPTNO = 30;
		
-- ANALYST 또는 SALESMAN 인 사원 중 급여를 2500보다 많이 받는 직원의 이름, 급여, job 조회
SELECT ename, sal, job FROM EMP
	WHERE job IN ('ANALYST', 'SALESMAN')
		AND sal > 2500;
		
-- 사원명의 길이와 byte크기를 조회
SELECT LENGTH(ename), LENGTHB(ename)  FROM EMP;

SELECT 'a 안 녕 b', LENGTH('a안녕b'), LENGTHB('a안녕b')  FROM emp;
-- from emp
SELECT 'a 안 녕 b', LENGTH('a안녕b'), LENGTHB('a안녕b')  FROM DUAL;
-- 테이블 dual은 임시 테이블로 연산이나 간단한 함수 결과값을 조회할때 사용함.
--trim은 공백을 없애줌
-- 사원명의 시작부분 s와 끝나는 부분 s 모두 제거해주세요.
SELECT RTRIM(LTRIM(ename, 'S'), 'S') FROM emp;
-- Ltrim 예시 010 제거

-- Lpad / Rapd 채워넣기
-- ename이 총 10자가 되도록 left쪽에 'S'를 채워주세요.
SELECT LPAD(ename, 10, 'S') FROM EMP; 
-- ename이 총 10자가 되도록 left쪽에 ' ' 공백(default)를 채워주세요.
SELECT LPAD(ename, 10) FROM EMP; 

-- 문자열(컬럼) 이어붙이기
SELECT concat(ename, comm) FROM emp;
SELECT ename||comm FROM emp;
SELECT sal||'달러' FROM emp;
SELECT concat(sal, '달러') FROM EMP;
-- substr 엄청 중요 !!

-- replace 
SELECT REPLACE(ename, 'AM', 'AB') FROM emp;

--
SELECT INSTR('AORACLEWELCOME', 'O', 2) FROM DUAL;
SELECT INSTR('AORACLEWELCOME', 'O', 1, 2) FROM DUAL;
SELECT INSTR('AORACLEWELCOMEOKEY', 'O', 1, 3) FROM DUAL;
SELECT INSTR('AORACLEWELCOMEOKEY', 'O')FROM dual;

-- sysdate 은 함수는 아니나 명령어가 실행되는 시점에 결과값을 출력해주므로 함수호출과 같은 역할
SELECT SYSDATE FROM dual;
SELECT hiredate FROM emp;
SELECT hiredate, add_months(hiredate, 1) FROM emp;
-- 2023.07.10 (월요일)
SELECT sysdate, TO_CHAR(SYSDATE, 'yyyy.mm.dd (dy)')  FROM dual;
SELECT sysdate, TO_CHAR(SYSDATE, 'yyyy.mm.dd (day)') FROM dual;

ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy-mm-dd hh24:mi:ss';
SELECT SYSDATE FROM dual;
SELECT * FROM emp;

-- year 2023 month 09 day 11 hour 13
SELECT TO_DATE('2023091113', 'yyyymmddhh24') FROM dual;
SELECT ADD_MONTHS(to_date('2023091113', 'yyyymmddhh24'), 5) FROM dual;
SELECT next_day(to_date('2023091113', 'yyyymmddhh24'), '수') FROM dual;
SELECT NEXT_DAY(TO_DATE('2023091113', 'yyyymmddhh24'), 4) FROM dual;
-- 1:일요일, 2 월요일, 3 화요일...
SELECT LAST_DAY(TO_DATE('2023081113', 'yyyymmddhh24')) FROM dual;

SELECT to_char(empno, '000000'), '$'||TRIM(TO_CHAR(sal, '999,999,999,999'))  FROM emp;

SELECT TO_NUMBER('12345678901'), to_number('99999999999') FROM dual; 

-- 직원들의 평균 급여는 얼마인지 조회
SELECT avg(sal) 평균급여 FROM EMP;
SELECT sum(sal) sum FROM emp;
SELECT max(sal) max FROM emp;
SELECT min(sal) min FROM EMP;
SELECT COUNT(sal) COUNT FROM EMP;

-- 부서별 평균 급여 조회
SELECT AVG(sal) 평균급여, deptno FROM EMP group BY DEPTNO ; 
SELECT SUM(sal) sum, deptno FROM EMP group BY DEPTNO ; 
SELECT MAX(sal) max, deptno FROM EMP group BY DEPTNO ; 
SELECT MIN(sal) min, deptno FROM EMP group BY DEPTNO ;
SELECT COUNT(sal) count, DEPTNO FROM emp GROUP BY DEPTNO; 
SELECT COUNT(*) count, DEPTNO FROM emp GROUP BY DEPTNO; 
-- job별 평균 급여 조회
SELECT AVG(sal) 평균급여, JOB FROM EMP group BY JOB  ; 
SELECT SUM(sal) sum, JOB FROM EMP group BY JOB ; 
SELECT MAX(sal) max, JOB FROM EMP group BY JOB ; 
SELECT MIN(sal) min, JOB FROM EMP group BY JOB ; 
SELECT COUNT(sal) count, JOB  FROM emp GROUP BY JOB ; 
SELECT COUNT(*) count, JOB  FROM emp GROUP BY JOB ; 

-- job 이 analyst 인 직원의 평균 급여 조회
SELECT avg(sal) 평균급여, job FROM emp GROUP BY job HAVING job = 'ANALYST';

SELECT avg(sal) 평균급여 FROM emp WHERE job = 'ANALYST';

-- job이 ANALYST 인 부서별 직원의 평균 급여 조회
SELECT job, deptno, ename FROM emp WHERE job='CLERK';

SELECT job, deptno, avg(sal)
FROM emp
WHERE job = 'CLERK'
GROUP BY deptno, job;

SELECT ename, sal*12+nvl(comm, 0) FROM emp ORDER BY 2 DESC, 1 desc;

-- job 오름차순
SELECT * FROM EMP
-- order by job;
ORDER BY 3;

-- 사원명, 부서번호, 부서명, 부서위치를 조회
SELECT * FROM dept;
SELECT * FROM emp;
SELECT * FROM emp JOIN dept ON emp.DEPTNO = dept.DEPTNO -- 이러면 두개 의 값이 중복해서 나타남

SELECT emp.ENAME, emp.DEPTNO, DNAME, dept.LOC 
FROM emp
JOIN dept ON emp.DEPTNO = dept.DEPTNO;

SELECT ENAME, emp.DEPTNO, DNAME, LOC -- 해당하는 값이 고유 중복값이면 앞에 생략가능.
FROM emp 
JOIN dept ON emp.DEPTNO = dept.DEPTNO ;

-- join 대신 쉼표사용
SELECT ename, dept.DEPTNO, dname, loc FROM emp, dept WHERE emp.DEPTNO = dept.DEPTNO ;

-- 부서위치가 DALLAS인 사원명, 부서번호, 부서명, 위치를 조회
SELECT ename, dept.DEPTNO, dname, loc
FROM emp, DEPT
WHERE emp.deptno = dept.DEPTNO
 AND loc = 'DALLAS';

SELECT empno, loc FROM emp cross JOIN DEPT;

SELECT * FROM emp;
SELECT * FROM SALGRADE;
-- 사원의 이름, 사번, sal, grade 를 조회
SELECT e.ename, e.empno, e.sal, s.grade FROM EMP e JOIN SALGRADE s ON e.SAL BETWEEN s.LOSAL AND s.HISAL
ORDER BY s.grade, e.SAL;

SELECT empno, ename, mgr FROM emp;
SELECT e.empno, e.ename, e.mgr, m.ename marname FROM emp e JOIN emp m ON e.mgr = m.EMPNO;

--같은 이름 컬럼명이 나오지 않도록 별칭 사용
SELECT e.empno boss, e.ename, m.empno emp, m.ename emps FROM emp e JOIN emp m ON e.empno = m.mgr;

SELECT ename FROM emp WHERE empno=7566;

-- 자료형
CREATE TABLE ta(c1 char(5), c2 varchar2(5));
INSERT INTO ta VALUES('12','12');
INSERT INTO ta values('12345', '12345');
--SQL Error [12899] [72000]: ORA-12899: "SCOTT"."TA"."C1" 열에 대한 값이 너무 큼(실제: 6, 최대값: 5)
--INSERT INTO ta values('123456','123456');
COMMIT;
SELECT LENGTH(c1), LENGTH(c2) FROM ta;

-- ERD( entity realationship diagram)
-- UML - classDiagram

SELECT rownum, e.* FROM emp e WHERE deptno IN (20, 30);
-- 오류
SELECT rownum, e.* FROM emp e WHERE deptno IN (20, 30)
ORDER BY ENAME ASC;
-- 해결 방법
SELECT rownum, e.* FROM (SELECT * FROM emp ORDER BY ename asc) e 
WHERE deptno IN (20, 30);

SELECT rownum, e.* FROM (SELECT * FROM emp WHERE deptno IN (20, 30) ORDER BY ename asc) e;

SELECT * FROM emp ORDER BY ename ASC;

-- 1page 1-3
SELECT rownum, e.* FROM (SELECT * FROM emp WHERE deptno IN (20, 30) ORDER BY ename asc) e
WHERE rownum BETWEEN 1 AND 3;

-- 2page 4-6
SELECT rownum rnum, e.* FROM (SELECT * FROM emp WHERE deptno IN (20, 30) ORDER BY ename asc) e
WHERE rnum BETWEEN 4 AND 6;
-- rnum은 select -6 수행순서로 where 절
-- 해결 - rownum을 제대로 사용하기위해서는 2개의 중첩 subquery(inline-view)을 필요함
-- 3page 7-9
SELECT * FROM (SELECT rownum rnum, e.* FROM 
	(SELECT * FROM emp WHERE deptno IN (20, 30) ORDER BY ename ASC) e)
	WHERE rnum BETWEEN 7 AND 9;

WITH abc AS (SELECT rownum rnum, e.* FROM (SELECT * FROM emp WHERE deptno IN (20,30)
ORDER BY ename ASC) e)
SELECT * FROM abc WHERE rnum BETWEEN 7 AND 9;
-- abc가 마치 새로운 테이블처럼 사용가능함.
--			AND sal > (SELECT avg(sal) FROM abc);

CREATE VIEW VIEW_abc AS 
(SELECT rownum rnum, e.* FROM (SELECT * FROM emp WHERE deptno IN (20,30)
ORDER BY ename ASC) e);
SELECT * FROM VIEW_abc;

-- SALESMAN 과 'MANAGER' 를 조회해주세요.
SELECT * FROM EMP WHERE job = 'SALESMAN' OR job = 'MANAGR';

SELECT * FROM emp WHERE job IN ('SALESMAN', 'MANAGER');
-- union 사용 
SELECT *FROM EMP WHERE job = 'SALSEMAN'
UNION 
SELECT * FROM emp WHERE job = 'MANAGER';