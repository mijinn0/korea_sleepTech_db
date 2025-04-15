create database school_db;
use school_db;

###
# 테이블 간 관계
###
# 1. 교수-강의(1:N, 일대다)
# : 한 명의 교수는 여러 강의를 담당
# : 강의 테이블에 담당교수ID 존재 - FK 참조값
# - ERD 선: 점선(비식별 관계)
#	>> 교수ID가 FK로만 사용 (PK X)

# 2. 학생 - 수강내역 - 강의 관계 (N:M, 다대다)
# : 학생은 여러 강의를 수강할 수 있고
# : 한 강의는 여러 학생이 수강할 수 있음
# >> 다대다(N:M)관계는 RDB에서 직접적인 표현이 불가!
#	 : 중간 테이블로 해결
# - 다대다(N:M)관계는 두 개의 1:N 관계로 분해
		# 학생 - 수강내역 (1:N)
        # 강의 - 수강내역 (1:N)

create table Students (
	학생ID int primary key,
    이름 varchar(100),
    전공 varchar(100),
    입학년도 int
);

create table Professors (
	교수ID int primary key,
    이름 varchar(100),
    학과 varchar(100),
    사무실위치 varchar(100)
);

create table Courses (
	강의ID int primary key,
    강의명 varchar(100),
    담당교수ID int,
	학점수 int,
    foreign key (담당교수ID) references Professors(교수ID)
);

create table Enrollments (
	수강ID int primary key,
    학생ID int,
    강의ID int,
    수강년도 int,
    학기 int,
    foreign key (학생ID) references Students(학생ID),
    foreign key (강의ID) references Courses(강의ID)
);

/*
전공이 컴퓨터 과학인 학생들의 이름과 입학년도를 조회하는 SQL 명령문을 작성
담당 교수 ID가 2인 강의의 강의명과 학점 수를 조회하는 SQL 명령문을 작성
2023년도 1학기에 수강하는 학생들의 목록을 조회하는 SQL 명령문을 작성 (학생 ID와 이름을 포함)
*/ 

select 이름, 입학년도
from Students
where 전공 = 'Computer Science';

select 강의명, 학점수
from Courses
where 담당교수ID = 2;

select s.학생ID, s.이름
from Students S
join Enrollments E on s.학생ID = E.학생ID
where e.수강년도 = 2023 and 학기 = 1;