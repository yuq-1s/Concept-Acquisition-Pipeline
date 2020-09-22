SELECT
 exercise_title,
 content,
 answer,
 problem_type_en 
FROM
 xt_hive.dim_exerciseproblem_f 
WHERE
 exercise_id IN
 (
	SELECT DISTINCT exercise_id 
    FROM xt_hive.dwd_classroom_exerciseleaf_f
    WHERE classroom_id IN
    ( SELECT DISTINCT classroom_id FROM xt_hive.dim_classroom_f WHERE course_name LIKE '%%数据结构%%' ) );