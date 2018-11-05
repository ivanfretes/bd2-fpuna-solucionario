/*

	Ejercicio 6

	Se necesita tener la lista completa de personas (independientemente de su tipo), ordenando por nombre de localidad. Si la persona no tiene asignada una localidad, también debe aparecer. Liste Nombre de Localidad, Nombre y apellido de la persona, dirección, teléfono
	
*/
SELECT 
	L.NOMBRE NOMBRE_LOCALIDAD,
	P.NOMBRE || ' ' || P.APELLIDO NOMBRE_APELLIDO,
	P.DIRECCION,
	P.TELEFONO
FROM B_PERSONAS P
LEFT JOIN B_LOCALIDAD L
ON L.ID = P.ID_LOCALIDAD
ORDER BY L.NOMBRE