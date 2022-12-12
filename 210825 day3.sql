-- -- 문자열 함수 
-- CONCAT(EXP...) : 문자열을 함께 출력할 때 사용 
-- CONCAT_WS(구분자, 문자열1, 문자열2 ...) : 문자열을 구분자와 함께 표시
-- 문자열1 + 문자열2 = 문자열1문자열2 (X) SQL에서 지원 X

-- CONCAT(문자열/컬럼/수식/정수...,)
-- CONCAT_WS(구분자, 문자열1, 문자열2 ...)

-- 문자열 변수 정의
set @userName1 = '홍길동';
set @userName2 = '성춘향';

-- 각각의 컬럼에 출력
SELECT @userName1, @userName2;

-- 하나의 컬럼에 출력
select concat(@userName1, '님 안녕하세요', @userName2,'님도 안녕하세요') AS '결과';


-- 하나의 컬럼에 출력 + 구분자
select concat_ws('/', @userName1, @userName2,'뽀빠이') AS '결과';

-- 테이블에 적용
use sqldb;
SELECT * FROM buytbl;

-- CONCAT()이용해서 하나의 컬럼에 2개의 컬럼값 표시 
select userid, concat(prodname, '-', groupname) AS '상품명-종목' From buytbl;

SELECT 
	userId, concat_ws(' / ', prodName, groupName) AS '상품명-종목' 
    FROM buytbl;



/* 숫자 데이타 컬럼에 적용 */
-- 단가  X  수량 = 구매금액  

DESC buytbl;
-- 숫자데이터 => 문자열
SELECT 
	userId, concat(price,' X ', amount, '=', (price*amount)) AS '단가  X  수량' 
    FROM buytbl;



/* 퀴즈 - CONCAT() 활용 
 usertbl 테이블에서 키가 175 넘는 레코드만 추출한 후 아래와 같은 형태로 출력하여라.  
           이름       키   
 가수이름 => 김경호   ?  cm
 가수이름 => 이승기   ?  cm
 */

select '가수이름 => 'as ' ', name AS '이름', concat(height, 'cm') AS '키' from usertbl;

-- 답
SELECT 
	concat('가수이름 => ', name) AS ' 이름 ' ,
    concat(height, ' cm') AS ' 키 '
    FROM usertbl
    WHERE height>175
    ORDER BY height DESC;




-- 소숫점 자리 표시         
-- FORMAT(숫자, 소숫점 자릿수)

-- 소숫점 자리 표시         
-- FORMAT(숫자/변수/수식/컬럼명, 소숫점 자릿수)      
SET @n = 123.56789;
SELECT @n, format(@n, 1), format(@n, 3);

-- 자동 반올림   
SET @n = 123.56789;
SELECT @n, format(@n, 1), format(@n, 3);



-- 특정 글자로 교체하기 
-- 인덱스란? 각글자의 위치값 
-- 다른언어는 보통 0부터 시작, SQL은 1부터 시작 
-- INSERT(문자열/변수/컬럼, 시작위치, 길이, 교체문자열)
-- REPLACE(문자열/변수/컬럼, 원래문자열, 교체문자열)

SET @userMobile = '010-5555-6666';
SELECT @userMobile, insert(@userMobile, 5, 4, '****'); -- 010-****-6666
SELECT @userMobile, insert(@userMobile, 10, 4, '****'); -- 010-****-6666
SELECT @userMobile, insert(@userMobile, 5, 9, '****-****'); -- 010-****-****
select @userMobile, replace(@userMobile, '5', '*');




-- 특정 부분만 표시하기 
-- LEFT(문자열, 길이), RIGHT(문자열, 길이) : 왼쪽이나 오른쪽을 기준으로 길이만큼 잘라서 표시 
-- SUBSTRING(문자열, 시작위치, 길이) : 시작위치에서 길이만큼 잘라서 표시한다.
set @userMobile = '010-1234-5678';
SELECT
	@USERmOBILE,
     left(@userMobile,3), 
    right(@userMobile,4), 
    substring(@userMobile,5,4);




-- 특정 문자로 채우기
-- LPAD(문자열, 길이, 채울문자열), RPAD(문자열, 길이, 채울문자열)
--  : 왼쪽이나 오른쪽에 길이만큼 늘려 문자열을 채운다.
-- REPEAT(문자열, 반복횟수) : 문자열을 횟수만큼 반복한다.

set @username = '홍길동';
SELECT 
	@username,
    lpad(@username,5,'*'), -- **홍길동
    rpad(@username,5,'*'), -- 홍길동**
    repeat('*',5); -- 5번 반복




-- 문자열 공백 없애기 
-- LTRIM(문자열), RTRIM(문자열), TRIM(문자열)
set @txt = '        안녕하세요       ';
select
	@txt,
    ltrim(@txt),
    rtrim(@txt),
    trim(@txt);



