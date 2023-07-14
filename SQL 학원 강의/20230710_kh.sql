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

-- 부서코드와 급여 3000000 이상인 직원인 그룹별 평균조회
SELECT DEPT_CODE, avg(salary) FROM EMPLOYEE WHERE SALARY >= 3000000 GROUP BY DEPT_CODE;

-- 부서 코드와 급여 평균이 3000000 이상인 그룹 조회
SELECT dept_code, avg(SALARY) FROM employee GROUP BY dept_code HAVING avg(SALARY) > 3000000;

-- 사원명, 부서번호, 부서명, 부서위치를 조회
--SQL Error [904] [42000]: ORA-00904: "TB3"."NATIONAL_CODE": 부적합한 식별자
--SELECT tb1.EMP_NAME , tb1.dept_code, tb2.dept_title, tb2.LOCATION_ID, tb3.NATIONAL_CODE, tb4.national_name
 SELECT EMP_NAME , dept_code, dept_title, LOCATION_ID, NATIONAL_CODE, national_name
 FROM EMPLOYEE tb1
 JOIN DEPARTMENT tb2 ON tb2.DEPT_ID  = tb1.DEPT_CODE
 JOIN LOCATION tb3 ON tb2.LOCATION_ID = tb3.LOCAL_CODE
 JOIN NATIONAL tb4 using (NATIONAL_code);
 -- join 조건에 사용되는 컬럼명이 다르면 using 사용 불
 
 SELECT EMP_NAME, dept_code, dept_title, LOCATION_ID, NATIONAL_CODE, national_name
 FROM EMPLOYEE tb1, DEPARTMENT tb2, LOCATION tb3, NATIONAL tb4
 where tb2.DEPT_ID  = tb1.DEPT_CODE
 and tb2.LOCATION_ID = tb3.LOCAL_CODE
 and tb3.national_code = tb4.national_code;
 -- join 조건에 사용되는 컬럼명이 다르면 using 사용 불가

SELECT * FROM EMPLOYEE e JOIN DEPARTMENT d ON e.DEPT_CODE = d.DEPT_ID;

SELECT * FROM EMPLOYEE e LEFT OUTER JOIN DEPARTMENT d ON e.DEPT_CODE = d.DEPT_ID;

SELECT * FROM EMPLOYEE e right OUTER JOIN DEPARTMENT d ON e.DEPT_CODE = d.DEPT_ID;

SELECT * FROM EMPLOYEE e FULL OUTER JOIN DEPARTMENT d ON e.DEPT_CODE = d.DEPT_ID;

SELECT * FROM EMPLOYEE e , DEPARTMENT d WHERE e.DEPT_CODE = d.DEPT_ID(+);

SELECT * FROM EMPLOYEE e , DEPARTMENT d WHERE e.DEPT_CODE(+) = d.DEPT_ID;

SELECT emp_id, emp_name, dept_code, dept_title, local_name FROM EMPLOYEE
JOIN DEPARTMENT ON (dept_code = DEPT_ID)
JOIN location ON (LOCATION_ID = local_code);

-- 전 직원의 급여 평균보다 많은 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
SELECT emp_name, job_code, dept_code, salary FROM EMPLOYEE e 
WHERE SALARY >= (SELECT avg(SALARY)FROM EMPLOYEE) ORDER BY 2;

