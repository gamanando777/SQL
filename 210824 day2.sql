-- 서브 쿼리(Sub Query)란?
-- 쿼리문안에 쿼리문이 들어가는 것 
-- 메인쿼리 + 서브쿼리 
/*  
SELECT .. FROM.. WHERE 조건절1 
		(SELECT .. FROM.. WHERE 조건절2 )
*/


-- 김경호보다 키가 크거나 같은 사람의 이름과 키를 출력하여라
-- 김경호의 키?
-- 키가 크거나 같은 사람의 이름과 키

USE sqlDB;
SELECT * FROM userTbl;

-- 서브쿼리를 쓰지 않는 경우
SELECT height FROM userTbl WHERE name = '김경호'; -- 177 얘가 서브쿼리
SELECT name, height FROM userTbl WHERE height >= 177;

-- 서브쿼리를 사용하는 경우
-- 주의사항 : 서브쿼리의 레코드 결과값은 1개로 유일해야 한다. 
SELECT name, height FROM userTbl 
	WHERE height >= (SELECT height FROM userTbl WHERE name = '김경호'); -- 서브쿼리에 들어갈 답이 하나가 아니면 오류남.

-- 아래는 에러 발생 
-- SELECT name, height FROM usertbl 
-- 	WHERE height>= (SELECT * FROM usertbl WHERE name='김경호');


-- 서브쿼리에 any 구문을 사용하는 경우 
-- any : 서브쿼리의 여러개의 결과중 한가지만 만족해도 가능 
-- SELECT .. FROM.. WHERE 조건절1 
--		ANY(SELECT .. FROM.. WHERE 조건절2 )

-- 지역이 경남인 사람의 키보다 크거나 같은 사람을 출력
-- 1.지역이 경남인 사람 추출
-- 2.경남집단의 키와 비교
SELECT * FROM userTbl WHERE addr = '경남'; -- 170

-- 서브쿼리 사용
SELECT * FROM userTbl
	WHERE height >= ANY(SELECT height FROM userTbl WHERE addr = '경남');





-- 정렬, 역정렬 
-- 결과가 출력되는 순서를 조절하는 구문 
-- 오름차순(ASCENDING) : ORDER BY 컬럼명 ASC;
-- 내림차순(DESCENDING) : ORDER BY 컬럼명 DESC;

-- userTbl 테이블에서 가입일(mDate) 컬럼명 기준으로 레코드 정렬
SELECT * FROM userTbl ORDER BY mDATE; -- 오름차순 정렬(명령어 생략 가능)
SELECT * FROM userTbl ORDER BY mDATE DESC; -- 내림차순 정렬(명령어 생략 불가능)


-- 퀴즈 : userTbl 테이블에서 키가 가장 큰사람 3명만 출력해라
-- ORDER BY, LIMIT
SELECT * FROM userTbl ORDER BY height DESC LIMIT 3;
-- SELECT * FROM usertbl LIMIT 3 ORDER BY height DESC; -- X


-- 정렬 기준이 여러개인 경우 
-- 2개의 컬럼명으로 정렬. 
-- 키가 큰 순서로 정렬하되 만약 키가 같다면 이름순으로 정렬 
--  ORDER BY 컬럼명1 ASC/DESC, 컬럼명2 ASC/DESC ...

SELECT * FROM userTbl ORDER BY height DESC, name ASC; -- 키 내림차순, 이름 가나다(오름차)순



-- 테이블 생성
-- 1) 구조를 만들고 레코드를 삽입한다. 
-- 2) 서브쿼리를 이용. 기존의 테이블에서 특정 레코드를 복사하여 생성

-- 테이블 생성 1 - 새로운 테이블 구조
-- CREATE TABLE 테이블명 (컬럼명 자료형 옵션);

CREATE TABLE userTbl2 
( userID  CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  name    VARCHAR(10) NOT NULL, -- 이름
  email   VARCHAR(30) -- 메일주소 
);

SHOW TABLES;
SELECT * FROM userTbl2; -- 비어있음


-- 테이블 생성 2 - 기존 테이블 복사
-- CREATE TABLE 새테이블명 (SELECT */컬럼명 FROM 테이블명);
-- buyTbl 테이블에서 전체 복사 => buyTbl2
CREATE TABLE buyTbl2 
	(SELECT * FROM buyTbl);
