/*
	Ejercicio 1

	Inserte una nueva área denominada “Auditoría” con el ID igual al último más 1, que dependerá del ID perteneciente a la “Gerencia Administrativa”.
*/

INSERT INTO B_AREAS (ID, NOMBRE_AREA, ID_CATEGORIA_SUPERIOR)
SELECT (ID + 1) ID_AREA, 'Auditoria', (
	SELECT ID
	FROM B_AREAS
	WHERE NOMBRE_AREA LIKE 'Gerencia Administrativa'
	AND ROWNUM = 1;
) ID_AREA_SUP
FROM B_AREAS
WHERE ROWNUM = 1
ORDER BY ID DESC;