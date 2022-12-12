-- 281 교재 참조
-- 3개의 테이블 생성 
-- sqlDB 데이터베이스에 3개의 테이블 생성 
-- 생성 순서 주의
-- 학생(stdTbl), 학생동아리(stdclubTbl), 동아리(clubTbl)

-- 01.데이터베이스 접속
USE sqlDB;


-- 02.테이블 생성 (학생(stdTbl), 학생동아리(stdclubTbl), 동아리(clubTbl))
-- 학생(stdTbl) 테이블 생성 - 이름, 지역 (1)
DROP TABLE IF EXISTS stdTbl;
CREATE TABLE stdTbl 
( stdName  VARCHAR(10) NOT NULL PRIMARY KEY,
  addr	  CHAR(4) NOT NULL
);

-- 동아리(clubTbl) 테이블 생성(2)
-- 동아리명(clubName)과 동아리방(roomNo) 
DROP TABLE IF EXISTS clubTbl;
CREATE TABLE clubTbl 
( clubName  VARCHAR(10) NOT NULL PRIMARY KEY,
  roomNo    CHAR(4) NOT NULL
);


-- 학생동아리(stdclubTbl) 테이블 생성 (3)
-- num(num):int 기본키 자동증감  
-- stdName(이름):VARCHAR(10), 
-- clubName(동아리명):VARCHAR(10) 
-- 외래키 2개 설정 
-- stdTbl(stdName), clubTbl(clubName)
-- FOREIGN KEY(컬럼명) REFERENCES 외부테이블명(컬럼명)

DROP TABLE IF EXISTS stdclubTbl;
CREATE TABLE stdclubTbl
(  num int AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 자동증감
   stdName    VARCHAR(10) NOT NULL,
   clubName    VARCHAR(10) NOT NULL,
FOREIGN KEY(stdName) REFERENCES stdTbl(stdName), -- 외래키1
FOREIGN KEY(clubName) REFERENCES clubTbl(clubName) -- 외래키2
);

DESC stdTbl;
DESC clubTbl;
DESC stdclubTbl;




-- 03.레코드 삽입
-- 한개씩 레코드 삽입
-- INSERT INTO 테이블명 VALUES (값1, 값2... );
-- INSERT INTO 테이블명 (컬럼명1, 컬러명2 ....) VALUES (값1, 값2... );

-- 여러개의 레코드 삽입
-- INSERT INTO 테이블명 VALUES (값1-1, 값1-2,...), (값2-1, 값2-2,...), (값3-1, 값3-2,...),...;

INSERT INTO stdTbl 
	VALUES 
	('김범수','경남'), 
    ('성시경','서울'), 
    ('조용필','경기'), 
	('은지원','경북'),
    ('바비킴','서울');
 
SELECT * FROM STDTBL; 


 
INSERT INTO clubTbl 
	VALUES 
		('수영','101호'), 
        ('바둑','102호'), 
		('축구','103호'), 
        ('봉사','104호');

SELECT * FROM clubtbl; 
    
    
    
INSERT INTO stdclubTbl 
	VALUES 
		(NULL,'김범수','바둑'), 
        (NULL,'김범수','축구'), 
        (NULL,'조용필','축구'), 
        (NULL,'은지원','축구'), 
        (NULL,'은지원','봉사'), 
        (NULL,'바비킴','봉사');

SELECT * FROM stdclubtbl;

SELECT count(*) FROM stdTbl; -- 5
SELECT count(*) FROM clubTbl; -- 4
SELECT count(*) FROM stdclubTbl; -- 6




-- 3개의 테이블 조인1
-- 학생을 기준으로 학생이름, 지역, 가입 동아리, 동아리방번호 출력 
-- 학생동아리(stdclubTbl) => 학생(stdTbl)  - 공통컬럼 : STDNAME
-- 학생동아리(stdclubTbl) => 동아리(clubTbl)  - 공통컬럼 : CLUBNAME