SHOW TABLES;
SELECT * FROM buyTbl2;

-- buyTbl 테이블에서 가격이 가장 비싼 레코드 5개만 qhrtk, num, prodName, price 필드만 => buyTbl3
CREATE TABLE buyTbl3 
	(SELECT num, prodName, price FROM buyTbl ORDER BY price DESC LIMIT 5);
SHOW TABLES;
SELECT * FROM buyTbl3;


-- GROUP BY
-- 그룹을 묶어주는 역할. 집계함수와 함께 사용
-- SELECT .. FROM 테이블명 GROUP BY 컬럼명;

-- 합계 구하기 SUM(컬럼명)
-- 평균 구하기 AVG(컬럼명)
-- 갯수 구하기 COUNT(컬럼명) 

-- buytbl 테이블에서 price의 전체 합계와 평균, 총 갯수 구하기
SELECT price FROM buyTbl;
SELECT SUM(price), AVG(price), COUNT(price) FROM buytbl;
SELECT price, SUM(price), AVG(price), COUNT(price) FROM buytbl;


-- GROUP BY 사용
-- 각 종목의 가격 합계, 평균을 groupName을 기준으로 정렬하여 표시하기
-- SELECT 집계함수컬럼 FROM 테이블명 GROUP BY 컬럼명;

SELECT * FROM buyTbl;
-- 종목 값 확인
SELECT DISTINCT groupName FROM buyTbl;

SELECT groupName, SUM(price), AVG(price), COUNT(price) 
	FROM buytbl 
    GROUP BY groupName
    ORDER BY groupName DESC;
    
    
-- AS 별칭이름;
-- 컬럼명을 대신하는 별칭 이름 표시
-- SELECT 컬럼명 AS 별칭명 FROM 테이블명;
SELECT userID, prodName AS 상품명, price AS 가격 FROM buyTbl;
SELECT userID, prodName AS '상품 이름', price AS 가격 FROM buyTbl;


-- 퀴즈 : buytbl 테이블에서 사용자별로 구매합계 구하기 
/*
사용자아이디별 총구매액 표시 - GROUP BY, SUM(), AS
총구매액은? SUM(price*amount)

출력양식 

사용자아이디    총구매액  
BBK 		?
EJW			?
..
*/

SELECT * FROM buyTbl ORDER BY userID;

-- 첫번째 userID만 표시(GROUP BY 필요)
SELECT userID AS '사용자아이디', 
	SUM(price*amount) AS '총 구매액' 
    FROM buyTbl; 

-- 전체 각 사용자별 총 구매액 표시
SELECT userID AS '사용자아이디', 
	SUM(price*amount) AS '총 구매액' 
    FROM buyTbl 
	GROUP BY userID
    ORDER BY SUM(price*amount) DESC;


-- 집계 함수
-- 합계 구하기 SUM(컬럼명)
-- 평균 구하기 AVG(컬럼명)
-- 갯수 구하기 COUNT(컬럼명) 
-- 최대값 구하기 MAX(필드명이나 수식)
-- 최소값 구하기 MIN(필드명이나 수식)


SELECT 	MAX(price) AS '최댓값', 
	MIN(price) AS '최솟값'
	FROM buytbl;


-- userTbl 테이블에서 가장 큰키와 가장 작은 키의 레코드를 출력하여라 
SELECT MAX(height) AS '가장 큰 키',
	MIN(height) AS '가장 작은 키' FROM userTbl;



-- userTbl 테이블에서 가장 큰 키와 가장 작은 키의 레코드를 출력하여라
-- name 값도 함께 출력

-- 가장 큰 키의 레코드 출력
SELECT MAX(height) AS '가장 큰 키' FROM userTbl; -- 186
SELECT name, height FROM userTbl WHERE height = 186;
-- 서브쿼리 사용
SELECT name, height FROM userTbl 
	WHERE height = (SELECT MAX(height) AS '가장 큰 키' FROM userTbl);
    

-- useTbl 테이블에서 가장 큰기와 가장 작은 키의 레코드를 출력하여라
SELECT name, height FROM userTbl 
	WHERE 
		height = (SELECT MAX(height) AS '가장 큰 키' FROM userTbl)
        OR
        height = (SELECT MIN(height) AS '가장 작은 키' FROM userTbl);

