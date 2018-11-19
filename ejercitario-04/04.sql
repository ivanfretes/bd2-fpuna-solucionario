/*
	Ejercitario 4

	El Señor Ricardo Meza pasa a tener la misma posición y área que la Señora Amanda Pérez. Realice el cambio en 2 sentencias:  
		
		- ACTUALICE la fecha de fin a la actual posición de Ricardo Meza 

		- INSERTE una nueva posición para el señor Ricardo Meza, con la categoría y  área de la Señora Amanda Pérez, y fecha de inicio a partir de hoy.
*/

UPDATE B_POSICION_ACTUAL SET FECHA_FIN = SYSDATE 
WHERE NOMBRE LIKE 'Ricardo' 
AND APELLIDO LIKE 'Meza'


INSERT INTO B_POSICION_ACTUAL(COD_CATEGORIA, ID_AREA, FECHA_INI)
SELECT 
	ID_AREA, 
	COD_CATEGORIA,
	SYSDATE
( 	SELECT 
		P.ID_AREA
		P.COD_CATEGORIA
	FROM B_POSICION_ACTUAL P
	INNER JOIN B_AREAS A
	A.ID = P.ID_AREA
	INNER JOIN B_EMPLEADOS E
	ON P.CEDULA = E.CEDULA
	INNER JOIN B_CATEGORIAS_SALARIALES S
	ON S.COD_CATEGORIA = P.COD_CATEGORIA
	WHERE NOMBRE LIKE 'Amanda' 
	AND APELLIDO LIKE 'Pérez'
	AND S.FECHA_FIN IS NULL
	AND P.FECHA_FIN IS NULL
	AND ROWNUM = 1
) TMP;