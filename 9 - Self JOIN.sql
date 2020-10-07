-- 1.

SELECT COUNT(s.id)
 FROM stops AS s;

-- 2.

SELECT id
  FROM stops
 WHERE name = 'Craiglockhart';

-- 3.

SELECT DISTINCT s.id, s.name
  FROM stops AS s JOIN route AS r
   ON s.id = r.stop
 WHERE r.company = 'LRT'
  AND r.num = '4';

-- 4.

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*)= 2

-- 5.

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53
 AND b.stop=149;

-- 6.

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
 AND stopb.name = 'London Road';

-- 7.

SELECT a.company, a.num
  FROM route AS a JOIN route AS b ON
   (a.company=b.company AND a.num=b.num)
 WHERE a.stop = 115
  AND b.stop = 137
GROUP BY a.num;

-- 8.

SELECT a.company, a.num
  FROM route AS a JOIN route AS b ON
   (a.company=b.company AND a.num=b.num)
    JOIN stops AS stopa ON (a.stop = stopa.id)
    JOIN stops AS stopb ON (b.stop = stopb.id)
 WHERE stopa.name = 'Craiglockhart'
  AND stopb.name = 'Tollcross'
GROUP BY a.num;

-- 9.

SELECT stopb.name, a.company, a.num
  FROM route AS a JOIN route AS b ON
   (a.company=b.company AND a.num=b.num)
    JOIN stops AS stopa ON (a.stop = stopa.id)
    JOIN stops AS stopb ON (b.stop = stopb.id)
 WHERE stopa.name = 'Craiglockhart';

-- 10.

SELECT first.num, first.company, first.name, second.num, second.company
  FROM (SELECT a.company, a.num, stopb.id AS intermediate, stopb.name
             FROM route AS a JOIN route AS b ON
                (a.company=b.company AND a.num=b.num)
              JOIN stops AS stopa ON (a.stop = stopa.id)
              JOIN stops AS stopb ON (b.stop = stopb.id)
            WHERE stopa.name = 'Craiglockhart') AS first
  JOIN (SELECT c.company, c.num, c.stop AS intermediate
             FROM route AS c JOIN route AS d ON
               (c.company=d.company AND c.num=d.num)
              JOIN stops AS stopd ON (d.stop = stopd.id)
            WHERE stopd.name = 'Lochend') AS second
   ON (first.intermediate = second.intermediate)
ORDER BY first.num, first.name, second.num;