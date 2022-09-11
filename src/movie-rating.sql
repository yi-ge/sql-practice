-- 1341. 电影评分
-- https://leetcode.cn/problems/movie-rating/
SELECT a.results
from (
    select MovieRating.user_id,
      name as results,
      count(*) as c
    from MovieRating,
      Users
    WHERE MovieRating.user_id = users.user_id
    GROUP BY MovieRating.user_id
    ORDER BY c DESC,
      name
    LIMIT 1
  ) a
union all
select b.results
from (
    select MovieRating.movie_id,
      MovieRating.rating,
      title as results
    from MovieRating,
      Movies
    WHERE MovieRating.movie_id = Movies.movie_id
      and created_at BETWEEN '2020-02-01' and '2020-02-28'
    GROUP BY MovieRating.movie_id
    ORDER BY avg(MovieRating.rating) DESC,
      title
    LIMIT 1
  ) b