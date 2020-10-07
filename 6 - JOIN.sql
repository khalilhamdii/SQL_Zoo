-- 1. 

SELECT matchid, player FROM goal 
  WHERE teamid = 'GER';
  
-- 2.

SELECT id, stadium, team1, team2
  FROM game
 WHERE id = 1012;

-- 3.

SELECT goal.player, goal.teamid, game.stadium, game.mdate
  FROM game JOIN goal ON (game.id=goal.matchid)
WHERE goal.teamid = 'GER';

-- 4.

SELECT m.team1, m.team2, g.player
  FROM game as m JOIN goal AS g ON (m.id=g.matchid)
WHERE player LIKE 'Mario%';

-- 5.

SELECT g.player, g.teamid, t.coach, g.gtime
  FROM goal AS g JOIN eteam AS t
    ON g.teamid = t.id
 WHERE gtime<=10;

-- 6.

SELECT m.mdate, t.teamname
  FROM game AS m JOIN eteam AS t
    ON m.team1 = t.id
 WHERE t.coach = 'Fernando Santos';

-- 7.

SELECT g.player
  FROM goal AS g JOIN game AS m
    ON m.id = g.matchid
 WHERE m.stadium = 'National Stadium, Warsaw';

-- 8.

SELECT DISTINCT g.player
  FROM game AS m JOIN goal AS g
   ON g.matchid = m.id 
 WHERE (m.team1='GER' OR m.team2='GER')
  AND g.teamid != 'GER'; 

-- 9.

SELECT t.teamname, COUNT(g.gtime) 
  FROM eteam AS t JOIN goal AS g
   ON t.id=g.teamid
 GROUP BY t.teamname
 ORDER BY t.teamname;

-- 10.

SELECT m.stadium, COUNT(g.gtime) 
  FROM game AS m JOIN goal AS g
   ON m.id=g.matchid
 GROUP BY m.stadium
 ORDER BY m.stadium;

-- 11.

SELECT g.matchid, m.mdate, COUNT(g.gtime)
  FROM game AS m JOIN goal AS g ON g.matchid = m.id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY m.id;

-- 12.

SELECT g.matchid, m.mdate, COUNT(g.gtime)
  FROM game AS m JOIN goal AS g ON g.matchid = m.id 
 WHERE teamid = 'GER'
GROUP BY m.id;

-- 13.

SELECT m.mdate,
  m.team1,
  SUM(CASE WHEN g.teamid=m.team1 THEN 1 ELSE 0 END) AS score1,
  m.team2,
  SUM(CASE WHEN g.teamid=m.team2 THEN 1 ELSE 0 END) AS score2
 FROM game AS m LEFT JOIN goal AS g ON g.matchid = m.id
 GROUP BY m.id
 ORDER BY mdate, matchid, team1, team2;