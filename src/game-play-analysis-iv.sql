-- 550. 游戏玩法分析 IV
-- https://leetcode.cn/problems/game-play-analysis-iv/
-- 查出该用户首次登录的时间
-- select player_id,
--   MIN(event_date) as frist_date
-- from Activity
-- GROUP BY player_id
select round(ac.active / ab.al, 2) fraction
from (
    select count(a.player_id) as active
    from Activity,
      (
        select player_id,
          MIN(event_date) as frist_date
        from Activity
        GROUP BY player_id
      ) a
    where a.player_id = Activity.player_id
      and a.frist_date + 1 = Activity.event_date
  ) ac,
  (
    select count(distinct player_id) as al
    from Activity
  ) ab