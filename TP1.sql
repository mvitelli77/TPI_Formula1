CREATE DATABASE  IF NOT EXISTS `TP1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `TP1`;

SELECT *
FROM constructors_filtrados;

ALTER TABLE qualifying
DROP MyUnknownColumn;

# Pregunta 1: Anio con mas carreras
SELECT year, count(year) as 'cantidad carreras corridas en el anio'
FROM races
GROUP BY year
ORDER BY count(year) DESC
LIMIT 1;

SELECT MAX(co.cant_carr) as 'cantidad maxima de carreras corridas en un anio' FROM 
   (SELECT count(year) as cant_carr 
    FROM races
	GROUP BY year) co;

# Pregunta 2: Piloto con mayor cantidad de primeros premios
SELECT MAX(gan.driver) as 'cantidad carreras ganadas', gan.driverId as piloto, d.surname as Nombre 
       FROM (SELECT driverId, COUNT(driverId) as driver
             FROM results_filtrados
             WHERE positionOrder='1'
             GROUP BY driverId) gan
	    JOIN drivers d 
        ON (gan.driverId=d.driverId);

SELECT d.surname
FROM drivers d
JOIN results_filtrados r
 ON  (d.driverId=r.driverId)
 WHERE d.driverId= "1";

# Pregunta 3> Nombre del circuito mas corrido
SELECT COUNT(r.circuitId), r.name, r.circuitID, c.name
FROM races r
JOIN circuits c
ON (r.circuitID=c.circuitID)
GROUP BY circuitId
ORDER BY COUNT(circuitId) DESC
LIMIT 1;

# Pregunta 4> Piloto con mayor cantidad de puntos en equipo Britanico o Americano
SELECT SUM(r.points), r.driverId, d.surname
FROM results_filtrados r
JOIN drivers d
ON (r.driverId=d.driverId)
JOIN constructors_filtrados c
ON (c.constructorId=r.constructorId)
GROUP BY r.driverId and c.nationality="British" or c.nationality="American"
ORDER BY SUM(points) ASC
LIMIT 1;
# No puede ser 16.415 puntos, esta sumando mal

SELECT r.driverId,sum(r.points) as sumapuntos , d.surname , c.nationality
FROM results_filtrados r
JOIN drivers d
ON  (r.driverId=d.driverId)
JOIN constructors_filtrados c 
ON (r.constructorId=c.constructorId)
WHERE c.nationality="American" OR c.nationality="British" 
GROUP BY r.driverId limit 1 ;


SELECT name, constructorId
FROM constructors_filtrados
WHERE constructorId=1 or constructorId=131;

SELECT *
FROM qualifying
LIMIT 10;