-- IN 을 사용했을 때
SELECT 	name, height FROM userTbl 
	WHERE 
		height IN ( (SELECT  MAX(height) FROM userTbl) , (SELECT  MIN(height) FROM userTbl));




-- HAVING 절 
-- GRUP BY를 사용하는 경우 WHERE 절이 불가능 
-- WHERE 절 대신 사용 
-- GRUP BY + 집계함수에 대해서 조건을 제한할때 사용 
-- 순서 주의 
-- SELECT .. FROM 테이블명 
-- GROUP BY 컬럼명 HAVING 조건 
-- ORDER BY 컬럼명 LIMIT 숫자;


-- buyTbl 테이블에서 총구매액이 
-- 1000 이상 조건으로 사용자(userID)별 총 구매액 표시 
-- GROUP BY 기준 : 사용자(userID)
-- 구매액 : SUM(price*amount)

--  사용자(userID) 별 총 구매액
SELECT userID AS '사용자아이디', 
	SUM(price*amount) AS '총 구매액' 
    FROM buyTbl 
	GROUP BY userID;


-- 사용자(userID) 별 총 구매액이 1000 이상
SELECT userID AS '사용자아이디', 
	SUM(price*amount) AS '총 구매액' 
    FROM buyTbl 
	GROUP BY userID
    HAVING SUM(price*amount)>=1000;
    
    
    -- 아래는 에러 발생     
-- SELECT userID AS '사용자아이디', 
-- 	SUM(price*amount) AS '총 구매액'
-- 	FROM buytbl
--  	GROUP BY userID
--     WHERE SUM(price*amount)>=1000;



-- 퀴즈
-- buyTbl 테이블에서 userID 별 
-- 평균 구매 횟수(AVG(amount))가 
-- 1~3 사이인 레코드만 출력하여라 
SELECT userID AS '사용자아이디', 
	AVG(amount) AS '평균 구매횟수' 
    FROM buyTbl 
	GROUP BY userID
    HAVING AVG(amount) BETWEEN 1 AND 3;


--  WITH ROLLUP
--  중간 합계 
-- 순서 주의 
-- SELECT .. FROM 테이블명 
-- 		GROUP BY 컬럼명 HAVING 조건 
-- 		WITH ROLLUP
-- 		ORDER BY 컬럼명 
--      LIMIT 숫자;

-- groupName 별로 합계 및 총합(price*amount) 구하기 
SELECT*FROM buyTbl; -- 원본
SELECT groupName, SUM(price*amount) 
	FROM buyTbl 
	GROUP BY groupName;
 
-- WITH ROLLUP 사용
SELECT groupName, SUM(price*amount) 
	FROM buyTbl 
	GROUP BY groupName
    WITH ROLLUP;
    
     
    

-- CRUD 명령어 
-- DML(Data Manupulation Language)
-- 레코드 삽입
-- 레코드 삭제
-- 레코드 변경


-- 레코드 삽입 1
-- INSERT INTO 테이블명 VALUES(값1, 값2 .. )

-- 레코드 삽입 2
-- INSERT INTO 테이블명 (컬럼명1, 컬럼명2... ) VALUES(값1, 값2 .. )

-- 레코드 삽입 3
-- 다른 테이블의 레코드를 SELECT 문으로 삽입하기 
-- INSERT INTO 테이블명 (컬럼명1, 컬러명2 ... ) SELECT 문 


-- buyTbl4 테이블 생성 

CREATE TABLE buyTbl4 
(  num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   userID  	CHAR(8) NOT NULL, -- 아이디(FK)
   prodName 	CHAR(6) NOT NULL, --  물품명
   groupName 	CHAR(4)  , -- 분류
   price     	INT  NOT NULL, -- 단가
   amount    	SMALLINT  NOT NULL -- 수량
);

show tables;
select * from buyTbl4;

-- 레코드 삽입 1
-- INSERT INTO 테이블명 VALUES(값1, 값2 .. )
INSERT INTO buyTbl4 VALUES(NULL, 'LSK', '청소기', '가전', 400000, 5);
select * from buyTbl4; -- 확인

-- 레코드 삽입 2
-- INSERT INTO 테이블명 (컬럼명1, 컬럼명2... ) VALUES(값1, 값2 .. )
INSERT INTO buyTbl4 
(NUM, USERID, PRODNAME, PRICE, AMOUNT)
VALUES
(NULL, 'BBS', '파이썬 정복', 25000, 3);
select * from buyTbl4; -- 확인

