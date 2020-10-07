-- 1.

SELECT id, title
 FROM movie
 WHERE yr=1962;

-- 2.

SELECT yr FROM movie
  WHERE title = 'Citizen Kane';

-- 3.
the words Star Trek in the title). Order results by year.

SELECT id, title, yr FROM movie
  WHERE title LIKE 'Star Trek%'
 ORDER BY yr;

-- 4.

SELECT id FROM actor
  WHERE name LIKE 'Glenn Close';

-- 5.

SELECT id FROM movie
  WHERE title LIKE 'Casablanca';

-- 6.

SELECT a.name FROM actor AS a JOIN casting AS c
  ON c.actorid = a.id
  WHERE movieid = 11768;

-- 7.

SELECT a.name FROM actor AS a JOIN casting AS c
  ON c.actorid = a.id 
   JOIN movie AS m ON m.id = c.movieid
  WHERE m.title = 'Alien';

-- 8.

SELECT m.title FROM movie AS m JOIN casting AS c
  ON m.id = c.movieid 
   JOIN actor AS a ON a.id = c.actorid
  WHERE a.name = 'Harrison Ford';

-- 9.

SELECT m.title FROM movie AS m JOIN casting AS c
  ON m.id = c.movieid 
   JOIN actor AS a ON a.id = c.actorid
  WHERE a.name = 'Harrison Ford'
    AND c.ord != 1;

-- 10.

SELECT m.title, a.name FROM movie AS m JOIN casting AS c
  ON m.id = c.movieid 
   JOIN actor AS a ON a.id = c.actorid
  WHERE m.yr = 1962
    AND c.ord = 1;

-- 11.

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

-- 12.

SELECT m.title, a.name
  FROM movie AS m JOIN casting AS c ON m.id = c.movieid
   JOIN actor AS a ON a.id = c.actorid
  WHERE c.movieid IN (SELECT c.movieid
    FROM casting AS c
     JOIN actor AS a ON a.id = c.actorid
   WHERE a.name ='Julie Andrews')
  AND ord = 1; 

-- 13.

SELECT a.name
  FROM casting AS c JOIN actor AS a ON c.actorid = a.id
 WHERE ord = 1
GROUP BY actorid HAVING COUNT(c.movieid) >= 15
ORDER BY a.name;

-- 14.

SELECT m.title, COUNT(c.actorid)
  FROM casting AS c JOIN movie AS m
   ON m.id = c.movieid
 WHERE m.yr = 1978
 GROUP BY movieid
 ORDER BY COUNT(c.actorid) DESC, m.title;

-- 15.

SELECT DISTINCT a.name
  FROM casting AS c JOIN actor AS a
   ON c.actorid = a.id
 WHERE movieid IN (SELECT c.movieid
     FROM casting AS c JOIN actor AS a
      ON c.actorid = a.id
    WHERE a.name = 'Art Garfunkel')
 AND a.name != 'Art Garfunkel';