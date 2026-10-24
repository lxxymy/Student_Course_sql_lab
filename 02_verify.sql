SET NAMES utf8mb4;
USE school_lab;

SELECT VERSION() AS mysql_version, DATABASE() AS current_database;
SELECT * FROM s ORDER BY sno;
SELECT * FROM c ORDER BY cno;
SELECT * FROM sc ORDER BY sno, cno;

-- 预期记录数：S=5，C=4，SC=6。
SELECT 'S' AS table_name, COUNT(*) AS row_count FROM s
UNION ALL SELECT 'C', COUNT(*) FROM c
UNION ALL SELECT 'SC', COUNT(*) FROM sc;

-- 三表关联查询：6 行。
SELECT s.sno AS 学号, s.sname AS 姓名,
       c.cno AS 课程号, c.cname AS 课程名称, sc.grade AS 成绩
FROM sc,s,c
WHERE sc.sno=s.sno AND sc.cno=c.cno
ORDER BY s.sno,c.cno;
