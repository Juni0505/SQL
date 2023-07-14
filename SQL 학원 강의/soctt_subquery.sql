SELECT * FROM emp;
SELECT * FROM SALGRADE;
SELECT * FROM dept;
-- 1.
SELECT e.*, grade FROM emp e
JOIN SALGRADE s ON e.sal > s.LOSAL AND e.sal < s.hisal
ORDER BY grade, EMPNO;
-- 2.
SELECT e.*, grade FROM EMP e
JOIN SALGRADE s ON e.SAL > s.LOSAL AND e.SAL < s.hisal AND s.GRADE IN ('1','2','3','4')
ORDER BY grade DESC;
-- 3.
SELECT GRADE, avg(e.SAL*12+nvl(e.COMM,0)) 
FROM emp e JOIN SALGRADE s 
ON e.sal > s.LOSAL AND e.SAL < s.HISAL
WHERE e.DEPTNO IN ('20','30')
GROUP BY s.grade ORDER BY s.GRADE DESC;
-- 4.
SELECT deptno, FLOOR(avg(sal*12+nvl(comm,0))) 평균연봉  
FROM EMP
WHERE deptno IN ('20','30')
GROUP BY deptno;
-- 5.
SELECT e.EMPNO, e.ENAME, e.JOB, e.MGR , e1.ENAME manager  FROM emp e JOIN emp e1 ON e.MGR = e1.EMPNO
ORDER BY e.empno DESC;
-- 6.
SELECT empno, ename, job, mgr, (SELECT ename FROM emp WHERE empno = e.mgr) manager 
FROM emp e ORDER BY mgr;
-- 7.
SELECT * FROM emp;
SELECT * FROM emp e WHERE sal > (SELECT SAL FROM emp WHERE ename = 'MARTIN')
AND DEPTNO = (SELECT DEPTNO FROM emp WHERE ename = 'ALLEN') OR DEPTNO = '20'; 
-- 8.
SELECT e.ENAME, (SELECT ename FROM emp WHERE empno = e.MGR) manager FROM EMP e JOIN DEPT d 
USING (deptno) WHERE deptno = '20' ORDER BY MGR;

-- 9.
SELECT s.grade, e.ENAME
FROM EMP e JOIN SALGRADE s ON e.SAL > s.LOSAL AND e.SAL < s.HISAL
WHERE (e.SAL) IN (
  SELECT  MIN(SAL)
  FROM EMP e1
  JOIN SALGRADE s1 ON e1.SAL > s1.LOSAL AND e1.SAL < s1.HISAL
  GROUP BY grade
);

SELECT grade, MIN(SAL)
  FROM EMP e1
  JOIN SALGRADE s1 ON e1.SAL >= s1.LOSAL AND e1.SAL <= s1.HISAL
  GROUP BY grade;

-- 10.
SELECT grade, MIN(SAL) MIN_SAL, MAX(sal) MAX_SAL, FLOOR(AVG(sal)) AVG_SAL  
FROM EMP e JOIN SALGRADE s ON e.sal > s.LOSAL AND e.sal < s.hisal 
GROUP BY grade;
-- 11.
SELECT grade, avg(SAL) FROM emp e JOIN SALGRADE s ON e.SAL > s.LOSAL AND e.SAL < s.HISAL 
GROUP BY grade;
-- 12.
SELECT empno, ename, sal,
(CASE WHEN d.LOC = 'NEW YORK' THEN sal * 1.02
	WHEN d.loc = 'DALLAS' THEN sal*1.05
	WHEN d.LOC = 'CHICAGO' THEN sal*1.03
	WHEN d.LOC = 'BOSTON' THEN sal*1.07 
	end) AS SAL_SUBSIDY
FROM emp e JOIN DEPT d using(deptno) ORDER BY 
(CASE WHEN d.LOC = 'NEW YORK' THEN sal * 0.02
	WHEN d.loc = 'DALLAS' THEN sal*0.05
	WHEN d.LOC = 'CHICAGO' THEN sal*0.03
	WHEN d.LOC = 'BOSTON' THEN sal*0.07 
	end) DESC ;

