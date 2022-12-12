/*/ SQL 스크립트 파일 저장하기 
SQL 에디터창에서  Ctrl+S
파일명.sql
*/
-- <SQL 주석> 
-- 한줄 주석 [Ctrl]+[/]

/*
 여러줄
 주석 
*/


-- <워크벤치에서 데이타베이스 접속하기> 
-- 데이타베이스 사용하기 
-- USE 데이타베이스명;

/*<워크벤치의 [Schemas] 탭 클릭 
데이타베이스 목록 더블클릭 
데이타베이스가 진하게 표시 
*/


-- <워크벤치에서 데이타베이스 접속하기> 
-- 데이타베이스 사용하기 
-- USE 데이타베이스명;


-- world 데이터베이스 접속
use world;
use employees;

-- 현재 계정에 어떤 DB가 있는지 보기
show DATABASES;


-- 테이블 정보 조회
SHOW TABLE STATUS;


-- 테이블 이름만 간단히 보기
SHOW TABLES; 



-- 테이블 구조 확인하기 
-- DESCRIBE(DESC) 테이블명;
DESCRIBE employees; 
DESC employees;

-- 테이블 레코드 표시하기 : SELECT
-- SELECT * FROM 데이타베이스명.테이블명;
-- SELECT * FROM 테이블명;
SELECT * from employees;
SELECT * FROM employees.employees;

-- SELECT 컬럼명1, 컬럼명2, ... FROM 테이블명; 
select first_name, last_name from employees;


-- LIMIT 갯수 제한 
-- SELECT * FROM 테이블명 LIMIT 정수;
USE world;
SELECT * FROM city;
SELECT * FROM city LIMIT 3;



-- *********************



-- 책의 실습예제 만들기 : p194 
-- 01. 데이터베이스 생성 sqldb
-- 02. userTbl, buyTbl 테이블 생성
-- 03. 각 테이블 안에 레코드 삽입


-- 데이타베이스 생성하기 
-- CREATE DATABASE 데이타베이스명; 
CREATE DATABASE sqlDB;

-- sqlDB 접속
USE sqlDB;


-- 테이블 생성하기
-- create table 테이블명 (필드명 자료형 옵션);

-- 회원 테이블
CREATE TABLE userTbl 
( userID  	CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  name    	VARCHAR(10) NOT NULL, -- 이름
  birthYear   INT NOT NULL,  -- 출생년도
  addr	  	CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  mobile1	CHAR(3), -- 휴대폰의 국번(011, 016, 017, 018, 019, 010 등)
  mobile2	CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
  height    	SMALLINT,  -- 키
  mDate    	DATE  -- 회원 가입일
);
-- userTbl 테이블 생성 확인 
-- sqlDB 데이타베이스안에 생성되었는가?
show tables;
desc usertbl;

-- 회원 구매 테이블
CREATE TABLE buyTbl 
(  num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   userID  	CHAR(8) NOT NULL, -- 아이디(FK)
   prodName 	CHAR(6) NOT NULL, --  물품명
   groupName 	CHAR(4)  , -- 분류
   price     	INT  NOT NULL, -- 단가
   amount    	SMALLINT  NOT NULL, -- 수량
-- usrTbl의 userID를 참조. 외래키로 정의 
   FOREIGN KEY (userID) REFERENCES userTbl(userID)
);



-- userTbl 테이블 생성 확인 
-- sqlDB 데이타베이스안에 생성되었는가?
show tables;
desc buytbl;

-- 지금은 비어있음
select * from usertbl;
select * from buytbl;


-- 레코드 삽입하기 
-- 생성된 컬럼명 순서 주의
-- 데이터형 확인 (숫자형, 문자형 '', 날짜형 년도-월-일)
-- INSERT INTO 테이블명 컬럼명1, 컬럼명2 VALUES  (값1, 값2 ...);
-- INSERT INTO 테이블명 VALUES (값1, 값2 ...);  <-이걸 더 많이씀

INSERT INTO userTbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO userTbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO userTbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO userTbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO userTbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO userTbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO userTbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO userTbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO userTbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO userTbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');


-- 지금은 있음
select * from usertbl;

-- 총 레코드 갯수 확인하기 
-- SELECT COUNT(*) FROM 테이블명;
SELECT COUNT(*) FROM userTbl;


-- buyTbl 테이블에 레코드 삽입하기buytbl
-- 주의 사항1 : num 필드명이 AUTO_INCREMENT
-- 주의 사항2 : userID 필드명은 userTbl 테이블의 userId와 연결 

DESC buyTbl;

-- 첫번째 컬럼명이 NULL인 이유: 자동숫자증감 AUTO_INCREMENT
INSERT INTO buyTbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);

SELECT * FROM buyTbl;

INSERT INTO buyTbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buyTbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buyTbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buyTbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);



SELECT * FROM buyTbl;

SELECT COUNT(*) FROM buyTbl; -- 12




-- where 절로 조건에 맞는 레코드 출력하기 
-- SELECT 컬러명1, 컬럼명2.. 또는 * FROM 테이블명 WHERE 조건절
-- WHERE 조건절 : 비교연산자(>,<,=, >=, <=) 논리연산자(AND, OR, NOT)


