/*
	Ejercicio 1
	
	Cree en la base de datos el procedimiento P_BORRAR_OBJETOS, que borrará (con SQL dinámico), todos los objetos de su esquema que no correspondan al esquema del curso (En el esquema del curso todas las tablas empiezan con ‘B_’
*/


CREATE OR REPLACE PROCEDURE P_BORRAR_OBJETOS
IS
	-- Query con los nombres de las tablas
	CURSOR C_CUR IS
		SELECT TABLE_NAME 
		FROM USER_TABLES
		WHERE TABLE_NAME NOT LIKE 'B%\_%' ESCAPE '\'; -- Distinto de B_PERSONA

	R_CUR  C_CUR%ROWTYPE; -- Fetch del registro
BEGIN
	OPEN C_CUR;

	LOOP 	
		FETCH C_CUR INTO R_CUR;
		IF C_CUR%NOTFOUND THEN
			DBMS_OUTPUT.PUT_LINE('-- NOTFOUND --');
			EXIT;
		END IF;

		DBMS_OUTPUT.PUT_LINE(R_CUR.TABLE_NAME || ' - borrado');
		EXECUTE IMMEDIATE 'DROP TABLE ' || R_CUR.TABLE_NAME || ' CASCADE CONSTRAINT ';
		
	END LOOP;

	CLOSE C_CUR;
END;