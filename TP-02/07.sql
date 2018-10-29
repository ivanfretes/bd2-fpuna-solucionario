/**
	
	Ejercicio 7
	Cree el trigger T_CONTROL_PASAJEROS que deberá dispararse antes de INSERTAR o MODIFICAR en la tabla PASAJEROS_VUELO. El trigger deberá controlar lo siguiente:

	- Sólo se puede agregar un pasajero si la fecha de salida programada coincide con la fecha de partida real de ese vuelo y escala. En caso contrario deberá dar error
	- Sólo se puede agregar un pasajero cuya reserva está confirmada, y también si el vuelo está confirmado. En caso contrario, dará error.
	- No se puede permitir la asignación de  más de un pasajero al mismo asiento y clase. Deberá dar error en caso que así sea, previendo el inconveniente de tabla mutante.

**/

CREATE OR REPLACE TRIGGER  T_CONTROL_PASAJEROS 
BEFORE INSERT OR UPDATE ON PASAJEROS_VUELO
DECLARE
	CURSOR CUR_CONTROL_PASAJEROS IS
	SELECT 
		RT.FECHA_SALIDA_PROGRAMADA FECHA_SALIDA,
		RT.ESTADO	ESTADO_RESERVA,
		RV.HORA_PARTIDA_REAL FECHA_REAL,
		RV.ESTADO ESTADO_VUELO,
		PV.NRO_ASIENTO,
		PV.CLASE
	FROM PASAJEROS_VUELO PV
	INNER JOIN REALIZACION_VUELO RV
	ON PV.ID_VUELO = RV.ID_VUELO
	INNER JOIN RESERVA_TRAMO RT
	ON RT.ID_ESCALA = PV.ID_ESCALA;

	reg_verificar  CUR_CONTROL_PASAJEROS%ROWTYPE;
BEGIN
	
	OPEN CUR_CONTROL_PASAJEROS;
	LOOP 
		FETCH CUR_CONTROL_PASAJEROS INTO reg_verificar;

		IF TRUNC(reg_verificar.HORA_REAL) = TRUNC(reg_verificar.FECHA_SALIDA) THEN
			RAISE_APPLICATION_ERROR (-20006, 'Sólo se puede agregar un pasajero si la fecha de salida programada coincide con la fecha de partida real de ese vuelo y escala.');
		END IF;


		IF reg_verificar.ESTADO_RESERVA != 'C' THEN
			RAISE_APPLICATION_ERROR (-20007, 'Sólo se puede agregar un pasajero cuya reserva está confirmada');
		END IF;	


		IF reg_verificar.ESTADO_VUELO != 'C' THEN
			RAISE_APPLICATION_ERROR (-20008, 'Vuelo debe estar confirmado');
		END IF;	

		IF reg_verificar.NRO_ASIENTO = :new.NRO_ASIENTO AND
			reg_verificar.CLASE = :new.CLASE THEN
			RAISE_APPLICATION_ERROR (-20009, 'Por cada realización de vuelo puede haber un solo comandante.');
		END IF;	
	END LOOP;
	CLOSE CUR_CONTROL_PASAJEROS;
END;