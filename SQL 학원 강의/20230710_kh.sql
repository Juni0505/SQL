SELECT * FROM EMPLOYEE;
SELECT * FROM department;
SELECT * FROM job;
SELECT * FROM location;
SELECT * FROM NATIONAL;
SELECT * FROM sal_grade;

SELECT emp_name, LENGTH (EMP_NAME) len, LENGTHB(EMP_NAME) byteLen FROM EMPLOYEE; 

SELECT * FROM EMPLOYEE WHERE emp_name = '방_명수';

-- instr -1부터 시작
SELECT EMAIL , INSTR(EMAIL, '@') 위치 FROM EMPLOYEE; 

--email 은 @ 이후에 반드시 . 이 있어야 함.
SELECT EMAIL , INSTR(email, '@'), INSTR(EMAIL, '.', INSTR(EMAIL, '@')) 위치 FROM EMPLOYEE e ;


SELECT * FROM EMPLOYEE WHERE JOB_CODE = 'J1';

-- 급여 35000000 보다 많이 받고 6000000보다 적게 받는 직원이름과 급여 조회
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE SALARY >= 3500000 AND SALARY <= 6000000;
-- '전'씨 성을 가진 직원 이름과 급여 조회
-- 핸드폰의 앞 네 자리 중 첫 번호가 7인 직원 이름과 전화번호 조회
-- EAMAIL ID 중 '_'의 앞이 3자리인 직원 이름, 이메일 조회
-- '이'씨 성이 아닌 지구언 사번, 이름, 이메일 조회
-- 관리자도 없고 부서 배치도 받지 않은 직원 조회
-- 부서 배치를 받지 않았지만 보너스를 지급받는 직원 조회
-- D6 부서와 D8 부서원들의 이름, 부서코드, 급여조회
-- 'J2' 또는 'J7' 직급 코드 중 급여를 2000000보다 많이 받는 지구언의 이름, 급여, 직급코드 조회

-- 사원드르이 남, 여 성별과 함께 모든 정보를 조회
SELECT * FROM employee;
SELECT EMP_NAME, EMP_NO, DECODE(SUBSTR(emp_no,8,1),'1','남','2','여') AS 성별 FROM EMPLOYEE; 
-- java , js 삼항연산자
-- string a = (substr(emp_no, 8, 1) == 2 ? "여" : "남";

SELECT emp_name, emp_no,
CASE substr(emp_no, 8, 1)
	WHEN '2' THEN '여'
	WHEN '1' THEN '남'
	WHEN '4' THEN '여'
	WHEN '3' THEN '남'
	ELSE '그외'
	END AS "성 별"
	FROM EMPLOYEE;
	
SELECT emp_name, emp_no,
CASE to_number(substr(emp_no, 8, 1))
	WHEN 2 THEN '여'
	WHEN 1 THEN '남'
	WHEN 4 THEN '여'
	WHEN 3 THEN '남'
	ELSE '그외'
	END AS "성 별"
	FROM EMPLOYEE;
	
-- 직원들의 평균 급여는 얼마인지 조회
SELECT (avg(salary)) 평균급여 FROM EMPLOYEE;
SELECT FLOOR(avg(SALARY)) 평균급여 FROM EMPLOYEE e ;
SELECT trunc(avg(SALARY)) 평균급여 FROM EMPLOYEE e ;
SELECT round(avg(salary)) 평균급여 FROM EMPLOYEE e ;
SELECT ceil(avg(salary)) 평균급여 FROM EMPLOYEE e ;

SELECT count(DISTINCT dept_code) FROM EMPLOYEE e ;
SELECT count(dept_code) FROM employee;
SELECT count(*) FROM EMPLOYEE e ;
SELECT count(*) FROM EMPLOYEE e WHERE dept_code IS NULL;
SELECT count(dept_code), DEPT_CODE  FROM employee WHERE DEPT_CODE IS NULL ;
