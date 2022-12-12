# MYSQL 테이블 => 데이타프레임 => csv 파일

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
                             database='world')

# 커서 생성
cursor = conn.cursor()
print(cursor)

# 3) mySQL 테이블 => 데이타프레임
# sql명령어 = 'SELECT 절'
# 데이타프레임변수 = pd.read_sql(sql명령어, 데이타베이스커넥션정보)

sql = 'SELECT * FROM city LIMIT 50;'
df_city = pd.read_sql(sql, conn)
print(df_city.shape)
print('='*50)
print(df_city.tail())


# 4) DB 종료
conn.close()
