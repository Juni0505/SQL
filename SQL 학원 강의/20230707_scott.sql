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