-- 레코드 삽입 3(서브쿼리)
-- 다른 테이블의 레코드를 SELECT 문으로 삽입하기 
-- INSERT INTO 테이블명 (컬럼명1, 컬러명2 ... ) SELECT 문 
-- buyTbl 테이블에서 '전자' groupName 레코드 
SELECT * FROM buyTbl WHERE groupName='전자';
SELECT COUNT(*) FROM buyTbl WHERE groupName='전자'; -- 4

-- num은 자동증감 필드이므로 생략 
INSERT INTO buytbl4 
	(userID, prodName, groupName, price, amount ) 
    SELECT userID, prodName, groupName, price, amount 
    FROM buytbl WHERE groupName='전자';
SELECT * FROM buytbl4;



-- 레코드 수정 
-- WHERE 절이 생략된 경우에는 모든 레코드에서 업데이트가 진행
-- UPDATE 테이블명 SET 컬럼명=값;
-- UPDATE 테이블명 SET 컬럼명=값 WHERE 절;

-- buyTbl4 테이블에서 
-- price 필드의 가격을 모두 150%로 변경하여라.
SELECT * FROM buyTbl4;
UPDATE buyTbl4 SET price=price*1.5;

-- 산술연산자
-- *, **, /, //, %, +, -

-- buyTbl4 테이블에서 
-- amount 필드값을 +5 변경하여라.
-- 필드값이 5인 경우만,
UPDATE buytbl4 SET amount=amount+5 
	WHERE amount=5;
SELECT * FROM buytbl4;


-- 레코드 삭제 
-- DELETE FROM 테이블명 WEHRE 절 
-- WHERE 절 생략시 레코드 모두 삭제 
SELECT * FROM buytbl4;

-- groupName 이 '전자'인 레코드를 삭제하라
DELETE FROM buyTbl4 WHERE groupName = '전자';
SELECT * FROM buyTbl4;



-- 테이블 삭제 
-- DROP TABLE 테이블명;
-- 테이블 구조 제외 레코드만 삭제 
-- TRUNCATE TABLE 테이블명;

-- buyTbl을 이용해 3개의 테이블 생성 :  buytbl_a, buytbl_b
-- CREATE TABLE 테이블명1 (SELECT ~ FROM 테이블명2);
-- IF NOT EXIST : 기존에 테이블이 없다면
-- CREATE TABLE IF NOT EXIST 테이블명1 (SELECT ~ FROM 테이블명2);
CREATE TABLE IF NOT EXISTS buyTbl_a
	(SELECT userID, prodName, price FROM buyTbl);
CREATE TABLE IF NOT EXISTS buyTbl_b
	(SELECT userID, prodName, price FROM buyTbl);   

SHOW TABLES; -- 확인




-- TRUNCATE TABLE 테이블명;
-- 테이블 존재, 레코드는 없음
SELECT count(*) FROM buyTbl_a;-- 12
TRUNCATE TABLE buyTbl_a;
SELECT count(*) FROM buyTbl_a; -- 0



-- DROP TABLE 테이블명;
-- 테이블 완전 삭제 
DROP TABLE buyTbl_b;
SHOW TABLES;


-- 데이타베이스 생성, 삭제 
-- CREATE DATABASE IF NOT EXISTS 데이터베이스명;
-- CREATE DATABASE 데이터베이스명;

-- DROP DATABASE IF EXISTS 데이터베이스명; 
-- DROP DATABASE 데이터베이스명;

-- 계정에 있는 데이터베이스 목록 확인
SHOW DATABASES;


-- sqldb2 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS sqldb2;
SHOW DATABASES; -- 생성 확인
DROP DATABASE IF EXISTS sqlDB2; -- 삭제
SHOW DATABASES; -- 삭제 확인





-- 변수란?
-- 값을 저장하는 공간
-- SET @변수명 = 값;
-- 변수 출력 : SELECT @변수명;


SET @a = 1;
SET @b = 3.14;
SET @c = 'Hello Future';
SET @d = '2021-08-24';


SELECT @a,@b,@c,@d;
SELECT @a+@b ;-- 정수+실수 = 실수

set @t1 = '안녕하세요';
set @t2 = '반갑습니다';
SELECT @t1, @t2, @t1+@t2;