-- userTbl 테이블에서 김경호만 출력하기 
SELECT * FROM userTbl WHERE name = '김경호';


-- userTbl 테이블에서 김경호만 출력하기 
-- SELECT * FROM 테이블명 WHERE 필드명 비교연산자 값
SELECT * FROM userTbl WHERE name = '김경호';

-- userTbl 테이블에서 김경호의 핸드폰 연락처만  출력하기 
SELECT mobile1, mobile2 FROM userTbl WHERE name = '김경호';

-- userTbl 테이블에서 키가 175 보다 작은 레코드만 출력하기 
SELECT * FROM userTbl WHERE height < 175;
SELECT COUNT(*) FROM userTbl WHERE height < 175; -- 5


-- SELECT * FROM 테이블명 WHERE (필드명 비교연산자 값) 논리연산자 (필드명 비교연산자 값)
-- AND 논리곱 / OR 논리합 / 부정 NOT 

-- userTbl 테이블에서 birthYear 이 1970 보다 크거나 같고 
-- height 이 182보다 크다
SELECT * FROM usertbl WHERE birthYear >=1970;
SELECT * FROM usertbl WHERE height >182;

SELECT * FROM usertbl WHERE (birthYear >=1970) AND (height > 175);
SELECT COUNT(*) FROM usertbl WHERE (birthYear >=1970) AND (height > 175); -- 4



-- 논리합 (or)
-- userTbl 테이블에서 birthYear 가 1970 보다 크거나 같다  또는 
-- height 이 175보다 크다 
SELECT * FROM userTbl WHERE (birthYear >= 1970) OR (height > 175);
SELECT COUNT(*) FROM userTbl WHERE (birthYear >= 1970) OR (height > 175); -- 7


-- 부정 NOT 
SELECT * FROM userTbl WHERE height > 175;
SELECT * FROM userTbl WHERE NOT(height > 175);

-- BETWEEN 연산자 
-- 범위를 지정할 때 사용,  연속적인 값 사이에서 검색  
-- WHERE 컬럼명 BETWEEN 값1 AND 값2
SELECT * FROM userTbl;

-- 태어난 년도가 1971~1975 범위인 경우의 레코드 출력 
-- 1971 <= 태어난년도 <= 1975
-- 논리연산자와 비교연산자 이용 
SELECT * FROM userTbl WHERE (birthYear >= 1971) AND (birthYear <= 1975);
-- BETWEEN 연산자 이용 
SELECT * FROM userTbl WHERE birthYear BETWEEN 1971 AND 1975;


-- IN 연산자
-- 특정값 만족 
-- WHERE 컬럼명 IN (값1, 값2 ...)
-- userTbl 테이블에서 addr 컬럼값이 경남, 서울 인 레코드
SELECT * FROM userTbl WHERE (addr = '경남') OR (addr = '서울');
SELECT * FROM userTbl WHERE addr IN ('경남','서울');
-- userTbl 테이블에서 addr 컬럼값이 경남, 전남, 경북인 레코드에서 Name, addr 컬럼  
SELECT * FROM userTbl WHERE addr IN ('경남','전남','경북');


-- LIKE 연산자 
-- WHERE 컬럼명 LIKE 연산자
-- 컬럼명 데이터형은 문자열 형태
-- 문자열이 내용 검색 LIKE ..%(무엇이든. 만능문자 스타일) 
-- 문자열이 내용 검색 LIKE _(글자수).. 글자 갯수와 관련. 글자수 _(언더바)

-- userTbl 테이블에서 name 컬럼값이 김으로 시작하는 레코드만 출력
 SELECT * FROM userTbl WHERE name LIKE '김%';
-- 김으로 시작하고 뒤의 글자수는 상관없음
 SELECT * FROM userTbl WHERE name LIKE '김%'; -- 김*
 -- 김으로 시작하고 뒤의 글자수는 두글자 
 SELECT * FROM userTbl WHERE name LIKE '김__'; -- 김??


-- addr 컬럼값이 ~남으로 끝나는 레코드만 출력 
SELECT * FROM userTbl WHERE addr LIKE '%남'; 
SELECT * FROM userTbl WHERE addr LIKE '_남';


-- name 값이 조~로 시작하고 ~우 로 끝나는 레코드 
SELECT * FROM userTbl WHERE name LIKE '조%우'; 
SELECT * FROM userTbl WHERE name LIKE '조_우';


-- IS NULL 연산자
-- 데이터값이 NULL인 경우
-- WHERE 컬럼명 IS NULL
SELECT * FROM userTbl; 

-- userTbl 테이블에서 핸드폰 정보가 없는 레코드 출력
-- 비교연산자 = NULL X
SELECT *FROM userTbl WHERE mobile1 =NULL; -- 값 안나옴
-- IS NULL 이용
SELECT * FROM userTbl WHERE mobile1 IS NULL;


-- 중복을 제거하는 DISTINCT
-- SELECT DISTINCT 컬럼명 FROM 테이블명;
-- 컬럼값에서 중복값을 제거하고 출력
-- userTbl 테이블에서 addr 주소 필드값이 어떤 값으로 구성되었을까?
SELECT addr FROM userTbl;
SELECT DISTINCT addr FROM userTbl;


