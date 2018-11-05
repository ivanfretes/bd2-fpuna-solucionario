/*

	Ejercicio 11

	Tomando en cuenta la fecha de hoy, verifique que fecha dará redondeando al año? Y truncando al año? Escriba el resultado. Pruebe lo mismo suponiendo que sea el 1 de Julio del año. Pruebe también el 12 de marzo.
*/

SELECT 
	ROUND(SYSDATE,'YEAR') ROUND_ANHO,
	TRUNC(SYSDATE,'YEAR') TRUNC_ANHO
FROM DUAL