# 파이썬 + MySQL 연동
# 관련 모듈 : pymysql, sqlalchemy (install 과정 필요)
# 작업과정
# 1) 관련 모듈 임포트
# 2) mySQL 관련 정보 => pymysql를 이용하여 접속
# 3) sql 명령 => pymysql 함수를 이용
# 4) 실행 결과 => 튜플, 리스트, 딕셔너리 리스트
# 5) mySQL 종료

# https://pypi.org/project/PyMySQL/
# https://www.sqlalchemy.org/

# 설치
# 터미널창 이용하거나 [File]-[Settings] 이용
# pip install PyMySQL
# pip install sqlalchemy


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
                             database='world')

# 커서 생성
cursor = conn.cursor()
print(cursor)
# <pymysql.cursors.Cursor object at 0x0000026E5ECC80D0>

# 4) DB에 접속해서 특정 테이블의 데이터 => 파이썬 자료구조로 저장
# Read
# sql명령 = 'SELECT 명령어'
# cursor.excute(sql명령)
# cursor.fetchall()
# cursor.fetchone()
# cursor.fetchmany(갯수)

# city 테이블의 레코드 30개
sql = 'SELECT * FROM city LIMIT 30;'
cursor.execute(sql)
city = cursor.fetchall()
print(type(city))  # <class 'tuple'>
print(city)

print('='*50)

# city 테이블의 첫번째 레코드 => 1차원 튜플
sql = 'SELECT * FROM city LIMIT 30;'
cursor.execute(sql)
city2 = cursor.fetchone()
print(type(city2))
print(city2)

print('='*50)
# city 테이블의 첫번째 레코드 => 1차원 튜플
sql = 'SELECT * FROM city LIMIT 30;'
cursor.execute(sql)
city3 = cursor.fetchmany(3)
print(type(city3))
print(city3)

# 데이터 베이스 종료
conn.close()

# 6) 판다스의 데이터프레임 구조로 변경
# 튜플에서 각 레코드 출력
print('='*50)
for row in city:
    print(row)

df_city = pd.DataFrame(city,columns=['ID', 'Name','CountryCode','District','Population'])
print(df_city.head())

# 7) csv로 저장
df_city.to_csv('output/city.csv', index=False)

# MYSQL 테이블 => 2차원 튜플 => 데이터프레임 => csv 파일

#




