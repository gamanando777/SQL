# csv 파일 => 데이타프레임 => MYSQL 테이블
# 판다스의 to_sql() 함수 이용
# to_sql(테이블명, con=엔진.... )

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


# 3) csv => 데이타프레임
# data/book_bestseller.csv
df_bookBest = pd.read_csv('data/book_bestseller.csv')
# 데이타프레임 전체 갯수 확인
print(df_bookBest.shape) # (10, 5)
print(df_bookBest)
print(df_bookBest.columns) # Index(['rank', 'title', 'writer', 'poster', 'url'], dtype='object')
print(df_bookBest.loc[0])




# 4) 데이타프레임 => mySQL
# url = 'mysql+pymysql://아이디:패스워드@localhost:3306/데이타베이스명'
url = 'mysql+pymysql://root:1234@localhost:3306/sampleDb'
engine = create_engine(url)
print(engine) # Engine(mysql+pymysql://root:***@localhost:3306/sampleDb)

df_bookBest.to_sql(name='bookBest', con=engine, if_exists='append', index=True)



# 5) 테이블과 레코드 확인
# 워크 벤치에서 확인
# SELECT * FROM bookBest;



# 6) DB 종료
conn.close()
