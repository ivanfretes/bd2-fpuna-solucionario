/*

	Ejercicio 9

	Considerando la fecha de hoy, indique cuándo caerá el próximo DOMINGO.
*/

SELECT NEXT_DAY(SYSDATE, 'DOMINGO') PROX_DOMINGO
FROM DUAL