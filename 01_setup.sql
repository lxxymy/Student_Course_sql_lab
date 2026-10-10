SET NAMES utf8mb4;
CREATE DATABASE school_lab
CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE school_lab;

CREATE TABLE s (
    sno CHAR(3) PRIMARY KEY,
    sname VARCHAR(20) NOT NULL,
    ssex CHAR(1) NOT NULL,
    sdept CHAR(2) NOT NULL,
    sage TINYINT UNSIGNED NOT NULL,
    CONSTRAINT chk_s_sex CHECK (ssex IN ('男', '女')),
    CONSTRAINT chk_s_age CHECK (sage BETWEEN 1 AND 120)
) ENGINE = InnoDB;

-- 原题 c3 的先修课程 c6 缺少对应记录，cpno 暂不设置自引用外键。
CREATE TABLE c (
    cno CHAR(2) PRIMARY KEY,
    cname VARCHAR(40) NOT NULL,
    credit DECIMAL(3,1) NOT NULL,
    cpno CHAR(2),
    CONSTRAINT chk_c_credit CHECK (credit > 0)
) ENGINE = InnoDB;

CREATE TABLE sc (
    sno CHAR(3) NOT NULL,
    cno CHAR(2) NOT NULL,
    grade DECIMAL(5,2),
    PRIMARY KEY (sno, cno),
    CONSTRAINT fk_sc_student FOREIGN KEY (sno) REFERENCES s(sno),
    CONSTRAINT fk_sc_course FOREIGN KEY (cno) REFERENCES c(cno),
    CONSTRAINT chk_sc_grade CHECK (grade BETWEEN 0 AND 100)
) ENGINE = InnoDB;

START TRANSACTION;
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
COMMIT;
