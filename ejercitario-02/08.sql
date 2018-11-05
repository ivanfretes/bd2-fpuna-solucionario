/*
	Ejercicio 8

	Obtenga la misma lista del ejercicio 6, pero asegurándose de listar todas las personas, independientemente que estén asociadas a una localidad, y todas las localidades, aún cuando no tengan personas asociadas:
*/

SELECT 
	L.NOMBRE NOMBRE_LOCALIDAD,
	P.NOMBRE || ' ' || P.APELLIDO NOMBRE_APELLIDO,
	P.DIRECCION,
	P.TELEFONO
FROM B_PERSONAS P, B_LOCALIDAD L
ORDER BY L.NOMBRE