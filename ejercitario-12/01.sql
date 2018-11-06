/*
	Ejercicio 1

	Cree el procedimiento P_ABM_AREAS. El procedimiento deberá recibir los siguientes parámetros:
	
		- Id del área
		- Nombre del área
		- Id_area superior
		- Operación (A, B, M)
	
	Cree 3 funciones internas que se encargarán de la modificación, borrado y alta respectivamente. Cada función deberá prever las excepciones (clave inexistente, clave duplicada, etc). También prevea posibles excepciones en el procedimiento principal.
	
	Tenga en cuenta lo siguiente:
		- Sólo el ID área y el código de operación son obligatorios
		- Si el código de operación es diferente a ‘A’,’B’ o ‘M’ se deberá levantar (raise) un mensaje de error (utilizar los rangos habilitados por el ORACLE).
*/

CREATE OR REPLACE PROCEDURE P_ABM_AREAS(
	pOperacion 	VARCHAR2 NOT NULL
	pIdArea 	NUMBER NOT NULL,
	pnombreArea  	VARCHAR2,
	pAreaSuperior 	NUMBER
)	
AS
	-- Crea un area
	FUNCTION F_ADD_AREA(
		pIdArea		NUMBER,
		pNombreArea	VARCHAR2,
		pAreaSuperior	NUMBER
	) RETURN BOOLEAN AS
	BEGIN
		INSERT INTO B_AREAS(ID, NOMBRE_AREA, FECHA_CREA, ACTIVA, ID_AREA_SUPERIOR)
		VALUES (pIdArea, pNombreArea, SYSDATE, 'S', pIdAreaSuperior);
		COMMIT;
		
		RETURN TRUE;

	EXCEPTION
		WHEN OTHERS
			DBMS.OUTPUT.LINE(SQLERRM);
			RETURN FALSE
	END;


	-- Exception
	-- Operacion no disponible
	E_OPER_NO_DISPONIBLE EXCEPTION;


	-- Edita un area
	FUNCTION F_MOD_AREA(
	            pIdArea         NUMBER,
	            pNombreArea     VARCHAR2,
	            pAreaSuperior   NUMBER
	    ) RETURN BOOLEAN
		AS
		BEGIN
			SELECT * 
			FROM B_AREAS 
			WHERE pNombreArea IN NOMBRE_AREA;
			
			UPDATE B_AREAS SET 
				ID = pIdArea, 
				NOMBRE_AREA = pNombreArea, 
				FECHA_CREA = SYSDATE, 
				ACTIVA = 'S', 
				ID_AREA_SUPERIOR = pIdAreaSuperior;
			COMMIT;

			RETURN TRUE;
		EXCEPTION
			WHEN OTHERS
				DBMS.OUTPUT.LINE(SQLERRM);
				RETURN FALSE
	END



	-- Elimina un Area
	FUNCTION F_DEL_AREA( pIdArea NUMBER ) RETURN BOOLEAN
		AS
		BEGIN
			DELETE FROM B_AREAS 
			WHERE ID = pIdArea;
			COMMIT;

			RETURN TRUE;
		EXCEPTION
			WHEN OTHERS
				DBMS.OUTPUT.LINE(SQLERRM);
				RETURN FALSE;
	END
	
BEGIN

	IF pOperacion = 'A' THEN
		F_ADD_AREA(pIdArea, pNombreArea, pAreaSuperior);
	ELSIF pOperacion = 'M' THEN
		F_MOD_AREA(pIdArea, pNombreArea, pAreaSuperior);
	ELSIF pOperacion = 'D'  THEN
		F_DEL_AREA(pIdArea);
	ELSE
		RAISE E_OPER_NO_DISPONIBLE;
	END IF;

EXCEPTION
	WHEN E_OPER_NO_DISPONIBLE THEN
		DBMS_OUTPUT.PUT_LINE ('utilizar los rangos habilitados por el ORACLE');
	WHEN OTHERS
		DBMS.OUTPUT.LINE(SQLERRM);
		RETURN FALSE;
END;
