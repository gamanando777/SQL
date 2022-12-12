# csv => sql
# 워크벤치에서 실행
# MySQL 에서 CSV 파일 임포트

# 0) csv 파일 준비
# color_info.csv
# Name, Hex, URL

# 1) 테이블 생성
'''
CREATE TABLE colorTbl (
    Name VARCHAR(255) NULL,
    Hex VARCHAR(255) NULL,
    URL TEXT
);
'''

# 2) csv 파일을 업로딩 폴더에 복사 붙여넣기
'''
-- MySQL 업로딩 폴더 확인
SELECT @@GLOBAL.secure_file_priv;
-- C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\
'''

# color_info.csv 파일 복사 후에
# C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\ 위치로 붙여넣기

# 3) sql 명령 실행
# LOAD DATA
# INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/csv파일명'
# INTO TABLE 테이블명
# FIELDS TERMINATED BY ','
# IGNORE 1 ROWS;

'''
예시) 
LOAD DATA
INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/color_info.csv'
INTO TABLE colorTbl
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;
'''

# 4) 워큽벤치에서 확인
# select * from colorTbl;






