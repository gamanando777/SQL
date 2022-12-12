
# csv 파일 => 데이타프레임 => MYSQL 테이블

# 1) 관련 모듈 임포트
import pymysql
from sqlalchemy import create_engine
import pandas as pd
import os

# 2) mySQL 관련 정보 => pymysql를 이용하여 MYSQL 접속 후 커서 생성
# sampleDb 데이타베이스 접속
conn = pymysql.connect(host='localhost',
                             user='root',
                             password='1234',
                             database='sampleDb')

# 커서 생성
cursor = conn.cursor()
print(cursor)

# 3) csv => 데이타프레임
# data/population.csv
df_pop = pd.read_csv('data/population.csv')
# 데이타프레임 전체 갯수 확인
print(df_pop.shape) # (51, 2)
# 컬럼명 확인
print(df_pop.columns) # Index(['State', 'Population'], dtype='object')
print(df_pop.head())



# 4) 테이블 생성 : 워크벤치 이용
# -- sampleDb 접속
# -- population 테이블 생성
# -- ID, State, Population
# USE sampleDb;
# CREATE TABLE population (
# 	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
#     state VARCHAR(30) NOT NULL,
#     population VARCHAR(20) NOT NULL
# );


# 5) 데이터프레임 모든 행 = population 테이블

# ???
# print(df_pop.iterrows())
# for index, row in df_pop.iterrows():
#     print(index, row.state, row.Population)

# 레코드 삽입 sql
sql = '''INSERT INTO population (state, population )
            VALUES (%s, %s);'''

for index, row in df_pop.iterrows():
    cursor.execute(sql, (row.State, row.Population))

conn.commit()

# 6) 레코드 삽입되었는지 확인
# 워크 벤치에서 확인
# SELECT * FROM population;

# 7) DB 종료
conn.close()
