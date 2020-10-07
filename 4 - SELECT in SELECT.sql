-- 1.

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia');

--2.

SELECT name FROM world
  WHERE gdp/population >
     (SELECT gdp/population FROM world
      WHERE name='United Kingdom')
   AND continent LIKE 'Europe';

-- 3.

SELECT name, continent FROM world
  WHERE continent IN
     (SELECT continent FROM world
      WHERE name IN('Argentina', 'Australia'))
   ORDER BY name;

-- 4.

SELECT name, population FROM world
  WHERE population > (SELECT population FROM world
      WHERE name LIKE 'Canada')
   AND population < (SELECT population FROM world
      WHERE name LIKE 'Poland');

-- 5.

SELECT name, CONCAT
   (ROUND
     (100*population/(SELECT population FROM world WHERE name = 'Germany')),
   '%') AS population_percent
  FROM world
 WHERE continent LIKE 'Europe';

-- 6.

SELECT name
  FROM world
 WHERE gdp > (SELECT MAX(gdp) FROM world WHERE continent = 'Europe');
 
-- 7.

SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND population>0);

-- 8.

SELECT continent, name FROM world x
  WHERE name <= ALL
    (SELECT name FROM world y
        WHERE y.continent=x.continent);

-- 9.

SELECT name, continent, population FROM world
  WHERE continent NOT IN (SELECT DISTINCT continent FROM world WHERE population > 25000000);

-- 10.

SELECT name, continent FROM world x
  WHERE population/3 >= ALL
    (SELECT population FROM world y
        WHERE y.continent=x.continent
          AND y.name NOT LIKE x.name);