/* 퀴즈
 usertbl 테이블에서 키가 180 넘는 
 레코드만 추출한 후 아래와 같은 
 형태로 출력하여라 
 
                    이름    키   
 가수이름 => 김경호   ?  cm
 가수이름 => 이승기   ?  cm 
 */

USE sqldb;
 SELECT name AS '이름', height AS '키' 
	FROM usertbl WHERE height>=180;

-- 변수 지정 
SET @deco = '가수이름 =>';
SET @unit = 'cm';

-- userTbl + 변수 활용
 SELECT @deco AS ' ', name AS '이름', height AS '키', @unit  AS ' '
	FROM usertbl WHERE height>=180;


SELECT @deco, name, height, @unit FROM userTbl;


-- 함수란?
-- 내장함수, 외장함수, 사용자정의함수
-- 집계함수 : MAX(), MIN(), AVG(), SUM(), COUNT()



-- 데이터 형변환 CASTING 
/*데이터형식 :
 BINARY, CHAR(), DATE , TIME, 
 SIGNED INTEGER, UNSIGNED INTEGER*/ 
-- 정수+실수 = 실수(묵시적 형변환)
-- 실수 => 정수, 숫자 => 문자열 (강제적 형변환)
-- CAST ( .. AS 데이터형식)
-- CONVERT ( .. , 데이터형식)

-- 실수 => 정수
-- buyTbl 테이블에서 평균구매횟수
SELECT * FROM buyTbl;
SELECT 
	AVG(amount), 
    CAST(AVG(amount) AS SIGNED INTEGER), 
    CONVERT(AVG(amount), SIGNED INTEGER)
    FROM buyTbl;

-- 숫자가 들어간 문자 => 숫자
SELECT 
	'2rd', CONVERT('2rd', SIGNED INTEGER), -- 2
    '34and45', CONVERT('34and45', SIGNED INTEGER); -- 34
    
-- 숫자 => 문자
SELECT 
	3.14, CONVERT(3.14, CHAR), 
    100, CONVERT(100, CHAR);




-- 제어흐름함수 
-- IF(조건식, 값1, 값2) : 수식이 참이면 값1, 거짓이면 값2
-- IFNULL(값1, 값2) : 값1이 NULL이 아니면 값1 반환, NULL 이면 값2 반환   
-- NULLIF(수식1, 수식2) : 수식1과 수식2가 같으면 NULL, 다르면 수식1 반환

SELECT '100>10=>', IF(100>10, '참', '거짓');
SELECT '100>10=>', IF(100<10, '참', '거짓');

SELECT ifnull(null, 'Hello World'), ifnull(100, 'Hello World'); -- Hello world, 100

SELECT * FROM buyTbl;
SELECT * FROM buytbl WHERE groupName IS NULL;

SELECT prodName, groupName, ifnull(groupName, 'x') FROM buytbl;

-- NULLIF(수식1,수식2)
-- 수식1의 값 = 수식2의 값 이면 NULL, 수식1의 값 =/= 수식2의 값 이면 수식1의 결과값 출력
SELECT nullif(20+50, 30+40), nullif(20+50,30+140); -- , 70




-- 다중분기 
-- CASE 변수/컬럼명/값1/수식 
--     WHEN 값2 THEN 결과값1 
--     WHEN 값3 THEN 결과값2
--     ELSE 결과값n 
--     END;

-- 변수 지정
SET @n = 1;

SELECT
	CASE @n
		WHEN 0 THEN '영'
		WHEN 1 THEN '하나'
		WHEN 2 THEN '둘'
		ELSE '   '
        END;
        


-- 홀수와 짝수 출력
-- 숫자%2 == 0 이면 짝수, 아니면 홀수

SET @mynum = 999;

SELECT
	@mynum AS '숫자',
	CASE @mynum%2
		WHEN 0 THEN '짝수'
		ELSE '홀수'
        END AS '결과';
        


-- buytbl 테이블에서 price 컬럼값이 따라 짝수, 홀수 출력하기
SELECT price FROM buyTbl ORDER BY price;
SELECT
	price AS '숫자',
	CASE price%2
		WHEN 0 THEN '짝수'
		ELSE '홀수'
        END AS '결과'
	FROM buyTbl
    ORDER BY price;

























