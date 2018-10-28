/**
	
	Ejercicio 6

	Cree el trigger T_VERIFICAR_TRIPULACION que se deberá disparar antes de INSERTAR en la tabla TRIPULACIÓN, el cual deberá controlar lo siguiente: Se debe  impedir que se incorpore a la tripulación de un vuelo, una persona que ya tiene expirada su patente. 

	Por cada realización de vuelo puede haber un solo comandante.
	Sólo puede agregarse un miembro a la tripulación de un vuelo confirmado. En cualquier otro estado debe rechazarse la modificación.
**/


CREATE OR REPLACE TRIGGER T_VERIFICAR_TRIPULACION 
BEFORE INSERT ON tripulacion
DECLARE
	V_FECHA_EXPIRACION_PAT	DATE;
	V_COMANDANTE			VARCHAR(1); 	-- 1 Si el comandante esta activo
	V_ESTADO_VUELO			VARCHAR(1);	
BEGIN

	-- Retorna el personal a insertar en la tripulacion
	SELECT FECHA_EXPIR_PATENTE 
	INTO V_FECHA_EXPIRACION_PAT
	FROM personal p
	WHERE p.NRO_PERSONAL = :new.NRO_PERSONAL;

	-- Expiracion de patente del personal
	IF V_FECHA_EXPIRACION_PAT THEN
		RAISE_APPLICATION_ERROR (-20003, 'Este personal tiene expirada su patente, no es posible su asignacion a la tripulacion');
	END IF;


	-- Retorna el personal a insertar en la tripulacion
	SELECT COUNT(COMANDANTE), P.FECHA_EXPIR_PATENTE
	INTO V_COMANDANTE_ACTIVO
	FROM TRIPULACION T 
	INNER JOIN  REALIZACION_VUELO RV
	ON T.ID_VUELO = RV.ID_VUELO
	INNER JOIN PERSONAL P
	ON P.NRO_PERSONAL = T.NRO_PERSONAL
	WHERE T.ID_VUELO = :new.ID_VUELO
	GROUP BY P.NRO_PERSONAL;

	AND COMANDANTE = 'S';
	-- Un comandante por 
	IF V_COMANDANTE_ACTIVO > 1 THEN
		RAISE_APPLICATION_ERROR (-20004, 'Por cada realización de vuelo puede haber un solo comandante.');
	END IF;

	

	-- 

END;