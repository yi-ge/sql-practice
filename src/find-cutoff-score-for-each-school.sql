-- 1988. 找出每所学校的最低分数要求
-- https://leetcode.cn/problems/find-cutoff-score-for-each-school/
SELECT school_id,
  IFNULL(MIN(score), -1) AS score
FROM Schools
  LEFT JOIN Exam ON student_count <= capacity
GROUP BY school_id