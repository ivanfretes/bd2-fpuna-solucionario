/*
	Ejercicio 1

	Crear en la instancia ORCL la vista materializada V_CLIENTES que una los datos de los clientes (personas que son clientes) de ORCL y de DIST eliminando los duplicados. Haga que la vista se actualice cada 1 hora a partir de la medianoche de hoy.

*/

CREATE MATERIALIZED VIEW v_clientes 
REFRESH START WITH  
	TRUNC(SYSDATE) 
	NEXT SYSDATE+1/24
IS
SELECT * FROM B_PERSONAS
WHERE ES_CLIENTE = 'S'
UNION
SELECT * FROM B_PERSONAS@DB_DIST01
WHERE ES_CLIENTE = 'S'