SELECT *
	FROM STDTBL S
    INNER JOIN stdclubtbl SC
		ON S.STDNAME = SC.STDNAME
	INNER JOIN clubtbl C
		ON SC.CLUBNAME = C.CLUBNAME;



-- 3개의 테이블 조인하기2
-- 학생이름, 지역, 가입 동아리, 동아리방번호

SELECT 
	S.STDNAME AS '학생이름',
    ADDR AS '지역',
    C.CLUBNAME AS '가입 동아리',
    ROOMNO AS '동아리 방번호'
	FROM STDTBL S
    INNER JOIN stdclubtbl SC
		ON S.STDNAME = SC.STDNAME
	INNER JOIN clubtbl C
		ON SC.CLUBNAME = C.CLUBNAME;


-- 동아리를 기준으로 가입 동아리, 동아리방번호 , 학생이름, 지역 출력 
SELECT 
	c.clubName AS '가입 동아리', 
    roomNo AS '동아리 방번호',
	s.stdName AS '학생이름', 
    addr AS '지역'
	FROM clubTbl c
    INNER JOIN stdclubTbl sc
		ON sc.clubName = c.clubName
    INNER JOIN stdTbl s
		ON s.stdName = sc.stdName
	ORDER BY c.clubName;






-- 외부조인 (OUTER JOIN)
-- 조인의 조건에 만족되지 않는 행까지도 포함시킨다. 

-- SELECT * 또는 컬럼명 
--    FROM 테이블1
--      <LEFT/RIGHT> OUTER JOIN 테이블2
--         ON 조인될조건:테이블1.컬럼명 = 테이블2.컬럼명 이용 
-- 		   	    (서로 공통된 관계의 컬럼이용)
--    [WHERE 조건절];


-- USERTBL + BUYTBL
-- LEFT OUTER JOIN
-- 구매기록이 없는 회원도 모두 출력
-- 왼쪽에 정의된 테이블 USERTBL의 레코드가 모두 표시되어야 한다. 
SELECT 	*
	FROM userTbl U 
	LEFT OUTER JOIN buyTbl B
			ON U.userID = B.userID;

-- 아우터조인의 레코드 총 개수는? (USERTBL기준)
SELECT 	count(*) -- 17 OUTER JOIN 이 더 큼.
	FROM userTbl U 
	LEFT OUTER JOIN buyTbl B
			ON U.userID = B.userID;

-- 이너조인의 레코드 총 개수는?
SELECT 	count(*)  -- 12
	FROM userTbl U 
	INNER JOIN buyTbl B
			ON U.userID = B.userID;


-- RIGHT OUTER JOIN
-- USERTBL + BUYTBL
SELECT 	* -- 구매경험이 없는 USER는 안나옴
	FROM userTbl U 
	RIGHT OUTER JOIN buyTbl B
			ON U.userID = B.userID;

SELECT 	count(*) -- 12 
	FROM userTbl U 
	RIGHT OUTER JOIN buyTbl B
			ON U.userID = B.userID;


-- RIGHT OUTER JOIN
-- BUYTBL + USERTBL
SELECT 	* -- USERTBL이 모두 나옴. 구매력 없는 사람도.
	FROM BUYTBL B 
	RIGHT OUTER JOIN userTbl U
			ON B.userID = U.userID;



-- 퀴즈
-- 구매경험이 없는 회원 목록만 표시하여라 
-- WHERE .. IS NULL 
-- USERTBL에 있고, BUYTBL에 없는 회원목록
-- 회원 아이디, 회원 이름만 표시

-- 방법1
SELECT 	
	U.USERID AS '회원 아이디',
	NAME AS '회원 이름'
	FROM userTbl U 
	LEFT OUTER JOIN buyTbl B
			ON U.userID = B.userID
	WHERE PRODNAME IS NULL;

-- 방법2
SELECT 	
	U.USERID AS '회원 아이디',
	NAME AS '회원 이름'
	FROM userTbl U 
	LEFT OUTER JOIN buyTbl B
			ON U.userID = B.userID
	WHERE NUM IS NULL;




