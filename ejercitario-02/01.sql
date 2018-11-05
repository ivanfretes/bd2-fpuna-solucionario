/*
	Ejercicio 1

	El campo FILE_NAME del archivo DBA_DATA_FILES contiene el nombre y camino de los archivos físicos que conforman los espacios de tabla de la Base de Datos. Seleccione:
		-Solamente el nombre del archivo (sin mencionar la carpeta o camino):
		-Solamente la carpeta o caminino (sin mencionar el archivo)
*/

SELECT SUBSTR(
		FILE_NAME,
		INSTR(FILE_NAME,'\',-1) + 1,
		LENGTH(FILE_NAME)
	) AS FILENAME,
	SUBSTR(
		FILE_NAME,
		1,
		INSTR(FILE_NAME,'\',-1) - 1
	) AS PATHNAME
FROM DBA_DATA_FILES;