create database jdbc_db;

use jdbc_db;

create table member (
	id int auto_increment primary key,
	name varchar(50),
    email varchar(100)
);