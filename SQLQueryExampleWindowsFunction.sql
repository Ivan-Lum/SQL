/* Demonstrates windows function*/

SELECT DISTINCT(player_id), FIRST_VALUE(device_id) over
(PARTITION BY player_id ORDER BY event_date) as device_id
FROM activity
ORDER BY player_id