/*퀴즈1
stdTbl, clubtbl, stdclubtbl 테이블에서 
학생을 기준으로 동아리 학생 목록을 LEFT OUTER JOIN을 이용하여 출력하여라. 
이때 동아리에 가입하지 않은 학생 목록도 출력한다.
*/
-- 내 풀이
SELECT *
	FROM stdtbl S
	LEFT OUTER JOIN stdclubtbl SC
		ON S.STDNAME = SC.stdName
	LEFT OUTER JOIN clubtbl C
		ON SC.clubName = C.clubName;
        
-- 모범 답안
SELECT 
    *
	FROM stdTbl S
		LEFT OUTER JOIN stdclubtbl SC
			ON S.stdName = SC.stdName
        LEFT OUTER JOIN clubtbl C
			ON SC.clubName = C.clubName 
	ORDER BY S.stdName;
    
SELECT 
    S.stdName AS '이름', S.addr AS '지역', C.clubName AS '동아리명', C.roomNo AS '동아리방'
	FROM stdTbl S
		LEFT OUTER JOIN stdclubtbl SC
			ON S.stdName = SC.stdName
        LEFT OUTER JOIN clubtbl C
			ON SC.clubName = C.clubName 
	ORDER BY S.stdName;


/*퀴즈2
stdTbl, clubtbl, stdclubtbl 테이블에서
-- 동아리에 가입하지 않은 학생 목록을 출력하여라 
*/
-- 내 풀이
SELECT *
	FROM stdtbl S
	LEFT OUTER JOIN stdclubtbl SC
		ON S.STDNAME = SC.stdName
	LEFT OUTER JOIN clubtbl C
		ON SC.clubName = C.clubName
	WHERE C.CLUBNAME IS NULL;

-- 모범 답안
SELECT 
    S.stdName AS '이름'
	FROM stdTbl S
		LEFT OUTER JOIN stdclubtbl SC
			ON S.stdName = SC.stdName
        LEFT OUTER JOIN clubtbl C
			ON SC.clubName = C.clubName 
	WHERE C.clubName IS NULL;

SELECT 
    S.stdName AS '이름'
	FROM stdTbl S
		LEFT OUTER JOIN stdclubtbl SC
			ON S.stdName = SC.stdName
        LEFT OUTER JOIN clubtbl C
			ON SC.clubName = C.clubName 
	WHERE roomNo IS NULL;


/*퀴즈3
stdTbl, clubtbl, stdclubtbl 테이블에서
-- 가입학생이 아무도 없는 동아리 목록을 출력하여라 
*/
-- 내 풀이
SELECT *
	FROM clubtbl C
	LEFT OUTER JOIN stdclubtbl SC
		ON C.clubName = SC.clubName
	LEFT OUTER JOIN stdtbl S
		ON SC.STDName = S.stdName
	WHERE SC.STDNAME IS NULL;

-- 모범답안
SELECT 
    *
	FROM stdTbl S
		RIGHT OUTER JOIN stdclubtbl SC
			ON S.stdName = SC.stdName
        RIGHT OUTER JOIN clubtbl C
			ON SC.clubName = C.clubName 
	ORDER BY S.stdName;
    
SELECT 
    C.clubName AS '동아리명'
	FROM stdTbl S
		RIGHT OUTER JOIN stdclubtbl SC
			ON S.stdName = SC.stdName
        RIGHT OUTER JOIN clubtbl C
			ON SC.clubName = C.clubName 
	WHERE S.stdName IS NULL;



-- LEFT OUTER JOIN + RIGHT OUTER JOIN
-- UNION 
-- 출력되는 컬럼명이 동일해야한다.
/*
LEFT OUTER JOIN 명령문
UNION
RIGHT OUTER JOIN 명령문
*/
-- UNION 결과값
-- 중복 레코드 허용 X
SELECT  -- 7
    *
	FROM stdTbl S
		LEFT OUTER JOIN stdclubtbl SC
			ON S.stdName = SC.stdName
        LEFT OUTER JOIN clubtbl C
			ON SC.clubName = C.clubName

UNION 

