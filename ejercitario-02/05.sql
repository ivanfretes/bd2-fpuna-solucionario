/*
	Ejercicio 5

	Se pretende realizar el aumento salarial del 5% para todas las categorías. Debe listar la categoría (código y nombre), el importe actual, el importe aumentado al 5% (redondeando la cifra a la centena), y la diferencia.

	Formatee la salida (usando TO_CHAR) para que los montos tengan los puntos de mil.
*/

SELECT 
	COD_CATEGORIA,
	NOMBRE_CAT,
	TO_CHAR(ASIGNACION, '999G999G999') IMPORTE_ACTUAL,
	TO_CHAR(ROUND( ASIGNACION * 1.05, 2), '999G999G999') IMPORTE_MAS_5PORC,
	TO_CHAR(ROUND( ASIGNACION * 0.05, 2), '999G999G999') DIFERENCIA
FROM B_CATEGORIAS_SALARIALES
WHERE FECHA_FIN IS NULL