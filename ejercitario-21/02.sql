/*
	Ejercicio 2

	Cree un bloque PL/SQL que mayorice los movimientos contables de febrero del 2012. Ud deberá o Recorrer las cuentas imputables del Plan de cuentas o Por cada cuenta, calcular el acumulado de débitos y créditos del periodo indicado o Insertar en el mayor calculando el id = id + el último id
*/

CREATE SYNONYM b_personas_r FOR b_personas@DB_DIST01;
CREATE SYNONYM b_compras_r FOR b_compras@DB_DIST01;
CREATE SYNONYM b_detalle_compras_r FOR b_detalle_compras@DB_DIST01;
CREATE SYNONYM b_articulos_r FOR b_articulos@DB_DIST01;