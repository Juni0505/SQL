-- c## 제외하기위한 코드
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
-- 계정 생성
CREATE USER kh IDENTIFIED BY kh;
-- 권한부여
GRANT CONNECT, resource, dba TO kh;


-- ROLE
-- 접속관련된 설정- oracle 12 이후 버젼에서 false 상태로 접속됨.
ALTER SESSION SET "_ORACLE_SCRIPT"= TRUE;
CREATE USER kh2 IDENTIFIED BY kh2;
CREATE ROLE role_manager;

GRANT CONNECT, resource TO kh2;
-- connect -- 롤이름
-- 권한들의 묶음 = 롤
-- create session -- 접속권한
-- create table, alter table, drop table, create view, drop veiw, create sequence, alter sequence...
-- 공간 space를 사용하는 권한들 묶어서 resource 롤에 지정함.

-- 해당하는 하나의 role을 만들어서 그 role에 원하는 명령어들을 집합해 하나의 권한 목록들을 만들어 사용하는것
-- 특수한 권한들을 나누어 분류하여 배분할 떄 유용한 명령어
-- grant 권한명, 권한명, ... 롤명, 롤명, ... to 롤명, 사용자명, ... ;
GRANT create table, CREATE VIEW, TO ROLE_manager;
GRANT role_manager TO kh2;
-- revoke로 해당 명령어들의 권한들을 회수할수 있음
REVOKE FROM role_manger;
