-- 1767. 寻找没有被执行的任务对
-- https://leetcode.cn/problems/find-the-subtasks-that-did-not-execute
with recursive t(task_id, subtask_id) as (
  select task_id,
    subtasks_count
  from Tasks
  union all
  select task_id,
    subtask_id - 1
  from t
  where subtask_id >= 2
)
select t.*
from t
  left join Executed e using(task_id, subtask_id)
where e.subtask_id is null