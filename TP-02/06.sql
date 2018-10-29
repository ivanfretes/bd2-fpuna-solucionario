/**
	
	Ejercicio 6

	Cree el trigger T_VERIFICAR_TRIPULACION que se deberá disparar antes de INSERTAR en la tabla TRIPULACIÓN, el cual deberá controlar lo siguiente: Se debe  impedir que se incorpore a la tripulación de un vuelo, una persona que ya tiene expirada su patente. 

	Por cada realización de vuelo puede haber un solo comandante.
	Sólo puede agregarse un miembro a la tripulación de un vuelo confirmado. En cualquier otro estado debe rechazarse la modificación.
**/


CREATE OR REPLACE TRIGGER T_VERIFICAR_TRIPULACION 
BEFORE INSERT ON tripulacion
DECLARE

	CURSOR CUR_VERIFICAR_TRIPULACION IS
		SELECT T.COMANDANTE, P.FECHA_EXPIR_PATENTE, RV.ESTADO
		FROM TRIPULACION T 
		INNER JOIN  REALIZACION_VUELO RV
		ON T.ID_VUELO = RV.ID_VUELO
		INNER JOIN PERSONAL P
		ON P.NRO_PERSONAL = T.NRO_PERSONAL
		WHERE T.ID_VUELO = :new.ID_VUELO;

	V_DIF_FECHA_TMP		NUMBER;

BEGIN
	FOR reg_verificar IN CUR_VERIFICAR_TRIPULACION LOOP

		V_DIF_FECHA_TMP := TRUNC(SYSDATE) - TRUNC(reg_verificar.FECHA_EXPIR_PATENTE);
		IF V_DIF_FECHA_TMP >= 0 THEN
			RAISE_APPLICATION_ERROR (-20003, 'Este personal tiene expirada su patente, no es posible su asignacion a la tripulacion');
		END IF;

		IF reg_verificar.COMANDANTE = 'S' THEN
			RAISE_APPLICATION_ERROR (-20004, 'Por cada realización de vuelo puede haber un solo comandante.');
		END IF;	

		IF reg_verificar.ESTADO != 'C' THEN
			RAISE_APPLICATION_ERROR (-20005, 'Sólo puede agregarse un miembro a la tripulación de un vuelo confirmado. ');
		END IF;	

	END LOOP;
END;