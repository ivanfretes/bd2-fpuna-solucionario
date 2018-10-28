/*
	Ejercicio 1
	
	Cree en la base de datos el procedimiento P_BORRAR_OBJETOS, que borrará (con SQL dinámico), todos los objetos de su esquema que no correspondan al esquema del curso (En el esquema del curso todas las tablas empiezan con ‘B_’
*/

SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE P_BORRAR_OBJETOS
IS
	-- Query con los nombres de las tablas
	CURSOR C_CUR IS
		SELECT TABLE_NAME 
		FROM USER_TABLES
		AND TABLE_NAME  LIKE 'B%\_%' ESCAPE '\'; -- B_PERSONA

	R_CUR  C_CUR%ROWTYPE; -- Fetch del registro
BEGIN
	OPEN C_CUR;

	LOOP 
		FETCH C_CUR INTO R_CUR;
		EXECUTE IMMEDIATE 'DROP TABLE IF EXISTS ' || R_CUR.TABLE_NAME || ' CASCADE CONSTRAINT ';
		DBMS_OUTPUT.PUT_LINE(R_CUR.TABLE_NAME);

		EXIT WHEN C_CUR%NOTFOUND
			DBMS_OUTPUT.PUT_LINE('SQL DATA NOT FOUND');
	END LOOP;

	CLOSE C_CUR;

EXCEPTION
	WHEN OTHER THEN
		DBMS_OUTPUT.PUT_LINE('Error en la eliminacion');
END;
