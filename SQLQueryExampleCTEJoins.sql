/*Demonstrates CTE, ISNULL, UNION ALL, JOINS, CASE, GROUP BY, ORDER BY */

WITH host_points as (SELECT host_team, (CASE
 WHEN host_goals > guest_goals THEN 3
 WHEN host_goals < guest_goals THEN 0
 ELSE 1
 END) as points
FROM matches)
,

guest_points as (SELECT guest_team, (CASE
 WHEN guest_goals > host_goals THEN 3
 WHEN guest_goals < host_goals THEN 0
 ELSE 1
 END) as points
FROM matches)
,

union_teams as (SELECT host_team as team, points
FROM host_points
UNION ALL
SELECT guest_team, points
FROM guest_points)

/* Main Query */
SELECT t.team_id, t.team_name, ISNULL(sum(points), 0) as num_points
FROM teams t
LEFT JOIN union_teams u
ON t.team_id = u.team
GROUP BY t.team_id, t.team_name
ORDER BY num_points DESC, t.team_id