SELECT -- 7
    *
	FROM stdTbl S
		RIGHT OUTER JOIN stdclubtbl SC
			ON S.stdName = SC.stdName
        RIGHT OUTER JOIN clubtbl C
			ON SC.clubName = C.clubName;


-- UNION ALL 을 이용한 세로 합치기
-- 중복 레코드 허용
SELECT  -- 7
    *
	FROM stdTbl S
		LEFT OUTER JOIN stdclubtbl SC
			ON S.stdName = SC.stdName
        LEFT OUTER JOIN clubtbl C
			ON SC.clubName = C.clubName

UNION ALL 

SELECT -- 7
    *
	FROM stdTbl S
		RIGHT OUTER JOIN stdclubtbl SC
			ON S.stdName = SC.stdName
        RIGHT OUTER JOIN clubtbl C
			ON SC.clubName = C.clubName;



-- 회원이름, 지역, 동아리명, 동아리방만 출력
-- Error Code: 1222. The used SELECT statements have a different number of columns
SELECT  -- 7
    S.stdName AS '이름', S.addr AS '지역',  C.roomNo AS '동아리방',C.clubName AS '동아리명'
	FROM stdTbl S
		LEFT OUTER JOIN stdclubtbl SC
			ON S.stdName = SC.stdName
        LEFT OUTER JOIN clubtbl C
			ON SC.clubName = C.clubName

UNION ALL

SELECT -- 7
    S.stdName AS '이름', S.addr AS '지역', C.clubName AS '동아리방', C.roomNo AS '동아리명'
	FROM stdTbl S
		RIGHT OUTER JOIN stdclubtbl SC
			ON S.stdName = SC.stdName
        RIGHT OUTER JOIN clubtbl C
			ON SC.clubName = C.clubName;






-- 크로스 조인(상호조인)
-- 공통 컬럼이 없어도 된다. 
-- 모든행이 반복됨 
-- 한쪽 테이블의 모든 행과 다른쪽 테이블의 모든 행이 조인됨 => 카티션곱
-- SELECT * 또는 컬럼명
--    FROM 테이블1 
--      CROSS JOIN 테이블2;

-- buyTbl, userTbl 테이블에서 CROSS JOIN을 적용하여라. 
USE sqldb;

SELECT COUNT(*) FROM BUYTBL; -- 12
SELECT COUNT(*) FROM USERTBL; -- 10

SELECT * 
    FROM BUYTBL
      CROSS JOIN USERTBL;
      
SELECT COUNT(*) -- 120
    FROM BUYTBL
      CROSS JOIN USERTBL;




-- 셀프 조인(자체 조인) 
-- INNER JOIN의 일종. 같은 테이블을 조인한다. 
-- 조직도 등에 이용  
-- 같은 테이블에서 특정 컬럼값이 다른 컬럼값과 연결되어 있어야한다.  
-- 사원번호  사원이름  상관사원번호  상관전화번호


-- 테이블 생성 EMPTBL
-- 사원이름 상관이름 구내번호
DROP TABLE IF EXISTS empTbl;
CREATE TABLE empTbl 
	(emp CHAR(4), manager CHAR(4), empTel VARCHAR(8));

-- 레코드 삽입
INSERT INTO empTbl VALUES('나사장',NULL,'0000');
INSERT INTO empTbl VALUES('김재무','나사장','2222');
INSERT INTO empTbl VALUES('김부장','김재무','2222-1');
INSERT INTO empTbl VALUES('이부장','김재무','2222-2');
INSERT INTO empTbl VALUES('우대리','이부장','2222-2-1');
INSERT INTO empTbl VALUES('지사원','이부장','2222-2-2');
INSERT INTO empTbl VALUES('이영업','나사장','1111');
INSERT INTO empTbl VALUES('한과장','이영업','1111-1');
INSERT INTO empTbl VALUES('최정보','나사장','3333');
INSERT INTO empTbl VALUES('윤차장','최정보','3333-1');
INSERT INTO empTbl VALUES('이주임','윤차장','3333-1-1');

