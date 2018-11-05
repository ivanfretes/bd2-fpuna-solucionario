/*
	Ejercicio 5

	Cree un bloque PL/SQL que acepte por teclado el nombre de un tablespace. El programa deberá devolver el nombre del archivo físico (datafile) del tablespace. Asegúrese que lee solo el primer registro encontrado (suponiendo que el tablespace tenga más de 1 datafile). Imprima el nombre del datafile sin el camino (PATH)
*/

DECLARE
	V_DATAFILE		VARCHAR2 NOT NULL;
	V_FILENAME		VARCHAR2(30) NOT NULL;
BEGIN 
	
	V_TABLESPACE	:=	&a;
	SELECT SUBSTR(
		FILE_NAME,
		INSTR(FILE_NAME,'\',-1) + 1,
		LENGTH(FILE_NAME)
	)
	INTO
	V_FILENAME
	FROM DBA_DATA_FILES
	WHERE FILE_NAME = V_DATAFILE
	AND ROWNUM = 1;
	
	DBMS_OUTPUT.PUT_LINE(V_FILENAME);
END;