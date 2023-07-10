-- c## 제외하기위한 코드
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
-- 계정 생성
CREATE USER kh IDENTIFIED BY kh;
-- 권한부여
GRANT CONNECT, resource, dba TO kh;