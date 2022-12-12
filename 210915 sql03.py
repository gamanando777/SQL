# 레코드 수정 / 삭제
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


# 3-1) 레코드 수정
# sql 레코드 수정 명령어 지정
# UPDATE 테이블명 SET 필드명1=%S WHERE 필드명2%S

# cursor.ececute(sql명령, (값1, 값2,...))
# 데이터베이스 반영
# conn.commit()
''' 레코드 수정
sql = 'UPDATE bookTbl SET price = %s WHERE title = %s'
cursor.execute(sql,(10000,'어린왕자'))

conn.commit()
'''
# 3-2) 레코드 삭제
# sql 레코드 삭제 명령어 지정
# DELETE FROM 테이블명 WHERE 필드명=%s

# cursor.execute(sql명령, (값,))

# 데이타베이스 반영
# conn.commit()

sql = 'DELETE FROM bookTbl WHERE id = %s'
cursor.execute(sql, (1,))
conn.commit()




# 4) 레코드 수정 및 삭제 되었는지 확인
# 워크 벤치에서 확인
# SELECT * FROM bookTbl;


# 5) DB 종료
conn.close()









