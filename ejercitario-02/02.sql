/*
	Ejercicio 2
	

	Obtenga la lista de empleados con su posición y salario vigente (El salario y la categoría vigente tienen la fecha fin nula – Un solo salario está vigente en un momento dado). Debe listar:
	
	Nombre área, Apellido y nombre del empleado, Fecha Ingreso, categoría, salario actual
	
	* La lista debe ir ordenada por nombre de área, y por apellido del funcionario.
*/

SELECT  
	A.NOMBRE_AREA, 
	E.APELLIDO || ' ' || E.NOMBRE NOMBRE_APELLIDO,
	E.FECHA_ING,
	S.NOMBRE_CAT CATEGORIA,
	S.ASIGNACION SALARIO_ACTUAL
FROM B_POSICION_ACTUAL P
INNER JOIN B_EMPLEADOS E
ON E.CEDULA = P.CEDULA
INNER JOIN B_AREAS A
ON A.ID = P.ID_AREA
INNER JOIN B_CATEGORIAS_SALARIALES S
ON P.COD_CATEGORIA = S.COD_CATEGORIA
WHERE P.FECHA_FIN IS NULL
AND S.FECHA_FIN IS NULL
ORDER BY A.NOMBRE_AREA, E.APELLIDO