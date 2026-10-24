SET NAMES utf8mb4;

-- 01 
SELECT sno AS 学号, sname AS 姓名, sdept AS 院系, sage AS 年龄
FROM school_lab.s
WHERE sdept = '01' AND sage >= 20
ORDER BY sage DESC, sno ASC;

-- 02 
SELECT cno AS 课程号, cname AS 课程名称, credit AS 学分
FROM school_lab.c
WHERE cname LIKE '%数据%'
ORDER BY cno;

-- 03a 
SELECT DISTINCT sno AS 已选课学生学号
FROM school_lab.sc
ORDER BY sno;

-- 03b 
SELECT cno AS 课程号, cname AS 课程名称, credit AS 学分,
       credit * 16 AS 折算学时
FROM school_lab.c
ORDER BY cno;

-- 04 
SELECT s.sno AS 学号, s.sname AS 姓名,
       COUNT(*) AS 选课门数, ROUND(AVG(sc.grade), 2) AS 平均成绩
FROM school_lab.s AS s
JOIN school_lab.sc AS sc ON s.sno = sc.sno
GROUP BY s.sno, s.sname
HAVING COUNT(*) >= 2 AND AVG(sc.grade) >= 85
ORDER BY 平均成绩 DESC, s.sno;

-- 05 
SELECT s.sno AS 学号, s.sname AS 姓名,
       c.cno AS 课程号, c.cname AS 课程名称, sc.grade AS 成绩
FROM school_lab.s AS s
LEFT OUTER JOIN school_lab.sc AS sc ON s.sno = sc.sno
LEFT OUTER JOIN school_lab.c AS c ON sc.cno = c.cno
ORDER BY s.sno, c.cno;

-- 06a 
SELECT X.cno AS 课程号,
       X.cname AS 课程名称,
       X.cpno AS 先修课程号,
       Y.cname AS 先修课程名称
FROM school_lab.c AS X
LEFT OUTER JOIN school_lab.c AS Y ON X.cpno = Y.cno
ORDER BY X.cno;

-- 06b 
SELECT X.cno AS 课程号,
       X.cname AS 课程名称,
       X.cpno AS 缺失的先修课程号
FROM school_lab.c AS X
LEFT OUTER JOIN school_lab.c AS Y ON X.cpno = Y.cno
WHERE X.cpno IS NOT NULL AND Y.cno IS NULL
ORDER BY X.cno;

-- 07 
SELECT s.sno AS 学号, s.sname AS 姓名,
       c.cname AS 课程名称, sc.grade AS 成绩
FROM school_lab.sc AS sc,
     school_lab.s AS s,
     school_lab.c AS c
WHERE sc.sno = s.sno
  AND sc.cno = c.cno
  AND sc.grade > (
      SELECT AVG(other_sc.grade)
      FROM school_lab.sc AS other_sc
      WHERE other_sc.cno = sc.cno
  )
ORDER BY s.sno, c.cno;

-- 08 NOT EXISTS
SELECT s.sno AS 学号, s.sname AS 姓名
FROM school_lab.s AS s
WHERE NOT EXISTS (
    SELECT * FROM school_lab.sc AS sc WHERE sc.sno = s.sno
)
ORDER BY s.sno;
