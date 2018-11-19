/*
	Ejercicio 1

	El salario de cada empleado está dado por su posición, y la asignación de la categoría vigente en dicha posición. Tanto la posición como la categoría vigente tienen la fecha fin nula – Un solo salario está vigente en un momento dado). Tomando como base la lista de empleados, verifique cuál es el salario máximo, el mínimo y el promedio. Formatee la salida para que se muestren los puntos de mil.
*/
SELECT 
	TO_CHAR(MAX(S.ASIGNACION),'9G999G999G999') MAX_SALARIO, 
	TO_CHAR(MIN(S.ASIGNACION),'9G999G999G999') MIN_SALARIO,
	TO_CHAR(AVG(S.ASIGNACION),'9G999G999G999') PROMEDIO_SALARIO
FROM B_POSICION_ACTUAL P
INNER JOIN B_EMPLEADOS E
ON E.CEDULA = P.CEDULA
INNER JOIN B_CATEGORIAS_SALARIALES S
ON S.COD_CATEGORIA = P.COD_CATEGORIA
WHERE S.FECHA_FIN IS NULL
AND P.FECHA_FIN IS NULL
GROUP BY E.CEDULA;
