SELECT * FROM EMPLOYEE e ;
SELECT * FROM job;
SELECT * FROM DEPARTMENT d ;
SELECT * FROM LOCATION l ;
SELECT * FROM "NATIONAL" n ;
SELECT * FROM SAL_GRADE sg ;
-- 1. 70년대 생(1970~1979) 중 여자이면서 전씨인 사원의 이름과 주민번호, 부서 명, 직급 조회
SELECT emp_name, emp_no, d.dept_title, j.JOB_NAME FROM employee e
JOIN job j ON e.JOB_CODE = j.JOB_CODE
JOIN DEPARTMENT d on dept_code = dept_id
WHERE substr(emp_no, 1,2) > 69 AND SUBSTR(emp_no, 1,2) < 80 
AND substr(emp_no,8,1) ='2' AND emp_name LIKE '전%'
GROUP BY emp_name, emp_no, d.dept_title, j.job_name;

-- 2. 나이 상 가장 막내의 사원 코드, 사원 명, 나이, 부서 명, 직급 명 조회
SELECT *  FROM 
	(SELECT emp_id, emp_name, EXTRACT(YEAR FROM sysdate) - (1900 + substr(emp_no,1,2)) age,
d.DEPT_TITLE , j.JOB_NAME 
FROM EMPLOYEE e 
JOIN JOB j ON e.JOB_CODE = j.JOB_CODE  
JOIN DEPARTMENT d ON DEPT_CODE = dept_id) tb1
	WHERE age = (SELECT MIN(EXTRACT(YEAR FROM sysdate) - (1900 + substr(emp_no,1,2))) FROM EMPLOYEE);



SELECT emp_id, emp_name, EXTRACT(YEAR FROM sysdate) - (1900 + substr(emp_no,1,2)) age,
d.DEPT_TITLE , j.JOB_NAME 
FROM EMPLOYEE e 
JOIN JOB j ON e.JOB_CODE = j.JOB_CODE  
JOIN DEPARTMENT d ON DEPT_CODE = dept_id;


-- 3. 이름에 '형'이 들어가는 사원의 사원 코드, 사원 명, 직급 조회
SELECT emp_id, emp_name, job_name FROM EMPLOYEE e JOIN JOB j USING (job_code)
WHERE emp_name LIKE '%형%';

-- 4. 부서코드가 D5이거나 D6인 사원의 사원 명, 직급 명, 부서 코드, 부서 명 조회
SELECT emp_name, job_name, dept_id, dept_title 
FROM EMPLOYEE e JOIN JOB j using(job_code)
JOIN DEPARTMENT d ON DEPT_CODE = dept_id
WHERE dept_id IN ('D5','D6');

-- 5. 보너스를 받는 사원의 사원 명, 부서 명, 지역 명 조회
SELECT emp_name, bonus, dept_title, local_name FROM EMPLOYEE e JOIN DEPARTMENT d ON dept_code = dept_id
JOIN LOCATION l ON location_id = local_code
WHERE bonus IS NOT NULL;

-- 6. 사원 명, 직급 명, 부서 명, 지역 명 조회
SELECT emp_name, j.job_name, d.dept_title, l.local_name FROM EMPLOYEE e 
JOIN JOB j USING (job_code) JOIN DEPARTMENT d ON dept_code = dept_id
JOIN LOCATION l ON location_id = LOCAL_code;

-- 7. 한국이나 일본에서 근무 중인 사원의 사원 명, 부서 명, 지역 명, 국가 명 조회
SELECT emp_name, d.dept_title, l.local_name, n.national_name FROM EMPLOYEE e
JOIN DEPARTMENT d ON dept_code = dept_id JOIN LOCATION l ON location_id = local_code
JOIN "NATIONAL" n on n.NATIONAL_CODE = l.NATIONAL_CODE
WHERE national_name IN ('한국','일본');

-- 8. 한 사원과 같은 부서에서 일하는 사원의 이름 조회 - TODO
SELECT emp_name, dept_code, (SELECT emp_name FROM EMPLOYEE e1 WHERE e1.DEPT_CODE = e.DEPT_CODE) FROM EMPLOYEE e ;

SELECT e1.emp_name, e1.dept_code, e2.emp_name AS 같은부서이름
FROM EMPLOYEE e1
JOIN EMPLOYEE e2 ON e1.DEPT_CODE = e2.DEPT_CODE
WHERE e1.emp_name != e2.emp_name;

-- 9. 보너스가 없고 직급 코드가 J4이거나 J7인 사원의 이름, 직급 명, 급여 조회(NVL 이용)
SELECT emp_name, j.job_name, NVL(SALARY,0) "급여" FROM EMPLOYEE e JOIN JOB j ON e.JOB_CODE = j.JOB_CODE
WHERE e.job_code IN ('J4','J7') AND BONUS IS NULL;

