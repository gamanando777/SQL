-- 파이썬과 연동할 데이터베이스 생성 
CREATE DATABASE sampleDb;
show DATABASES;

-- world 데이터 베이스
SELECT * FROM city LIMIT 30;


-- sampleDb 접속
-- bookTbl 테이블 생성
-- id, title, writer, page, price
USE sampleDb;
CREATE TABLE bookTbl (
	id INTEGER not null PRIMARY KEY AUTO_INCREMENT,
    title TEXT NOT NULL,
    writer VARCHAR(20) NOT NULL,
    page INTEGER NOT NULL,
    price INTEGER NOT NULL
);

show TABLES;
select * from bookTbl;

USE sampleDb;
CREATE TABLE population (
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    state VARCHAR(30) NOT NULL,
    population VARCHAR(20) NOT NULL);

show tables;