SELECT * FROM empTBL;
SELECT COUNT(*) FROM empTBL; -- 11





-- 직원의 상관의 구내번호를 찾아라 
-- 직원의 상관 이름을 알아낸다. 
-- 상관 이름을 직원 이름에서 찾는다.
-- 연락처를 찾는다.
-- 셀프조인
SELECT *
	FROM EMPTBL E1
    INNER JOIN EMPTBL E2
    ON E1.MANAGER = E2.EMP;
    
-- 직원(emp), 직원 구내번호(empTel), 상관(manager), 상관 구내번호(empTel) 컬럼만 출력
 SELECT 
	E1. EMP AS '직원', E1.EMPTEL AS '직원구내번호',
	E2. EMP AS '상관', E2.EMPTEL AS '상관구내번호'
	FROM EMPTBL E1
    INNER JOIN EMPTBL E2
    ON E1.MANAGER = E2.EMP;


-- 우대리 직원의 상관의 구내번호를 찾아라
SELECT 
	E1. EMP AS '직원', E1.EMPTEL AS '직원구내번호',
	E2. EMP AS '상관', E2.EMPTEL AS '상관구내번호'
	FROM EMPTBL E1
    INNER JOIN EMPTBL E2
    ON E1.MANAGER = E2.EMP
    WHERE E1.EMP = '우대리';

SELECT 
	e2.empTel AS '상관구내번호'
	FROM empTBL e1
    INNER JOIN empTBL e2
		ON e1.manager = e2.emp
	WHERE e1.emp = '우대리';





-- 뷰(View)란?
-- 테이블 자료의 일부만 보여주고자 할 때 사용하는 기능
-- 원본 데이터중에서 보는 사람에게 필요한 데이터만을 보여준다.
-- 장점
-- : 보안, 복잡한 쿼리의 단순화 등

-- 뷰의 생성
/*
DROP VIEW IF EXISTS 뷰이름;
CREATE VIEW 뷰이름
AS
	SELECT 구문
*/

SELECT * FROM BUYTBL;

SELECT NUM, USERID, PRODNAME FROM BUYTBL;

CREATE VIEW v_buyTbl
AS
	SELECT num, userId, prodName FROM buyTbl;


-- 뷰 호출
-- 테이블처럼 호출
-- 뷰를 테이블이라고 생각해도 무방
/*
SELECT * FROM 뷰이름;
*/
SELECT * FROM V_BUYTBL;

-- 뷰 구조 확인
-- DESC 뷰이름;
DESC V_BUYTBL;

-- 뷰 목록 확인
-- 워크벤치의 [Navigator] 창의 [SCHEMAS]의 해당 데이타베이스 목록에서 [Views] 에서 확인    
SHOW TABLES;





-- 조인 결과를 뷰로 만들 수 있을까? ㅇㅇ
-- USERTBL + BUYTBL => V_USER_BUY

SELECT 	u.userId, name, addr, prodName, price 
	FROM userTbl u 
    INNER JOIN buyTbl b 
    ON u.userId = b.userId;


CREATE VIEW V_USER_BUY
	AS    
SELECT 	u.userId, name, addr, prodName, price 
	FROM userTbl u 
    INNER JOIN buyTbl b 
    ON u.userId = b.userId;

SELECT * FROM V_USER_BUY;




-- 함수를 사용한 결과를 뷰로 만들 수 있을까? ㅇㅇ
-- BUYTBL => V_BUYTBL2

-- 뷰 삭제
DROP VIEW IF EXISTS V_BUYTBL2;

SELECT * FROM BUYTBL;

SELECT 
	NUM AS '번호',
    USERID AS '회원 아이디',
    PRODNAME AS '상품명',
	CONCAT(PRICE,'원') AS '가격'
    FROM BUYTBL;



CREATE VIEW V_BUYTBL2
AS
SELECT 
	NUM AS '번호',
    USERID AS '회원 아이디',
    PRODNAME AS '상품명',
	CONCAT(PRICE,'원') AS '가격'
    FROM BUYTBL;

SELECT * FROM V_BUYTBL2;

