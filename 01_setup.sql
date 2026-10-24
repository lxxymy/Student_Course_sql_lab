SET NAMES utf8mb4;
CREATE DATABASE school_lab
CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE school_lab;

CREATE TABLE s (
    sno CHAR(3) PRIMARY KEY,
    sname VARCHAR(20) NOT NULL,
    ssex CHAR(1) NOT NULL,
    sdept CHAR(2) NOT NULL,
    sage TINYINT UNSIGNED NOT NULL);

CREATE TABLE c (
    cno CHAR(2) PRIMARY KEY,
    cname VARCHAR(40) NOT NULL,
    credit DECIMAL(3,1) NOT NULL,
    cpno CHAR(2));

CREATE TABLE sc (
    sno CHAR(3) NOT NULL,
    cno CHAR(2) NOT NULL,
    grade DECIMAL(5,2),
    PRIMARY KEY (sno, cno),
    FOREIGN KEY (sno) REFERENCES s(sno),
    FOREIGN KEY (cno) REFERENCES c(cno));

INSERT INTO s (sno,sname,ssex,sdept,sage) VALUES
('801','张三','女','01',19),
('802','李四','男','01',20),
('803','王五','男','01',20),
('804','赵六','女','02',20),
('805','钱七','男','02',19);

INSERT INTO c (cno,cname,credit,cpno) VALUES
('c1','数据库',3.5,'c2'),
('c2','数据结构',4.0,'c4'),
('c3','编译原理',4.0,'c6'),
('c4','Pascal',3.0,NULL);

INSERT INTO sc (sno,cno,grade) VALUES
('801','c4',92),('801','c3',78),('801','c2',85),
('802','c3',82),('802','c4',90),('803','c4',88);
