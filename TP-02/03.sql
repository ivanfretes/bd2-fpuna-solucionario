/**
	Ejercicio 3

	Cree el procedimiento P_POBLAR_IATA que leerá la tabla plana “IATA”, e insertará los países y ciudades. Tenga en cuenta que el nombre y código del país se repite por cada ciudad. 
**/

CREATE OR REPLACE PROCEDURE P_POBLAR_IATA
IS
	CURSOR C_PAIS IS SELECT ID_PAIS, NOMBRE_PAIS
		FROM IATA
		GROUP BY ID_PAIS, NOMBRE_PAIS;

	CURSOR C_CIUDAD IS SELECT ID_CIUDAD, NOMBRE_CIUDAD, ID_PAIS
		FROM IATA;

BEGIN

	-- Inserta en la tabla paises
	FOR reg_pais IN C_PAIS LOOP
		INSERT INTO pais (ID_PAIS, NOMBRE_PAIS) 
		VALUES (reg_pais.ID_PAIS, reg_pais.NOMBRE_PAIS);
		COMMIT;
	END LOOP;

	-- Inserta en la table ciudades
	FOR reg_ciudad IN C_CIUDAD LOOP
		INSERT INTO ciudad (ID_PAIS, ID_CIUDAD, NOMBRE_CIUDAD) 
		VALUES (reg_ciudad.ID_PAIS, reg_ciudad.ID_CIUDAD, reg_ciudad.NOMBRE_CIUDAD) ;
		COMMIT;
	END LOOP;

EXCEPTION
	WHEN OTHER THEN
		DBMS_OUTPUT.PUT_LINE('Se produjo un error inesperado en la insercion');
END;