-- concat() 과 함께 사용 
SELECT 
	concat('$$$',@txt,'$$$'), -- $$$     안녕하세요    $$$ 
    concat('$$$',ltrim(@txt),'$$$'), -- $$$안녕하세요     $$$
    concat('$$$',rtrim(@txt),'$$$'), -- $$$     안녕하세요$$$
    concat('$$$',trim(@txt),'$$$');  -- $$$안녕하세요$$$



/* usertbl 테이블에서 name 필드값을 다음과 같이 표시하여라 
     홍**
*/
SELECT * from usertbl;
select userid, 
	insert(name,2,2,'**') AS 'user name' 
    from usertbl;

-- LEFT(문자열/변수/컬럼, 길이)
SELECT 
	userid, 
    concat(left(name,1), '**') AS 'user name'
	FROM usertbl;



/* usertbl 테이블에서 name 필드값이 조로 시작하는 문자열을 다음과 같이 출력하여라 
   (2가지 방식으로 풀어보세요) 
     조관우 회원님
     조용필 회원님
*/

select name from usertbl where name like '조%';

select concat(name, ' 회원님') as '회원 이름' from usertbl where name like '조%';

-- RPAD(문자열/변수/컬럼, 길이, 채울문자열)
SELECT RPAD(name, 8, ' 회원님') AS '회원 이름' 
		FROM usertbl WHERE name like '조%';



/* usertbl3 테이블에서 name 필드값이 조로 시작하는 문자열을 다음과 같이 변경하여라 
   usertbl3 테이블이 없다면 usertbl 테이블을 이용하여 새로 생성한다. 
   (2가지 방식으로 풀어보세요) 
     조관우 회원님
     조용필 회원님
*/

-- usertbl 테이블 복사 => usertbl3 테이블 생성 
CREATE TABLE IF NOT EXISTS usertbl3
		(SELECT * FROM usertbl);
SHOW TABLES;
select * from usertbl3;

select * from usertbl3 WHERE name like "조%";

-- 데이터값 변경1
update
	usertbl3 
    set name=rpad(name,8," 회원님")
    WHERE name like "조%";
 
 SELECT * FROM usertbl3 WHERE name LIKE "조%";

-- 데이터값 변경2
update
	usertbl3 
    set name=concat(name, ' 회원님')
    WHERE name like "조%";
 
 SELECT * FROM usertbl3 WHERE name LIKE "조%";
 
 
 
 
 
 -- 현재 시간과 날짜 출력 
-- NOW() : 내장함수로 현재의 날짜와 시간을 표시 
-- SYSDATE() : 내장함수로 현재의 날짜와 시간을 표시 
-- CURDATE() : 현재 날짜 표시 
-- CURTIME() : 현재 시간 표시

 SELECT
	now(), -- 2021-08-25 11:29:19
    sysdate(), -- 2021-08-25 11:29:19
    curdate(), -- 2021-08-25
    curtime(); -- 11:29:19




-- 날짜 데이타의 일부분 활용 
-- LEFT(문자열/변수/컬럼, 길이), RIGHT(문자열/변수/컬럼, 길이) 
-- SUBSTRING(문자열/변수/컬럼, 시작위치, 길이)
SELECT
	now(),
    left(now(), 4) AS '년도', 
    substring(now(), 6, 2) AS '월', 
    right(curdate(), 2) AS '일' ;

SELECT 
	concat(
			left(now(), 4), '년 ', 
            substring(now(), 6, 2), ' 월',  
            right(curdate(), 2), ' 일') AS '오늘은?';





-- 날짜와 시간 데이타에서 일부분을 추출하는 함수
-- YEAR(날짜), MONTH(날짜), DAY(날짜), DAYOFMONTH(날짜), DATE(날짜)  
-- HOUR(시간), MINUTE(시간), SECOND(시간), TIME(시간)
-- DAYOFWEEK(날짜) : 요일표시 1~7(일요일~토요일)
-- MONTHNAME(날짜) : 달을 영문으로 표시 
-- DAYOFYEAR(날짜) : 1년중 몇번째 날인지 표시

SELECT 
	now(),
    year(now());

SELECT 
	now(), 
    hour(now()), 
    minute(now());
    
SELECT 
	now(), 
    dayofweek(now()), -- 4
    monthname(now()), -- August
    dayofyear(now()); -- 237



/* 퀴즈 :  CASE 함수를 이용하여 요일 표시하기 

예시) 2021년 8월 25일 수요일 

*/    
-- 다중분기 
-- CASE 변수/컬럼명/값1/수식 
--     WHEN 값2 THEN 결과값1 
--     WHEN 값3 THEN 결과값2
--     ELSE 결과값n 
--     END;

