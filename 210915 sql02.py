# MYSQL 테이블 생성
# 파이썬 데이터 => MYSQL 테이블 데이터

# 0) 테이블 생성 - 워크벤치 이용
'''
-- testdb1 접속
-- bookTbl 테이블 생성
-- id, title, writer, page, price
USE testdb1;
CREATE TABLE bookTbl (
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title TEXT NOT NULL,
    writer VARCHAR(20) NOT NULL,
    page INTEGER NOT NULL,
    price INTEGER  NOT NULL
);
'''



# 1) 관련 모듈 임포트

# 관련 모듈 임포트
import pymysql
from sqlalchemy import create_engine
import pandas as pd
import os

# 2) mySQL 관련 정보 => pymysql를 이용하여 접속
# 데이터베이스 접속
conn = pymysql.connect(host='localhost',
                             user='root',
                             password='1234',
                             database='sampleDb'

                             )

# 커서 생성
cursor = conn.cursor()
print(cursor)


# 3) 레코드 삽입
# sql 레코드 삽입 명령어 지정
# INSERT INTO 테이블명 (필드명1, 필드명2,...)
#                   VALUE (%S, %S,...);
# cursor.ececute(sql명령, (값1, 값2,...))
# 데이터베이스 반영
# conn.commit()

sql = '''INSERT INTO bookTbl (title, writer, page, price)
            VALUES (%s, %s, %s, %s);'''


# cursor.execute(sql, ('파이썬 완전정복', '정보문화사', 300, 25000))
cursor.execute(sql, ('어린왕자', '문학동네', 200, 15000))
cursor.execute(sql, ('이것이 MYSQL ', '한빛출판사', 500, 35000))
cursor.execute(sql, ('딥러닝 마스터', '정보문화사', 700, 37000))
cursor.execute(sql, ('코딩 테스트', '위키북스', 500, 40000))

conn.commit()



# 4) 레코드 삽입되었는지 확인
# 워크 벤치에서 확인
# SELECT * FROM bookTbl;


# 5) DB 종료
conn.close()








