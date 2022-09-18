-- 1225. 报告系统状态的连续日期
-- https://leetcode.cn/problems/report-contiguous-dates/
-- 学习自：https://leetcode.cn/problems/report-contiguous-dates/solution/fen-bu-zou-jie-jue-jian-dan-yi-dong-by-l-0ch5/
-- 解题思路：subdate(date,row_number()over(partition by type order by date)) 分组
--     将表一根据 type 和 diff 分组，取每一组的最小 date 和 最大 date
select period_state,
  start_date,
  end_date
from(
    select type as period_state,
      diff,
      min(date) as start_date,
      max(date) as end_date
    from (
        select type,
          date,
          subdate(
            date,
            row_number() over(
              partition by type
              order by date
            )
          ) as diff,
          row_number() over(
            partition by type
            order by date
          ) as rn
        from (
            select 'failed' as type,
              fail_date as date
            from Failed
            union all
            select 'succeeded' as type,
              success_date as date
            from Succeeded
          ) a
      ) a
    where date between '2019-01-01' and '2019-12-31'
    group by type,
      diff
  ) t
order by start_date