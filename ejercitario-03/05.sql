/*
	Ejercicio 5

	Se necesita saber la cantidad de clientes que hay por cada localidad (Tenga en cuenta en la tabla B_PERSONAS sólo aquellas que son clientes). 

	Liste el id, la descripción de la localidad y la cantidad de clientes. Asegúrese que se listen también las localidades que NO tienen clientes.
*/

SELECT L.ID, L.NOMBRE, COUNT(P.ID) CANT_CLIENTES
FROM B_PERSONAS P
RIGHT JOIN B_LOCALIDAD L
ON L.ID = P.ID_LOCALIDAD
WHERE P.ES_CLIENTE = 'S'
GROUP BY P.ID_LOCALIDAD;