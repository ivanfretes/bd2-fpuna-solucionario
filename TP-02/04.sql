-- Ejercicio 4


CREATE OR REPLACE PACKAGE PKG_VUELO IS
	-- Tipo registro de plan vuelo
	TYPE T_REG_PLAN_VUELO IS RECORD (
		NRO_VUELO 				VARCHAR2(6),
		AEROPUERTO_SALIDA		VARCHAR2(7),  -- Id-ciudad-Id Aeropuerto
		AEROPUERTO_LLEGADA		VARCHAR2(7),  -- Id-ciudad-Id Aeropuerto
		FECHA_SALIDA_PROGRAMADA	DATE,
		HORAS_VUELO				NUMBER(4,2),
		CLASE					VARCHAR2(1),
		NRO_ASIENTO				NUMBER(3)
	);

	-- Tabla indexada compuesta de registro t_reg_plan_vuelo
	TYPE T_PLAN_VUELO IS TABLE OF T_REG_PLAN_VUELO
		INDEX BY BINARY_INTEGER;

	-- Recibe como parámetro un número de pasaporte, y retorna una variable con el nombre y apellido del pasajero
	FUNCTION  F_NOMBRE_PASAJERO (pasaporte_nro NUMBER) return VARCHAR2;

	/*
		Recibe un número de reserva, y devuelve una variable del tipo T_PLAN_VUELO con todos los tramos con estado confirmado (‘C’), correspondiente a la reserva
	*/
	FUNCTION  F_DEVOLVER_PLAN_VUELO(reserva_nro NUMBER) return T_PLAN_VUELO;


	/*
		Recibe como parámetros un id de vuelo  y una clase, y devuelve un número con la cantidad de pasajeros  embarcados para dicho id de vuelo y clase
	*/
	FUNCTION F_VERIFICAR_PASAJEROS(vuelo_id VARCHAR2, clase_area VARCHAR2) return NUMBER;	


	/*
		Recibe como parámetro  el id de escala, una fecha y una clase. La función determina si existen aún asientos libres para dicha escala, fecha y clase, devolviendo un número con la cantidad de asientos libres.

		Para ello deberá considerar la cantidad de asientos por cada clase (de acuerdo al aparato asignado al vuelo al que pertenece dicha escala: Clase 1C (Primera clase), corresponde a la clase ‘E’ –Ejecutiva-, en tanto que a la clase 2C (Segunda clase), corresponde la clase ‘T’ –Turista-), y restar el número de reservas que están en estado Confirmado. 
	
	*/
	FUNCTION F_DETERMINAR_DISPONIBILIDAD(escala_id NUMBER, fecha_consulta DATE, clase_area VARCHAR2 ) RETURN NUMBER ;
END;

CREATE OR REPLACE PACKAGE BODY PKG_VUELO IS
	FUNCTION  F_NOMBRE_PASAJERO (pasaporte_nro NUMBER) return VARCHAR2
		IS
			V_NOMBRE 	VARCHAR2(100);
		BEGIN
			SELECT NOMBRE || APELLIDO 
			INTO V_NOMBRE
			FROM PASAJERO
			WHERE NRO_PASAPORTE = pasaporte_nro;

			RETURN V_NOMBRE;
		END;


	FUNCTION  F_DEVOLVER_PLAN_VUELO(reserva_nro NUMBER) return T_PLAN_VUELO
		IS
			V_RESERVA_TRAMO T_PLAN_VUELO;

			CURSOR CUR_RESERVAS_TRAMO IS
				SELECT 
					E.NUMERO_VUELO,
					E.AEROPUERTO_SALIDA,
					E.AEROPUERTO_LLEGADA,
					R.FECHA_SALIDA_PROGRAMADA,
					E.HORAS_VUELO,
					R.CLASE,
					R.NRO_ASIENTO
				FROM VUELO_ESCALAS E 
				INNER JOIN RESERVA_TRAMO R
				ON E.ID_ESCALA = R.ID_ESCALA
				WHERE R.NRO_RESERVA = reserva_nro
				AND R.ESTADO = 'C';

			INDICE 	NUMBER 	:= 0;
		BEGIN

			V_RESERVA_TRAMO.DELETE;
			FOR reg_reserva_tramo IN CUR_RESERVAS_TRAMO LOOP
				V_RESERVA_TRAMO(INDICE).NRO_VUELO = reg_reserva_tramo.NUMERO_VUELO;
				V_RESERVA_TRAMO(INDICE).AEROPUERTO_SALIDA = reg_reserva_tramo.AEROPUERTO_SALIDA;
				V_RESERVA_TRAMO(INDICE).AEROPUERTO_LLEGADA = reg_reserva_tramo.AEROPUERTO_LLEGADA;
				V_RESERVA_TRAMO(INDICE).FECHA_SALIDA_PROGRAMADA = reg_reserva_tramo.FECHA_SALIDA_PROGRAMADA;
				V_RESERVA_TRAMO(INDICE).HORAS_VUELO = reg_reserva_tramo.HORAS_VUELO;
				V_RESERVA_TRAMO(INDICE).CLASE = reg_reserva_tramo.CLASE;
				V_RESERVA_TRAMO(INDICE).NRO_ASIENTO = reg_reserva_tramo.NRO_ASIENTO;

				INDICE := INDICE + 1;
			END LOOP;

			RETURN V_RESERVA_TRAMO;
		END;


	FUNCTION F_VERIFICAR_PASAJEROS(vuelo_id VARCHAR2, clase_area VARCHAR2) return NUMBER
		IS 
			V_CANT_PASAJEROS	NUMBER	:=	0;
		BEGIN
			SELECT COUNT(*)
			INTO V_CANT_PASAJEROS
			FROM PASAJEROS_VUELO
			WHERE CLASE = clase_area
			AND ID_VUELO = vuelo_id; 

			RETURN V_CANT_PASAJEROS;
		END;

	-- No culminada
	FUNCTION F_DETERMINAR_DISPONIBILIDAD(escala_id NUMBER, fecha_consulta DATE, clase_area VARCHAR2 ) RETURN NUMBER
		IS
			V_CANT_DISPONIBLE 	NUMBER;
		BEGIN

			SELECT 
				CASE R.CLASE
					-- CLASE EJECUTIVA
					WHEN 'E' THEN 
						AVE.CANT_PASAJEROS_1C - COUNT(R.ID_ESCALA)

					-- CLASE TURISTA
					ELSE 
						AVE.CANT_PASAJEROS_2C - COUNT(R.ID_ESCALA)
				END CANT_DISPONIBLES 
			INTO 
			V_CANT_DISPONIBLE
			FROM 
				( 	SELECT 
						T.CANT_PASAJEROS_1C,
						T.CANT_PASAJEROS_2C,
						E.ID_ESCALA
					FROM VUELO V
					INNER JOIN VUELO_ESCALAS E
					ON V.NUMERO_VUELO = E.NUMERO_VUELO
					INNER JOIN TIPO_APARATO A
					ON A.TIPO_APARATO = V.TIPO_APARATO 
				) AS  AVE -- APARATO VUELO ESCALA

			INNER RESERVA_TRAMO R
			ON AVE.ID_ESCALA = R.ID_ESCALA 
			WHERE R.FECHA_SALIDA_PROGRAMADA = TRUNC(fecha_consulta)
			AND R.CLASE = clase_area
			AND R.ID_ESCALA = escala_id
			AND R.ESTADO = 'C'
			GROUP BY R.CLASE;


			RETURN  V_CANT_DISPONIBLE;
		END;
END;
