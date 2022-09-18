-- 1412. 查找成绩处于中游的学生
-- https://leetcode.cn/problems/find-the-quiet-students-in-all-exams/
select s.student_id,
  s.student_name
from (
    select *,
      min(score) over(partition by exam_id) AS min_score,
      max(score) over(partition by exam_id) AS max_score
    from Exam
  ) t
  JOIN Student AS s ON s.student_id = t.student_id
group by s.student_id,
  s.student_name
having sum(
    if (
      t.score = min_score
      OR t.score = max_score,
      1,
      0
    )
  ) = 0 -- 
  -- with a as (
  --   select DISTINCT exam_id,
  --     max(score) over(partition by exam_id) score
  --   from exam
  --   union
  --     select DISTINCT exam_id,
  --     min(score) over(partition by exam_id) score
  --   from exam
  -- )
  -- select distinct student.student_id,
  --   student_name
  -- from exam
  --   join student on student.student_id in (
  --     select student_id
  --     from exam
  --   )
  --   and (exam_id, score) not in (
  --     select * from a
  --   )
  -- order by student.student_id