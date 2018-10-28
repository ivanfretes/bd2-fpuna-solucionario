-- Ejercicio 4


CREATE OR REPLACE PACKAGE PKG_VUELO IS
	-- Tipo registro de plan vuelo
	TYPE T_REG_PLAN_VUELO IS RECORD (
		NRO_VUELO 				VARCHAR2(3),
		AEROPUERTO_SALIDA		VARCHAR2(7),  -- Id-ciudad-Id Aeropuerto
		AEROPUERTO_LLEGADA		VARCHAR2(7),  -- Id-ciudad-Id Aeropuerto
		FECHA_SALIDA_PROGRAMADA	DATE,
		HORAS_VUELO				NUMBER(4,2),
		CLASE					VARCHAR2(1),
		NRO_ASIENTO				NUMBER(3)
	);

	-- Tabla indexada compuerta de registro t_reg_plan_vuelo
	TYPE T_PLAN_VUELO IS TABLE OF T_REG_PLAN_VUELO
		INDEX BY BINARY_INTEGER;

	-- Recibe como parámetro un número de pasaporte, y retorna una variable con el nombre y apellido del pasajero
	FUNCTION  F_NOMBRE_PASAJERO (nro_pasaporte NUMBER) return VARCHAR2;

	/*
	Recibe un número de reserva, y devuelve una variable del tipo T_PLAN_VUELO con todos los tramos con estado confirmado (‘C’), correspondiente a la reserva
	*/
	FUNCTION  F_DEVOLVER_PLAN_VUELO(nro_reserva NUMBER) return T_PLAN_VUELO;


	/*
	Recibe como parámetros un id de vuelo  y una clase, y devuelve un número con la cantidad de pasajeros  embarcados para dicho id de vuelo y clase
	*/
	FUNCTION F_VERIFICAR_PASAJEROS(vuelo_id VARCHAR2, clase_area VARCHAR2(1)) return NUMBER;	


	/*
	Recibe como parámetro  el id de escala, una fecha y una clase. La función determina si existen aún asientos libres para dicha escala, fecha y clase, devolviendo un número con la cantidad de asientos libres.

	Para ello deberá considerar la cantidad de asientos por cada clase (de acuerdo al aparato asignado al vuelo al que pertenece dicha escala: Clase 1C (Primera clase), corresponde a la clase ‘E’ –Ejecutiva-, en tanto que a la clase 2C (Segunda clase), corresponde la clase ‘T’ –Turista-), y restar el número de reservas que están en estado Confirmado. 
	
	*/
	FUNCTION F_DETERMINAR_DISPONIBILIDAD(escala_id NUMBER, fecha_consulta DATE, clase_area VARCHAR2 ) RETURN NUMBER ;
END;

CREATE OR REPLACE PACKAGE BODY PKG_VUELO IS
BEGIN
	...
END;
