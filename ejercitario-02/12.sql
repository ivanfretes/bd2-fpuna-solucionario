/*
	Ejercicio 12

	. Imprima su edad en años y meses. Ejemplo: Si nació el 23/abril/1972, tendría 43 años y 3 meses a la fecha.
*/

SELECT 
	TRUNC(
		MONTHS_BETWEEN(
			TRUNC(SYSDATE), 
			TRUNC(TO_DATE('23/diciembre/1972'))) / 12) AS  ANHOS,

	ROUND(MOD(
	MONTHS_BETWEEN(
		TRUNC(SYSDATE), 
		TRUNC(TO_DATE('23/diciembre/1972')))
	,12))  MESES
FROM DUAL