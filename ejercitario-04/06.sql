/*
	Ejercicio 6

	Se han rematado todos los artículos que no han tenido ventas ni compras entodo el periodo. Elimine físicamente dichos artículos de la BD.
*/

DELETE FROM B_ARTICULOS
WHERE (
	SELECT 
	)