-- 부서 별 최고 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
SELECT emp_name, job_code, dept_code, salary FROM EMPLOYEE
WHERE SALARY IN (SELECT max(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE)
ORDER BY 3;

-- 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 사원의 이름, 직급, 부서, 입사일 조회
SELECT emp_name, job_code, dept_code, hire_date FROM EMPLOYEE
WHERE (dept_code, JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE 
WHERE SUBSTR(emp_no,8,1) = 2 AND ENT_YN ='Y');

-- 직급별 최소 급여를 받는 직원의 사번, 이름, 직급, 급여 조회
SELECT emp_id, emp_name, job_code, salary FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT job_code, min(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE)
ORDER BY 3;

SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY GROUPING SETS((DEPT_CODE, JOB_CODE, MANAGER_ID),
(DEPT_CODE, MANAGER_ID),
(JOB_CODE, MANAGER_ID));

SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE, MANAGER_ID;

CREATE TABLE USER_notnull(
	USER_no NUMBER NOT NULL,
	USER_id VARCHAR2(20) NOT NULL,
	USER_pwd varchar2(30) NOT NULL,
	USER_name varchar2(30),
	gender varchar2(10),
	phone varchar2(30),
	email varchar2(50)
	);
INSERT INTO user_notnull values(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678',
'hong123@kh.or.kr');
-- no, id, pwd 부분에서 not null 을 지정했기 때문에 null값을 넣을 수 없음
INSERT INTO user_notnull values(2, null, null, NULL, NULL, '010-1234-5678',
'hong123@kh.or.kr');

INSERT INTO user_notnull values(2, 'user02', 'pass02', NULL, NULL, '010-1234-5678',
'hong123@kh.or.kr');

CREATE TABLE USER_unique(
	USER_no NUMBER,
	user_id varchar2(20) UNIQUE,
	USER_pwd varchar2(30) NOT NULL,
	USER_name varchar2(30),
	gender varchar2(10),
	phone varchar2(30),
	email varchar2(50)
	);

INSERT INTO user_unique values(1, 'user01', 'pass01', '홍길동','남','010-1234-5678',
'hong123@kh.or.kr');
-- SQL Error [1] [23000]: ORA-00001: 무결성 제약 조건(KH.SYS_C008351)에 위배됩니다
-- unique 는 고유한 값을 가지기 떄문에 중복사용 x
INSERT INTO USER_unique values(1, 'user01', 'pass01', null, null,'010-1234-5678',
'hong123@kh.or.kr');

CREATE TABLE USER_unique2(
	USER_no NUMBER,
	user_id varchar2(20),
	USER_pwd varchar2(30) NOT NULL,
	USER_name varchar2(30),
	gender varchar2(10),
	phone varchar2(30),
	email varchar2(50),
	unique(user_id)
	);
INSERT INTO user_unique2 values(1, 'user01', 'pass01', '홍길동','남','010-1234-5678',
'hong123@kh.or.kr');
-- user_id에 unique 값을 지정해놔서 중복 x
INSERT INTO user_unique2 values(1, 'user01', 'pass01', null, null,'010-1234-5678',
'hong123@kh.or.kr');
INSERT INTO user_unique2 values(1, null, 'pass01', '홍길동','남','010-1234-5678',
'hong123@kh.or.kr');
INSERT INTO user_unique2 values(1, null, 'pass01', '홍길동','남','010-1234-5678',
'hong123@kh.or.kr');

CREATE TABLE USER_unique3(
	USER_no NUMBER,
	user_id varchar2(20),
	USER_pwd varchar2(30) NOT NULL,
	USER_name varchar2(30),
	gender varchar2(10),
	phone varchar2(30),
	email varchar2(50),
	unique(user_no, user_id) -- 두 컬럼을 묶어 한 UNIQUE 제약조건 설정
	);
INSERT INTO user_unique3 values(1, 'user01', 'pass01', '홍길동','남','010-1234-5678',
'hong123@kh.or.kr');
INSERT INTO user_unique3 values(2, 'user01', 'pass01', null, null,'010-1234-5678',
'hong123@kh.or.kr');
INSERT INTO user_unique3 values(2, 'user02', 'pass02', null,null,'010-1234-5678',
'hong123@kh.or.kr');
-- user_no, user_id 두개의 고유값이 이미 지정해서 들어가있음
INSERT INTO user_unique3 values(1, 'user01', 'pass01', null,null,'010-1234-5678',
'hong123@kh.or.kr');
SELECT * FROM user_unique3;


CREATE TABLE user_primarykey1(
	USER_no NUMBER PRIMARY KEY,
	USER_id varchar2(20) UNIQUE,
	USER_pwd varchar2(30) NOT NULL,
	user_name varchar2(30),
	gender varchar2(10),
	phone varchar2(30),
	email varchar2(50)
	);
INSERT INTO user_primarykey1 values(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
-- SQL Error [1] [23000]: ORA-00001: 무결성 제약 조건(KH.SYS_C008357)에 위배됩니다
-- user_no number 에서 위배됨
INSERT INTO user_primarykey1 values(1, 'user02', 'pass02', '이순신', '남', '010-5678-9012', 'lee123@kh.or.kr');
-- SQL Error [1400] [23000]: ORA-01400: NULL을 ("KH"."USER_PRIMARYKEY1"."USER_NO") 안에 삽입할 수 없습니다
-- null값이 사용될수 없음
INSERT INTO user_primarykey1 values(NULL , 'user03', 'pass03', '유관순', '여', '010-3131-3131', 'yoo13@kh.or.kr');

CREATE TABLE user_primarykey2(
	USER_no NUMBER,
	USER_id varchar2(20) UNIQUE,
	USER_pwd varchar2(30) NOT NULL,
	user_name varchar2(30),
	gender varchar2(10),
	phone varchar2(30),
	email varchar2(50),
	PRIMARY KEY (user_no)
	);
INSERT INTO user_primarykey1 values(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
-- SQL Error [1] [23000]: ORA-00001: 무결성 제약 조건(KH.SYS_C008357)에 위배됩니다
-- user_no number 에서 위배됨
INSERT INTO user_primarykey1 values(1, 'user02', 'pass02', '이순신', '남', '010-5678-9012', 'lee123@kh.or.kr');
-- SQL Error [1400] [23000]: ORA-01400: NULL을 ("KH"."USER_PRIMARYKEY1"."USER_NO") 안에 삽입할 수 없습니다
-- null값이 사용될수 없음
INSERT INTO user_primarykey1 values(NULL , 'user03', 'pass03', '유관순', '여', '010-3131-3131', 'yoo13@kh.or.kr');

CREATE TABLE user_primarykey3(
	USER_no NUMBER,
	USER_id varchar2(20),
	USER_pwd varchar2(30) NOT NULL,
	user_name varchar2(30),
	gender varchar2(10),
	phone varchar2(30),
	email varchar2(50),
	PRIMARY KEY (user_no, user_id)
	);
INSERT INTO user_primarykey3 values(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
INSERT INTO user_primarykey3 values(1, 'user02', 'pass02', '이순신', '남', '010-5678-9012', 'lee123@kh.or.kr');
INSERT INTO user_primarykey3 values(2 , 'user01', 'pass01', '유관순', '여', '010-3131-3131', 'yoo13@kh.or.kr');
-- SQL Error [1] [23000]: ORA-00001: 무결성 제약 조건(KH.SYS_C008363)에 위배됩니다
-- user_no and user_id 에 primary key 를 제약조건 걸어서 홍길동과 겹쳐서 위배됨
INSERT INTO user_primarykey3 values(1, 'user01', 'pass01', '심사임당', '여', '010-1111-1111', 'shin123@kh.or.kr');

CREATE TABLE user_grade(
	grade_code NUMBER PRIMARY KEY,
	grade_name varchar2(30) NOT null
);
INSERT INTO user_grade values(10, '일반회원');
INSERT INTO user_grade values(20, '우수회원');
INSERT INTO user_grade values(30, '특별회원');
SELECT * FROM USER_grade;

CREATE TABLE user_foreignkey1(
	user_no NUMBER PRIMARY KEY,
	user_id varchar2(20) UNIQUE,
	USER_pwd varchar2(30) NOT NULL,
	USER_name varchar2(30),
	gender varchar2(10),
	phone varchar2(30),
	email varchar2(50),
	grade_code NUMBER,
	FOREIGN KEY (grade_code) REFERENCES user_grade(grade_code)
);
INSERT INTO user_foreignkey1 values(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr',10);
INSERT INTO user_foreignkey1 values(2, 'user02', 'pass02', '이순신', '남', '010-9012-3456', 'lee123@kh.or.kr',20);
INSERT INTO user_foreignkey1 values(3, 'user03', 'pass03', '유관순', '여', '010-3131-3131', 'yoo123@kh.or.kr',30);
INSERT INTO user_foreignkey1 values(4, 'user04', 'pass04', '신사임당', '여', '010-1111-1111', 'shin123@kh.or.kr',null);
-- SQL Error [2291] [23000]: ORA-02291: 무결성 제약조건(KH.SYS_C008369)이 위배되었습니다- 부모 키가 없습니다
-- 위에 user-grade 부모를 잡아 foreignkey 값을 10,20,30 만 주어 null값이 들어가지만 50값은 없어 오류남
INSERT INTO user_foreignkey1 values(5, 'user05', 'pass05', '안중근', '남', '010-4444-4444', 'ahn123@kh.or.kr', 50);


CREATE TABLE user_foreignkey2(
	user_no NUMBER PRIMARY KEY,
	user_id varchar2(20) UNIQUE,
	USER_pwd varchar2(30) NOT NULL,
	USER_name varchar2(30),
	gender varchar2(10),
	phone varchar2(30),
	email varchar2(50),
	grade_code NUMBER REFERENCES user_grade(grade_code)
);
INSERT INTO user_foreignkey2 values(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr',10);
INSERT INTO user_foreignkey2 values(2, 'user02', 'pass02', '이순신', '남', '010-9012-3456', 'lee123@kh.or.kr',20);
INSERT INTO user_foreignkey2 values(3, 'user03', 'pass03', '유관순', '여', '010-3131-3131', 'yoo123@kh.or.kr',30);
INSERT INTO user_foreignkey2 values(4, 'user04', 'pass04', '신사임당', '여', '010-1111-1111', 'shin123@kh.or.kr',null);
-- SQL Error [2291] [23000]: ORA-02291: 무결성 제약조건(KH.SYS_C008369)이 위배되었습니다- 부모 키가 없습니다
-- 위에 user-grade 부모를 잡아 foreignkey 값을 10,20,30 만 주어 null값이 들어가지만 50값은 없어 오류남
INSERT INTO user_foreignkey2 values(5, 'user05', 'pass05', '안중근', '남', '010-4444-4444', 'ahn123@kh.or.kr', 50);
SELECT * FROM user_foreignkey2;
-- USER_GRADE 테이블의 데이터 삭제 시 참조 무결성에 위배되어 삭제 불가능
--부모테이블의 데이터 삭제 시 자식 테이블의 데이터를 어떤 방식으로 처리할지에 대한 내용을
-- 제약조건 설정 시 옵션으로 지정 가능
-- 기본 삭제 옵션은 ON DELETE RESTRICTED로 지정되어 있음
DROP TABLE USER_FOREIGNKEY2;
DROP TABLE USER_FOREIGNKEY1;
DROP TABLE user_grade;
CREATE TABLE user_foreignkey2(
	user_no NUMBER PRIMARY KEY,
	user_id varchar2(20) UNIQUE,
	user_pwd varchar2(30) NOT NULL,
	user_name varchar2(30),
	gender varchar2(10),
	phone varchar2(30),
	email varchar2(50),
	grade_code NUMBER REFERENCES user_grade(grade_code) ON DELETE SET NULL 
	);

DELETE FROM user_grade WHERE grade_code = 10;
SELECT * FROM USER_GRADE;
SELECT * FROM user_foreignkey2;
SELECT * FROM user_constraints;
CREATE TABLE user_foreignkey2(
	user_no NUMBER PRIMARY KEY,
	user_id varchar2(20) UNIQUE,
	user_pwd varchar2(30) NOT NULL,
	user_name varchar2(30),
	gender varchar2(10),
	phone varchar2(30),
	email varchar2(50),
	grade_code NUMBER REFERENCES user_grade (grade_code) ON DELETE cascade 
	);
DELETE FROM USER_grade WHERE grade_code = 10;

CREATE TABLE user_check(
	user_no NUMBER PRIMARY KEY,
	user_id varchar2(20) UNIQUE,
	user_pwd varchar2(30) NOT NULL,
	user_name varchar2(30),
	gender varchar2(10) check(gender IN('남','여')),
	phone varchar2(30),
	email varchar2(50)
	);
--SQL Error [2290] [23000]: ORA-02290: 체크 제약조건(KH.SYS_C008391)이 위배되었습니다
-- gender값이 check 를 걸어 '남'or'여' 중 한개가 필수로 들어가야됨
INSERT INTO user_check VALUES(1,'user01','pass01','홍길동','남자','010-1234-5678',
'hong123@kh.or.kr');

CREATE TABLE employee_copy
AS SELECT emp_id, emp_name, salary,dept_title,job_name
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = dept_id)
LEFT JOIN job using(job_code);


-- 20230713 목요일 실습 DML
INSERT INTO EMPLOYEE
values(1, '홍길동', '820114-1010101', 'hong_kd@kh.or.kr', '01099998888','D5','J2','S4',3800000,
NULL, '200',sysdate,NULL,default);
SELECT * FROM EMPLOYEE;
UPDATE EMPLOYEE SET emp_id = 290 WHERE EMP_NAME = '홍길동';
DELETE employee WHERE emp_name = '홍길동';

INSERT INTO employee (emp_id,emp_name,emp_no,email,phone,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,
BONUS,MANAGER_ID,HIRE_DATE,ENT_DATE,ENT_YN)
values(900,'장채현','901123-1080503','jang_ch@kh.or.kr','01055569512','D1','J8','S3',43000000,0.2
, '200',sysdate,null,default);
-- 또는
INSERT INTO EMPLOYEE
values(900,'장채현','901123-1080503','jang_ch@kh.or.kr','01055569512','D1','J8','S3',43000000,0.2
, '200',sysdate,null,default);

CREATE TABLE emp_01(
	emp_id NUMBER,
	emp_name varchar2(30),
	dept_title varchar2(20)
	);
INSERT INTO emp_01(
	SELECT emp_id,
	emp_name,
	dept_title
	FROM EMPLOYEE
	LEFT JOIN DEPARTMENT ON (dept_code = dept_id)
	);
-- insert 시 values 대신 서브쿼리 이용 가능
SELECT * FROM emp_01;
CREATE TABLE emp_dept_d1 AS SELECT emp_id, emp_name, dept_code, hire_date
FROM EMPLOYEE e WHERE 1 = 0;
CREATE TABLE emp_manager AS SELECT emp_id, emp_name, manager_id FROM employee WHERE 1=0;
SELECT * FROM emp_dept_d1;
SELECT * FROM emp_manager;
--EMP_DEPT_D1테이블에 EMPLOYEE테이블의 부서코드가 D1인 직원의
--사번, 이름, 소속부서, 입사일을 삽입하고
--EMP_MANAGER테이블에 EMPLOYEE테이블의 부서코드가 D1인 직원의
--사번, 이름, 관리자 사번을 조회하여 삽입
INSERT ALL
INTO emp_dept_d1 values(emp_id, emp_name, dept_code, hire_date)
INTO emp_manager values(emp_id, emp_name, manager_id)
SELECT emp_id, emp_name, dept_code, hire_date, manager_id
FROM EMPLOYEE e 
WHERE dept_code = 'D1';
-- EMPLOYEE테이블의 구조를 복사하여 사번, 이름, 입사일, 급여를 기록할 수 있는
-- 테이블 EMP_OLD와 EMP_NEW 생성
CREATE TABLE emp_old AS SELECT emp_id, emp_name, hire_date, salary
FROM EMPLOYEE e WHERE 1 = 0;
CREATE TABLE emp_new AS SELECT emp_id, emp_name, hire_date, salary
FROM EMPLOYEE e WHERE 1 = 0;
SELECT * FROM emp_old;
SELECT * FROM emp_new;
INSERT ALL
WHEN hire_date < '2000/01/01' THEN
	INTO emp_old values(emp_id,emp_name,hire_date,salary)
WHEN hire_date > '2000/01/01' THEN
	INTO emp_new values(emp_id,emp_name,hire_date,salary)
SELECT emp_id,emp_name,hire_date,salary
FROM EMPLOYEE;

CREATE TABLE dept_copy AS SELECT*FROM DEPARTMENT;
SELECT * FROM dept_copy;
UPDATE dept_copy SET dept_title = '전략기획팀'
WHERE dept_id = 'D9';
-- 방명수 사원의 급여와 보너스율을 유재식 사원과 동일하게 변경
CREATE TABLE emp_salary AS SELECT emp_id,emp_name,dept_code,salary,bonus
FROM employee;
SELECT * FROM emp_salary WHERE emp_name in('유재식','방명수');
UPDATE emp_salary 
SET salary = (SELECT salary FROM EMP_SALARY WHERE emp_name='유재식'),
bonus = (SELECT bonus FROM EMP_SALARY WHERE emp_name = '유재식')
WHERE emp_name = '방명수';
-- 각각 쿼리문 작성한 것을 다중 행 다중 열 서브쿼리로 변경
UPDATE emp_salary
SET (salary, bonus) = (SELECT salary, bonus FROM EMP_SALARY WHERE emp_name = '유재식')
WHERE emp_name = '방명수';
SELECT * FROM emp_salary WHERE emp_name in('유재식','방명수');
-- emp_salary 테이블에서 아시아 지역에 근무하는 ㅈ기원의 보너스 포인트 0.3으로 변경
UPDATE emp_salary SET bonus = 0.3 
WHERE emp_id IN (SELECT emp_id FROM EMPLOYEE JOIN DEPARTMENT ON(DEPT_id = DEPT_code)
JOIN LOCATION on(location_id = local_code)
WHERE LOCAL_name LIKE 'ASIA%');
SELECT * FROM EMP_SALARY;

DELETE FROM EMPLOYEE e WHERE e.EMP_NAME  = '장채현';
-- where 조건을 설정하지 않으면 모든 행 삭제
DELETE FROM DEPARTMENT d WHERE DEPT_ID ='D1';
SELECT * FROM DEPARTMENT d;
-- 삭제 시 foreign key 제약조건으로 컬럼 삭제가 불가능한 경우 제약조건을 비활성화 할 수 있음
DELETE FROM DEPARTMENT WHERE DEPT_ID = 'D1';
ALTER TABLE EMPLOYEE disable CONSTRAINT emp_deptcode_fk CASCADE;
DELETE FROM DEPARTMENT WHERE DEPT_ID = 'D1';

-- 비활성화된 제약 조건을 다시 활성화 시킬 수 있음
ALTER TABLE EMPLOYEE enable CONSTRAINT emp_deptcode_fk;
TRUNCATE TABLE emp_salary;
SELECT * FROM EMP_SALARY;
-- 모든 컬럼이 삭제되긴 하지만 테이블의 구조는 남아있음
ROLLBACK;
-- rollback 후에도 컬럼이 복구되지 않음

-- DDL ALTER,DROP 
SELECT * FROM DEPT_COPY;
ALTER TABLE dept_copy
ADD(cname varchar2(20));
ALTER TABLE DEPT_COPY
ADD(lname varchar2(40) default'한국');

ALTER TABLE dept_copy
ADD CONSTRAINT dcopy_did_pk PRIMARY KEY(dept_id);
ADD CONSTRAINT dcopy_dtitle_unq UNIQUE(dept_title);
MODIFY lname CONSTRAINT dcopy_lname_nn NOT NULL;
SELECT * FROM DEPT_COPY;
SELECT uc.constraint_name,
	uc.constraint_type,
	uc.table_name,
	ucc.column_name,
	uc.search_condition
FROM user_constraints uc
JOIN user_cons_columns ucc ON (uc.CONSTRAINT_NAME=ucc.CONSTRAINT_NAME)
WHERE uc.TABLE_NAME = 'dept_copy';
SELECT * FROM USER_CONSTRAINTS;

ALTER TABLE DEPT_COPY 
MODIFY dept_id char(3)
MODIFY dept_title varchar(30)
MODIFY location_id varchar(2)
MODIFY cname char(20)
MODIFY lname default'미국';

ALTER TABLE DEPT_COPY 
DROP COLUMN dept_id;

CREATE TABLE tb1(
	pk NUMBER PRIMARY KEY,
	fk NUMBER REFERENCES tb1,
	col1 NUMBER,
	check(pk > 0 AND col1 > 0)
);
SELECT * FROM tb1;
ALTER TABLE tb1 DROP COLUMN pk;
-- 컬럼 삭제 시 참조하고 있는 컬럼이 있다면 컬럼 삭제 불가능
ALTER TABLE tb1 DROP COLUMN pk CASCADE CONSTRAINT;

ALTER TABLE dept_copy
DROP CONSTRAINT dcopy_did_pk
DROP CONSTRAINT dcopy_dtitle_unq
MODIFY lname NULL;

ALTER TABLE DEPT_COPY RENAME COLUMN dept_title TO dept_name;
SELECT * FROM DEPT_COPY;

ALTER TABLE USER_FOREIGNKEY2
RENAME constraint sys_c007211 TO uf_up_nn;

ALTER TABLE USER_FOREIGNKEY2
RENAME CONSTRAINT sys_c007212 TO uf_un_pk;

ALTER TABLE USER_FOREIGNKEY2
RENAME CONSTRAINT sys_c007213 TO uf_ui_uq;

ALTER TABLE USER_FOREIGNKEY2
RENAME CONSTRAINT sys_c007214 TO uf_gc_fk;

SELECT uc.constraint_name 이름,
uc.constraint_type 유형,
ucc.COLUMN_name 컬럼명,
uc.r_constraint_name 참조,
uc.delete_rule 삭제규칙
FROM USER_CONSTRAINTS uc
JOIN USER_CONS_COLUMNS ucc ON (uc.CONSTRAINT_NAME = ucc.CONSTRAINT_NAME)
WHERE uc.TABLE_NAME = 'user_foreignkey2';

ALTER TABLE DEPT_COPY RENAME TO dept_test;
RENAME dept_copy TO dept_test;

DROP TABLE dept_test CASCADE CONSTRAINT;

-- view

CREATE OR REPLACE VIEW v_employee
AS SELECT emp_id, emp_name, dept_title, NATIONAL_name
FROM EMPLOYEE e 
LEFT JOIN DEPARTMENT d ON (dept_id = DEPT_CODE)
LEFT JOIN location ON (location_id = LOCAL_code)
LEFT JOIN NATIONAL using(national_code);
SELECT * FROM v_employee;
SELECT * FROM EMPLOYEE e ;
SELECT * FROM JOB j ;
CREATE OR REPLACE VIEW v_emp_job
AS SELECT e.emp_id, e.emp_name, job.job_name,
DECODE(SUBSTR(emp_no,8,1),1, '남',2,'여') AS 성별 ,
EXTRACT(YEAR FROM sysdate) - extract(YEAR FROM hire_date) AS 근무년수
FROM EMPLOYEE e
JOIN job ON e.JOB_CODE = job.JOB_CODE ;
SELECT * FROM v_emp_job;

CREATE OR REPLACE VIEW v_job
AS SELECT j1.job_code, j2.job_name FROM JOB j1 JOIN job j2 ON j1.JOB_CODE = j2.JOB_CODE ;
SELECT * FROM v_job;
INSERT INTO v_job values('J8','인턴');
SELECT * FROM v_job;
-- 생성된 뷰를 가지고 DML구문 (insert,update,delete)사용가능
-- 생성된 뷰에 요청한 DML구문이 베이스 테이블도 변경함

--1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
CREATE OR REPLACE VIEW v_job2 AS SELECT job_code FROM job;
SELECT * FROM v_job2;
-- SQL Error [913] [42000]: ORA-00913: 값의 수가 너무 많습니다
INSERT INTO v_job2 values('J8','인턴');

--2. 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 컬럼이
--NOT NULL 제약조건이 지정된 경우
CREATE OR REPLACE VIEW v_job3 AS SELECT job_name FROM job;
SELECT * FROM v_job3;
-- SQL Error [1400] [23000]: ORA-01400: NULL을 ("KH"."JOB"."JOB_CODE") 안에 삽입할 수 없습니다
INSERT INTO v_job3 values('인턴');

--3. 산술 표현식으로 정의된 경우
CREATE OR REPLACE VIEW emp_sal AS SELECT emp_id, emp_name, salary,
(SALARY + (SALARY*NVL(BONUS, 0)))*12 연봉
FROM EMPLOYEE;
SELECT * FROM emp_sal;
-- SQL Error [1733] [42000]: ORA-01733: 가상 열은 사용할 수 없습니다
INSERT INTO emp_sal values(800, '정진훈', 3000000,4000000);

--4. 그룹함수나 GROUP BY절을 포함한 경우
CREATE OR REPLACE VIEW v_groupdept AS SELECT dept_code, sum(salary) 합계, avg(salary) 평균
FROM employee GROUP BY dept_code;
SELECT * FROM v_groupdept;
-- SQL Error [1733] [42000]: ORA-01733: 가상 열은 사용할 수 없습니다
INSERT INTO V_GROUPDEPT VALUES('D10',6000000,4000000);
-- SQL Error [1732] [42000]: ORA-01732: 뷰에 대한 데이터 조작이 부적합합니다
DELETE FROM V_GROUPDEPT WHERE dept_code = 'D1';

--5. DISTINCT를 포함한 경우
CREATE OR REPLACE VIEW v_dt_emp AS SELECT DISTINCT job_code FROM EMPLOYEE;
SELECT * FROM v_dt_emp;
-- SQL Error [1732] [42000]: ORA-01732: 뷰에 대한 데이터 조작이 부적합합니다
INSERT INTO v_dt_emp values('J9');
-- SQL Error [1732] [42000]: ORA-01732: 뷰에 대한 데이터 조작이 부적합합니다
DELETE FROM v_dt_emp WHERE job_code='J1';

--6. JOIN을 이용해 여러 테이블을 연결한 경우
CREATE OR REPLACE VIEW v_joinemp AS SELECT emp_id, emp_name, dept_title
FROM EMPLOYEE JOIN DEPARTMENT ON (dept_code = DEPT_ID );
SELECT * FROM V_JOINEMP;
-- SQL Error [1776] [42000]: ORA-01776: 조인 뷰에 의하여 하나 이상의 기본 테이블을 수정할 수 없습니다.
INSERT INTO v_joinemp values(888,'조세오','인사관리부');

SELECT * FROM user_views;

CREATE synonym emp FOR employee;