SET NAMES utf8mb4;

-- 01 条件查询与排序
-- 预期：802 李四、803 王五。
SELECT sno AS 学号, sname AS 姓名, sdept AS 院系, sage AS 年龄
FROM school_lab.s
WHERE sdept = '01' AND sage >= 20
ORDER BY sage DESC, sno ASC;

-- 02 模糊查询
-- 预期：c1 数据库、c2 数据结构。
SELECT cno AS 课程号, cname AS 课程名称, credit AS 学分
FROM school_lab.c
WHERE cname LIKE '%数据%'
ORDER BY cno;

-- 03a 去重
-- 预期：801、802、803。
SELECT DISTINCT sno AS 已选课学生学号
FROM school_lab.sc
ORDER BY sno;

-- 03b 算术表达式
-- 每学分16学时仅为练习假设。预期学时：56、64、64、48。
SELECT cno AS 课程号, cname AS 课程名称, credit AS 学分,
       credit * 16 AS 折算学时
FROM school_lab.c
ORDER BY cno;

-- 04 分组统计与HAVING
-- 预期：802 李四 2门 86分；801 张三 3门 85分。ROUND为显示精度补充函数。
SELECT s.sno AS 学号, s.sname AS 姓名,
       COUNT(*) AS 选课门数, ROUND(AVG(sc.grade), 2) AS 平均成绩
FROM school_lab.s AS s
JOIN school_lab.sc AS sc ON s.sno = sc.sno
GROUP BY s.sno, s.sname
HAVING COUNT(*) >= 2 AND AVG(sc.grade) >= 85
ORDER BY 平均成绩 DESC, s.sno;

-- 05 左外连接
-- 预期8行，保留没有选课的804赵六和805钱七。
SELECT s.sno AS 学号, s.sname AS 姓名,
       c.cno AS 课程号, c.cname AS 课程名称, sc.grade AS 成绩
FROM school_lab.s AS s
LEFT JOIN school_lab.sc AS sc ON s.sno = sc.sno
LEFT JOIN school_lab.c AS c ON sc.cno = c.cno
ORDER BY s.sno, c.cno;

-- 06a 自连接
-- 预期4行；c3的先修课c6缺少对应记录，c4没有填写先修课号。
SELECT current_course.cno AS 课程号,
       current_course.cname AS 课程名称,
       current_course.cpno AS 先修课程号,
       prerequisite.cname AS 先修课程名称
FROM school_lab.c AS current_course
LEFT JOIN school_lab.c AS prerequisite
  ON current_course.cpno = prerequisite.cno
ORDER BY current_course.cno;

-- 06b 空值判断与先修课缺失检查
-- 预期：c3 编译原理 c6。
SELECT current_course.cno AS 课程号,
       current_course.cname AS 课程名称,
       current_course.cpno AS 缺失的先修课程号
FROM school_lab.c AS current_course
LEFT JOIN school_lab.c AS prerequisite
  ON current_course.cpno = prerequisite.cno
WHERE current_course.cpno IS NOT NULL AND prerequisite.cno IS NULL
ORDER BY current_course.cno;

-- 07 相关子查询
-- 预期：801张三 Pascal 92；802李四 编译原理 82。
SELECT s.sno AS 学号, s.sname AS 姓名,
       c.cname AS 课程名称, sc.grade AS 成绩
FROM school_lab.sc AS sc
JOIN school_lab.s AS s ON sc.sno = s.sno
JOIN school_lab.c AS c ON sc.cno = c.cno
WHERE sc.grade > (
    SELECT AVG(other_sc.grade)
    FROM school_lab.sc AS other_sc
    WHERE other_sc.cno = sc.cno
)
ORDER BY s.sno, c.cno;

-- 08 NOT EXISTS
-- 预期：804赵六、805钱七。SELECT 1为存在性判断的常见写法。
SELECT s.sno AS 学号, s.sname AS 姓名
FROM school_lab.s AS s
WHERE NOT EXISTS (
    SELECT 1 FROM school_lab.sc AS sc WHERE sc.sno = s.sno
)
ORDER BY s.sno;
