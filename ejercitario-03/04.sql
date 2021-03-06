/*
	Ejercicio 4

	Determine el nombre y apellido, nombre de categoría, asignación y área del empleado (o empleados) que tienen una asignación INFERIOR al promedio. Ordene por monto de salario en forma DESCENDENTE. Intente la misma consulta con y sin WITH.
*/


--Utilizando subquery
SELECT 
	E.NOMBRE || ' ' || E.APELLIDO NOMBRE_APELLIDO,
	S.NOM_CAT NOMBRE_CATEGORIA,
	S.ASIGNACION,
	A.NOMBRE_AREA
FROM B_POSICION_ACTUAL P
INNER JOIN B_EMPLEADOS E
ON E.CEDULA = P.CEDULA
INNER JOIN B_CATEGORIAS_SALARIALES S
ON S.COD_CATEGORIA = P.COD_CATEGORIA
INNER JOIN B_AREAS A
ON A.ID = P.ID_AREA
WHERE S.FECHA_FIN IS NULL
AND P.FECHA_FIN IS NULL
AND B.ASIGNACION < (
	SELECT AVG(ASIGNACION) PROM_ASIG 
	FROM B_CATEGORIAS_SALARIALES 
)
GROUP BY E.CEDULA
ORDER BY E.ASIGNACION DESC;



-- Utilizando WITH

WITH TMP_EMPLEADOS AS(
	SELECT 
		E.NOMBRE || ' ' || E.APELLIDO NOMBRE_APELLIDO,
		S.NOM_CAT NOMBRE_CATEGORIA,
		S.ASIGNACION,
		A.NOMBRE_AREA
	FROM B_POSICION_ACTUAL P
	INNER JOIN B_EMPLEADOS E
	ON E.CEDULA = P.CEDULA
	INNER JOIN B_CATEGORIAS_SALARIALES S
	ON S.COD_CATEGORIA = P.COD_CATEGORIA
	INNER JOIN B_AREAS A
	ON A.ID = P.ID_AREA
	WHERE S.FECHA_FIN IS NULL
	AND P.FECHA_FIN IS NULL
)

SELECT 
	E.NOMBRE_APELLIDO,
	E.NOMBRE_CATEGORIA,
	E.ASIGNACION,
	E.NOMBRE_AREA
FROM TMP_EMPLEADOS E
WHERE E.ASIGNACION < ( 
	SELECT 
	AVG(TMP_EMPLEADOS.ASIGNACION) PROM_ASIG
	FROM TMP_EMPLEADOS TE 
)
ORDER BY E.ASIGNACION DESC;


