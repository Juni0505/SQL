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