-- 뷰로 저장된 필드명만 이용 가능. 
SELECT * FROM V_BUYTBL2 WHERE 상품명 = '운동화';

-- 필드명에 공백이 있는 경우 
SELECT * FROM  v_buytbl2 WHERE '회원 아이디' = 'KBS'; -- X
SELECT * FROM  v_buytbl2 WHERE "회원 아이디" = 'KBS'; -- X

-- 그레이브 ` 기호를 사용 `필드명`
SELECT * FROM  v_buytbl2 WHERE `회원 아이디` = 'KBS';  

-- SELECT * FROM V_BUYTBL2 WHERE PRODNAME = '운동화'; -- 뷰에서는 오류남~
-- Error Code: 1054. Unknown column 'PRODNAME' in 'where clause'


-- 뷰를 이용해서 레코드 삽입이 가능할까? ㅇㅇ

-- 예제를 위한 테이블 복제
-- STDTBL => STDTBL2
SELECT * FROM STDTBL;
CREATE TABLE STDTBL2
	(SELECT * FROM STDTBL);
SELECT * FROM STDTBL2;
DESC STDTBL2;


-- 뷰 생성
CREATE VIEW V_STDTBL2
AS 
SELECT * FROM STDTBL2;
SELECT * FROM v_stdTbl2;

-- 뷰를 이용한 레코드 삽입 명령 
-- INSERT INTO 뷰이름 (컬럼명1, 컬럼명2 ... ) VALUES (값1, 값2 ... );
-- INSERT INTO 뷰이름 VALUES (값1, 값2 ... );
-- INSERT INTO 뷰이름 (컬럼명1, 컬럼명2 ... ) VALUES (값1, 값2 ... ), (값1, 값2 ... ),(값1, 값2 ... ),...;

INSERT INTO v_stdTbl2 VALUES ('김자두','안양');
INSERT INTO v_stdTbl2 VALUES ('고길동','인천');

SELECT * FROM v_stdTbl2; -- 뷰 확인
SELECT * FROM STDTBL2; -- 원본 확인



-- 뷰안에 데이터 수정
-- 주의 사항 : 뷰에서 등록한 컬럼의 데이터만 수정 가능
/*
UPDATE 뷰이름 SET 컬럼명=값 WHERE 절
*/

-- 지역만 등록
CREATE VIEW V_STDTBL3
AS 
SELECT ADDR FROM STDTBL2;

SELECT * FROM v_stdTbl3;

UPDATE V_STDTBL3 SET ADDR='경상남도' WHERE ADDR ='경남';

SELECT * FROM v_stdTbl3; -- 뷰 확인
SELECT * FROM STDTBL2; -- 원본 확인

-- 뷰에 등록되지 않은 컬럼은 수정할 수 없다.
-- Error Code: 1054. Unknown column 'STDNAME' in 'where clause'
UPDATE V_STDTBL3 SET STDNAME='성발라' WHERE STDNAME ='성시경';


-- 뷰를 이용한 데이타 삭제
/*
DELETE FROM 뷰이름 WHERE 절
*/
SELECT * FROM v_stdTbl3; 
DELETE FROM v_stdTbl3 WHERE addr='서울';
SELECT * FROM v_stdTbl3; 
SELECT * FROM stdTbl2;


-- 조인으로 등록한 뷰에서 레코드 삽입/수정/삭제가 가능할까? 되는것도 있, 안되는것도 있
-- USERTBL + BUYTBL => V_USER_BUY

CREATE TABLE USERTBL_AA
	(SELECT * FROM USERTBL);
CREATE TABLE BUYTBL_AA
	(SELECT * FROM BUYTBL);

CREATE VIEW V_USER_BUY2
AS
SELECT U.USERID, NAME, PRODNAME, PRICE, AMOUNT
	FROM USERTBL_AA U
    INNER JOIN BUYTBL_AA B
    ON U.USERID = B.USERID;
    
SELECT * FROM v_user_buy2;
   
UPDATE V_USER_BUY2 SET PRODNAME='BOOK' WHERE PRODNAME ='책';   -- 수정    
SELECT * FROM v_user_buy2;    -- 수정확인
SELECT * FROM BUYTBL_AA;

-- Error Code: 1395. Can not delete from join view 'sqldb.v_user_buy2'
-- DELETE FROM v_user_buy2 WHERE name='김범수';
-- INSERT INTO v_user_buy2 VALUES ('YYW', '임영웅', '청소기', 5000, 5);

-- name 변경 O
UPDATE v_user_buy2 SET name='최범수' WHERE name='김범수';
SELECT * FROM userTbl_aa; 

-- 뷰로 등록한 컬럼만 변경 가능 
UPDATE v_user_buy2 SET userId='JJJ' WHERE userId='JYP';
SELECT * FROM userTbl_aa; -- 변경 O
SELECT * FROM buyTbl_aa; -- 변경 X




-- 데이터베이스 생성/삭제
-- 레코드 삽입/수정/삭제
-- 테이블 생성/삭제

-- 테이블 구조 변경
-- 컬럼 추가 / 컬럼 삭제 / 컬럼 구조 변경
-- ALTER TABLE

-- 회원테이블
CREATE TABLE userTbl_bb 
( userID  	CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  name    	VARCHAR(10) NOT NULL, -- 이름
  addr	  	CHAR(2)  -- 지역(경기,서울,경남 식으로 2글자만입력)
);

DESC USERTBL_BB;

-- 레코드 삽입
INSERT INTO USERTBL_BB VALUE ('KKD', '고길동', '부산');
INSERT INTO USERTBL_BB VALUE ('HGD', '홍길동', '서울');

SELECT * FROM USERTBL_BB;


-- 기존 테이블에서 새로운 컬럼 추가 

-- ALTER TABLE 테이블명
-- 	ADD 컬럼명 데이터형( CHAR(), INT, VARCHAR(), DATE, DATETIME ... )
-- 		[DEFAULT 디폴트값] -- 기본값 설정 
-- 		[NULL/NOT NULL]; -- Null 허용함

-- AGE 컬럼 추가 (NULL 허용, 정수형)
ALTER TABLE usertbl_bb
	ADD AGE INT(3) NULL; -- NULL은 생략가능

DESC USERTBL_BB;
SELECT * FROM usertbl_bb;


-- EMAIL 컬럼 추가 (초기값 지정, 문자형)
ALTER TABLE usertbl_bb
	ADD EMAIL VARCHAR(30) DEFAULT 'ABC@naver.com'; -- NULL은 생략가능

DESC USERTBL_BB;
SELECT * FROM usertbl_bb;

INSERT INTO usertbl_bb VALUE ('PDG', '박길동','안양' ,' 34','PDG@GMAIL.COM');
SELECT * FROM USERTBL_BB;

INSERT INTO usertbl_bb VALUE ('KDG', '김길동','안양' ,' 34',NULL);
SELECT * FROM USERTBL_BB;

INSERT INTO usertbl_bb (USERID, NAME, ADDR) VALUE ('CDG', '최길동','제주');
SELECT * FROM USERTBL_BB;



-- 기존 칼럼 삭제 1 - 키가 없는 경우
-- ALTER TABLE 테이블명
-- 	DROP COLUMN 컬럼명;
ALTER TABLE usertbl_bb
 	DROP COLUMN AGE;
SELECT * FROM USERTBL_BB; -- 놓침,,



-- 기존 컬럼 삭제 2 - 키가 있는 경우 
-- 주의사항 : 외래키 -> 기본키 순으로 먼저 삭제한 후 컬럼 삭제 진행 

-- 기본키 삭제 
-- ALTER TABLE 테이블명
-- DROP PRIMARY KEY 또는 FOREIGN KEY 제약조건; 
-- 제약조건은 Navigator 패널의 관련 테이블의 FOREIGN KEYs 에서 확인

ALTER TABLE usertbl_bb
 	DROP PRIMARY KEY;
DESC USERTBL_BB;


INSERT INTO userTbl_bb VALUE ('HGD', '홍길동', '서울');
SELECT * FROM userTbl_bb;



-- 컬럼 수정 
-- 컬럼명1을 컬럼명2로 수정 
-- ALTER TABLE 테이블명 
-- 	CHANGE COLUMN 컬럼명1 컬럼명2 데이타형 [NULL 또는 NOT NULL] ;
DESC USERTBL_BB;

-- NAME 컬럼 => USERNAME VARCHAR(5) NULL
ALTER TABLE usertbl_bb
	CHANGE COLUMN NAME USERNAME VARCHAR(5) NULL;
DESC USERTBL_BB;

-- USERID 컬럼 => USERID CHAR(2) NULL - 컬럼 안의 삽입된 데이터의 자릿수가 기존의 데이터보다 작으면 오류남
ALTER TABLE usertbl_bb
	CHANGE COLUMN userId userId char(2);

-- USERID 컬럼 => USERID CHAR(4) NULL -ㅇㅇ 컬럼안에 삽입된 데이터의 길이보다 큰 자료형으로만 변경 가능. 
ALTER TABLE usertbl_bb
	CHANGE COLUMN userId userId char(4);
DESC USERTBL_BB;




-- 기본키 추가하기 
--  ALTER TABLE 테이블명
-- 	ADD CONSTRAINT PK_테이블명_기본키필드명
--  PRIMARY KEY (기본키필드명);

-- 테이블 복사시 기본키, 외래키 복사되지 않는다. 
CREATE TABLE 
	userTbl_cc    
    (SELECT * FROM userTbl);
    
SELECT * FROM userTbl_cc;
DESC  userTbl; -- 프라이머리 키 ㅇ
DESC  userTbl_cc; -- 프라이머리 키 X




-- 기본키 추가하기 
--  ALTER TABLE 테이블명
-- 	ADD CONSTRAINT PK_테이블명_기본키필드명
--  PRIMARY KEY (기본키필드명);

-- 기본키는 Key에 PRI로 표시  
ALTER TABLE userTbl_cc
	ADD CONSTRAINT PK_userTbl_cc_userID
PRIMARY KEY (userID);
DESC userTbl_cc;






-- 테이블 구조 변경 퀴즈 
-- 0) employees 데이타베이스 접속 
USE EMPLOYEES;

-- 1) employees 테이블에서 10개의 레코드를 복사하여 새로운 테이블 생성 
-- emp_no, first_name, last_name, gender
CREATE TABLE EMPTB
	(SELECT EMP_NO, FIRST_NAME, LAST_NAME, GENDER FROM EMPLOYEES LIMIT 10);
SELECT * FROM EMPTB;

-- 2) 새로운 컬럼 추가 
ALTER TABLE EMPTB
	ADD ADDR CHAR(5) NOT NULL; -- NULL은 생략가능
DESC EMPTB;
SELECT * FROM EMPTB;

-- 3) 기존 컬럼 삭제 
--     gender 
ALTER TABLE EMPTB
 	DROP COLUMN GENDER;
SELECT * FROM EMPTB;

-- 4) 컬럼 수정 
-- last_name => family_name 으로 컬럼명 수정 
ALTER TABLE EMPTB
	CHANGE COLUMN LAST_NAME FAMILY_NAME VARCHAR(16) NOT NULL;
DESC EMPTB;

-- 5) emp_no 컬럼을 PRIMARY KEY 로 설정
ALTER TABLE EMPTB
	ADD CONSTRAINT PK_EMPTB_EMP_NO
PRIMARY KEY (EMP_NO);
DESC EMPTB;
















/*
1번
create table employees_1
	(select emp_no, first_name, last_name, gender from employees limit 10);
desc employees_1;
select * from employees_1;
2번
alter table employees_1
	add age int
    default 0;
3번
alter table employees_1
	drop column gender;
4번
alter table employees_1
	change column last_name family_name varchar(16) not null;
5번
alter table employees_1
	add constraint pk_employees_1_emp_no
    primary key(emp_no);
desc employees_1;
*/