-- 10. 보너스 포함한 연봉이 높은 5명의 사번, 이름, 부서 명, 직급, 입사일, 순위 조회
SELECT emp_id, emp_name, d.dept_title, j.job_name, TO_CHAR(HIRE_DATE,'yy/mm/dd') "입사일",
SALARY * 12 + NVL(SALARY*12*BONUS,0) "연봉",
rownum
FROM EMPLOYEE e JOIN JOB j ON e.JOB_CODE = j.JOB_CODE
JOIN DEPARTMENT d ON e.DEPT_CODE = d.DEPT_ID
ORDER BY 연봉 DESC;

SELECT tb1.*, rownum FROM 
(SELECT emp_id, emp_name, d.dept_title, j.job_name, TO_CHAR(HIRE_DATE,'yy/mm/dd') "입사일",
SALARY * 12 + NVL(SALARY*12*BONUS,0) "연봉"
FROM EMPLOYEE e JOIN JOB j ON e.JOB_CODE = j.JOB_CODE
JOIN DEPARTMENT d ON e.DEPT_CODE = d.DEPT_ID
ORDER BY 연봉 DESC) tb1
WHERE rownum <= 5;

SELECT emp_id, emp_name, d.dept_title, j.job_name, TO_CHAR(HIRE_DATE,'yy/mm/dd') "입사일"
--SALARY * 12 + NVL(SALARY*12*BONUS,0) "연봉"
FROM EMPLOYEE e JOIN JOB j ON e.JOB_CODE = j.JOB_CODE
JOIN DEPARTMENT d ON e.DEPT_CODE = d.DEPT_ID
ORDER BY SALARY * 12 + NVL(SALARY*12*BONUS,0) desc;

SELECT tb1.*, rownum FROM 
(SELECT emp_id, emp_name, d.dept_title, j.job_name, TO_CHAR(HIRE_DATE,'yy/mm/dd') "입사일"
FROM EMPLOYEE e JOIN JOB j ON e.JOB_CODE = j.JOB_CODE
JOIN DEPARTMENT d ON e.DEPT_CODE = d.DEPT_ID
ORDER BY SALARY * 12 + NVL(SALARY*12*BONUS,0) desc) tb1
WHERE rownum <= 5;

-- 11. 부서 별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서 명, 부서 별 급여 합계 조회
-- 11.1 JOIN과 HAVING사용
SELECT d.DEPT_title "부서명", sum(e.SALARY) "부서 별 급여" FROM employee e JOIN DEPARTMENT d ON e.DEPT_CODE = d.DEPT_ID
GROUP BY ROLLUP(d.DEPT_title)
HAVING sum(e.SALARY) > (SELECT SUM(e2.SALARY)*0.2 FROM EMPLOYEE e2) AND d.DEPT_TITLE IS NOT null 
ORDER BY 1;
 
-- 11.2 인라인 뷰 사용
SELECT d.dept_title "부서명" ,sum(e.SALARY) "부서 별 급여" FROM EMPLOYEE e JOIN DEPARTMENT d ON e.DEPT_CODE = d.DEPT_ID
GROUP BY d.DEPT_TITLE;

SELECT * FROM 
(SELECT d.dept_title dept, sum(e.SALARY) sumsal FROM EMPLOYEE e JOIN DEPARTMENT d ON e.DEPT_CODE = d.DEPT_ID
GROUP BY d.DEPT_TITLE)
WHERE sumsal > (SELECT sum(salary)*0.2 totalsum_p FROM EMPLOYEE); 

-- 11.3 WITH 사용
WITH tb1 AS (SELECT d.dept_title dept ,sum(e.SALARY) sumsal FROM EMPLOYEE e JOIN DEPARTMENT d ON e.DEPT_CODE = d.DEPT_ID
GROUP BY d.DEPT_TITLE)
SELECT * FROM tb1
WHERE sumsal > (SELECT sum(SALARY)*0.2 FROM EMPLOYEE);

-- 12. 부서 명과 부서 별 급여 합계 조회
SELECT d.DEPT_title "부서명", sum(e.SALARY) "부서 별 급여"  FROM employee e LEFT OUTER JOIN DEPARTMENT d ON e.DEPT_CODE = d.DEPT_ID 
GROUP BY d.dept_title;

-- 13. WITH를 이용하여 급여 합과 급여 평균 조회
WITH tb1 AS (SELECT sum(salary), avg(SALARY) FROM EMPLOYEE e)
SELECT * FROM tb1;
