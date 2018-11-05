/*
	Ejercicio 7

	En base a la consulta anterior, liste todas las localidades, independientemente que existan personas en dicha localidad.
*/

SELECT 
	L.NOMBRE NOMBRE_LOCALIDAD,
	P.NOMBRE || ' ' || P.APELLIDO NOMBRE_APELLIDO,
	P.DIRECCION,
	P.TELEFONO
FROM B_PERSONAS P
RIGHT JOIN B_LOCALIDAD L
ON L.ID = P.ID_LOCALIDAD
ORDER BY L.NOMBRE