set @today = dayofweek(now());
SELECT 
	concat(
		year(now()), ' 년  ',
		month(now()), ' 월  ',
		day(now()), ' 일  ',
		CASE @today
			WHEN 1 THEN "일요일"
			WHEN 2 THEN "월요일"
			WHEN 3 THEN "화요일"
			WHEN 4 THEN "수요일"
			WHEN 5 THEN "목요일"
			WHEN 6 THEN "금요일"
			ELSE "토요일"
			END
        ) 
        AS "결과 ";






-- 날짜 연산 함수 
-- DATEDIFF(날짜1, 날짜2) : 날짜1 - 날짜 2
-- TIMEDIFF(시간1, 시간2) : 시간1- 시간2

SELECT now(), datediff('2021-01-01', now()); -- -236
-- 올해 며칠이 지났는가?
SELECT now(), datediff(now(),'2021-01-01'), dayofyear(now())-1; -- 236
SELECT now(), datediff(now(),'2021-12-31'),  dayofyear(now()); -- 237



/* 수료일은 얼마나 남았을까요? 2022년 1월 25일 기준 */
select datediff('2022-01-25', now()) AS '수료일은 얼마남았을까요?';

-- 오늘 하루는 얼마나 남았?
SELECT curtime(), timediff('23:59:59', curtime());





-- 조인이란? 
-- 두개이상의 테이블을 서로 묶어서 관리하는 기능 

-- 조인의 종류 
-- 내부 조인 = inner join 
-- 외부 조인 = outer join 
-- 크로스 조인 = cross join 
-- 셀프 조인 = self join




USE sqldb;
-- usertbl(userId) = buytbl(userId)
DESC usertbl; -- 회원 정보
DESC buytbl; -- 구매 정보


-- INNER JOIN 1 --
-- SELECT * 또는 컬럼명 
--    FROM 테이블1
--      INNER JOIN 테이블2
--         ON 조인될조건:테이블1.컬럼명 = 테이블2.컬럼명 이용 
--				(서로 공통된 관계의 컬럼이용)
--    [WHERE 조건절];



-- usertbl + buytbl 이너조인
-- userid 공통 컬럼

select * 
	from usertbl
    inner join buytbl
    on usertbl.userid = buytbl.userid;
    

-- 명확하게 컬럼명 표시하기
-- 테이블명.컬럼명으로 나열
-- usertbl + buytbl 이너조인
-- userid, name, prodname, price 컬럼만 표시

/*
- Error Code: 1052. Column 'userId' in field list is ambiguous
SELECT userId, name, prodName, price
	FROM usertbl
    INNER JOIN buytbl
    ON usertbl.userId = buytbl.userId;
*/

SELECT usertbl.userId, usertbl.name, buytbl.prodName, buytbl.price
	FROM usertbl
    INNER JOIN buytbl
    ON usertbl.userId = buytbl.userId;

-- 공통 컬럼인 경우에는 테이블명.컬럼명 꼭 명시 
SELECT usertbl.userId, name, prodName, price
	FROM usertbl
    INNER JOIN buytbl
    ON usertbl.userId = buytbl.userId;

-- where 절 추가
SELECT usertbl.userId, name, prodName, price
	FROM usertbl
    INNER JOIN buytbl
    ON usertbl.userId = buytbl.userId
    where price <100;




-- INNER JOIN 2 
-- 테이블명에 별칭 지정하기  
-- SELECT * 또는 별칭.컬럼명 
--    FROM 테이블1 테이블별칭1
--      INNER JOIN 테이블2 테이블별칭2
--         ON 조인될조건-별칭1.컬럼명 = 별칭2.컬럼명 이용 
--				(서로 공통된 관계의 컬럼이용)
--    [WHERE 조건절];


-- 별칭이용
SELECT u.userId, name, prodName, price
	FROM usertbl u
    INNER JOIN buytbl b 
    ON u.userId = b.userId;

SELECT 
	u.userId AS '아이디', name AS '이름', -- 컬럼 별칭 
    prodName, price
	FROM usertbl u -- 테이블 별칭
    INNER JOIN buytbl b -- 테이블 별칭
    ON u.userId = b.userId;


-- 구매 경험이 있는 레코드만 출력 : 이너조인
-- 구매 경험이 없는 레코드는 표시되지 않는다. => 아우터조인으로 해결

select * from usertbl; -- 10
select * from buytbl; -- 12

SELECT -- 12 (조인결과) 
	count(*)
	FROM usertbl u -- 테이블 별칭
    INNER JOIN buytbl b -- 테이블 별칭
    ON u.userId = b.userId;

SELECT 
	*
	FROM usertbl u -- 테이블 별칭
    INNER JOIN buytbl b -- 테이블 별칭
    ON u.userId = b.userId
    ORDER BY u.userid;


