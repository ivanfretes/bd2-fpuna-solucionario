
#INTRODUCCION A PL/SQL#

### REFERENCIAS ###
	* Valores entre [], son opcionales
	* Valores entre (), son demostrativos
	* Valores que se declaran dentro de bloques anonimos y/o se pasan como parametro en  funciones, procedimientos, solo tienen el scope(alcance) de su bloque.



-- VISUALIZAR SALIDA EN CONSOLA --
	SET SERVER OUTPUT ON

-- IMPRIMIR EN CONSOLA --
	DBMS_OUTPUT.PUT_LINE( MSG );

-- DECLARACION DE VARIABLES --
	-- Opcional inicializar con un valor por defecto | mediante DEFAULT
	-- Inicialice las constantes y variables designadas como NOT NULL
	variable [ CONSTANT ]	TIPO_DE_DATO 	[NOT NULL] :=  value | DEFAULT expr;


	-- Declaracion de una variable, con el mismo tipo de datos que otra
	-- Tambien se le puede asignar valores por defecto
	variable 					tabla_name.campo_name%TYPE;
	-- Asignar valores, del tipo registro
	variable_registro			table_name.%ROWTYPE


-- TIPO DE DATOS BASICOS, VALORES ENTRE PARENTESIS
	- BINARY_INTEGER 
	- NUMBER (10)
	- CHAR (30) 
	- LONG
	- VARCHAR2(50)
	- DATE
	- BOOLEAN


-- TIPO DE BLOQUES --
	-- PL SQL Anonimo
		DECLARE -- opcional
			var_tmp varchar
			...
		BEGIN
			..
		[ EXCEPTION ] -- opcional
			..
		END;



	-- PROCEDIMIENTO
		PROCEDURE nombre
		IS
			-- OPCIONAL declaracion de variables, sin DECLARE
			var_tmp varchar
			...
		BEGIN
			...
		[ EXCEPTION ] -- optional
			...
		END;


	-- FUNCIÓN
		FUNCTION nombre
		RETURN TIPO_DE_DATO
		IS
			-- OPCIONAL declaracion de variables, sin DECLARE
			var_tmp varchar
			...
		BEGIN
			...
		[ EXCEPTION ] -- optional
			...
		END;



### CONSTRUCCION DE PROGRAMAS ###
	- Procedimiento Almacenado, Funcion o Bloque Anonimo -> para declarar
	- Triggers de aplicacion, dentro del BEGIN
	- Triggers de la base de datos en EXCEPTION
	- Procedimientos internos, funciones internas dentro del BEGIN
	- Paquetes en la excepción



-- OPERADORES EN PL/SQL --
	- Incremento
		v_count 	:= v_count + 1;

	- Logico 
		Es_igual 	:= (v_n1 = v_n2);
		v_valido 	:= (emp_id is NOT NULL); -- valida una columna


-- CONTROL DE FLUJO --
	-- SELECCION --
		-- SI/IF
		IF condition THEN
			...
		[ELSIF] condition THEN
			...
		[ELSE]
			...
		END IF;

		-- SWICTH / CASE  con valor
		CASE variable_a_analizar
			WHEN valor  THEN 
				...
			WHEN valor2 THEN
				...
			ELSE
				...
		END CASE;

		-- SWICTH / CASE  con CONDICION
		CASE 
			WHEN condicion  THEN 
				...
			WHEN condicion2 THEN
				...
			ELSE
				...
		END CASE;


	-- ITERACION --
		-- Loop infinito
		LOOP
			...
			EXIT [WHEN condicion];
		END LOOP;


		-- FOR .. LOOP
		-- variable indice, no se declara, es inplicita
		-- Para indicar un rango de iteracion 1..10
		-- Tambien puedo asignarle un arreglo en vez del rango
		-- Reverse se implementa para revertir en orden descendente
		FOR indice IN 1..10  [REVERSE] LOOP
			...
		END LOOP;


		--WHILE ... LOOP
		-- Aconsejable utilizar una condicion para terminar el loop
		WHILE condicion WHEN
			...
		END LOOP;


-- RECUPERAR DATOS / SELECT .. INTO --
	-- La clausula INTO, indican a las variables que tomaran los datos  en tiempo de ejecucion
	-- Recupera una sola fila
	-- Donde nombre de registro es un dato del tipo registro
	-- Declarar el select en el BEGIN, solo sirve para asignar a variables
	-- Columna y variables con nombres distintos
	-- Nombre de tablas distintos a nombre de columnas
	-- Solo retornar los datos de una tabla, no relacionar
	SELECT campo1, campo2, campo3 INTO var1,var2,var3 | nombre_de_registro
	FROM tabla
	WHERE condicion; -- &v_dept_id // insertar en tiempo de ejecucion



	-- MANEJO DE ERRORES
		-- Debemos recuperar una fila, en caso que no exista- ERROR
			NO_DATA_FOUND( ORACLE ORA-01403 )
		-- ERROR al recuperar más de una FILA
			TOO_MANY_ROWS ( ORACLE ORA-01422 )





-- ** CURSORES ** --
	-- Generados por una sentencia SELECT

	-- TIPO DE CURSORES
		- Implicitos: declarados automaticamentes. Los utilizados por ORACLE BASE
		- Explicito: Declarados por el programador, retornan registros


	-- DECLARACION 
		-- No debe incluir la clausula INTO dentro del SELECT
		-- Puede definirse en el DECLARE como en el BEGIN 
		CURSOR nombre_cursor IS
		SELECT campo1, campo2 FROM 
		FROM tabla 
		INNER JOIN table2
		ON tabla.id = table2.id;

		-- Cursores con Parametro
		CURSOR nombre_cursor(
			parametro1	TIPO_DE_DATO, .. , parametroN TIPO_DE_DATO
		) IS
		SELECT campo1, campo2 FROM 
		FROM tabla 
		INNER JOIN table2
		ON tabla.id = table2.id;
		WHERE table.id = parametro1		

		-- Apertura
		OPEN nombre_cursor;

		-- Lectura/ recuperacion de datos de un cursor, de cada registro
		-- Un FETCH por registro
		FETCH nombre_cursor INTO variable1, variable2, .. , variableN;

		-- Cierre del CURSOR
		-- Operaciones, cuando el cursor es cerrado, daran INVALID_CURSOR error
		CLOSE nombre_cursor;


		-- Atributos / Validaciones y/o metodos de un cursor
		%ISOPEN 	-- Si esta abierto, returna (TRUE)
		%NOTFOUND 	-- Fetch no retorna registro / fila retorna (TRUE)
		%FOUND 		-- Fetch retorna registro / (TRUE)
		%ROWCOUNT	-- Cantidad de Filas aumentado en cada iteracion / retorna (NUMBER)

			-- Ejemplos 
			IF nombre_cursor%NOTFOUND THEN
				...
			END IF;


		-- Asignacion de un CURSOR a un REGISTRO, no en "FOR LOOP"
			nombre_registro  	nombre_cursor%ROWTYPE;


			-- APARA EL "FOR LOOP" 
				-- No declarar la variable nombre_registro (implicito)
				-- No hacer OPEN, FETCH ni CLOSE (implicitos)
				-- Variable de ambito registro_en_loop solo para el LOOP
				-- En otro iterador, si hay que declarar la variable
				FOR registro_en_loop in nombre_cursor LOOP
					...
				END LOOP;



			-- Subqueries como CURSOR Implicito en un FOR LOOP
				FOR registro_en_loop in ( SELECT campo,
										  FROM tabla 
										  WHERE condicion
										 ) LOOP
					...
				END LOOP; -- Close implicito


		-- Actualizacion de datos con un CURSOR, (Para actualizar)
		-- Utiliza "FOR UPDATE"
			CURSOR nombre_cursor IS
			SELECT campo1 FROM table FOR UPDATE;

			-- Lectura del cursor (Ejemplo)
			-- con la funcion ROUND() 
			-- Fila actual del CURSOR explicito "WHERE CURRENT OF nombre_cursor"
			FOR registro_en_loop in nombre_cursor LOOP
				UPDATE table
				SET campo := ROUND(campo * 20)
				WHERE CURRENT OF nombre_cursor;
			END LOOP;
			COMMIT;


#PROCEDIMIENTOS Y FUNCIONES#
	-- REFERENCIAS --
		- Para procedimientos y funciones locales no es necesario utilizar la palabra CREATE OR REPLACE, solo PROCEDURE | FUNCTION
		- La funcion se define entre el [ IS y el BEGIN ]


	-- PROCEDIMIENTOS --
		-- Un procedimiento, puede o no tener parametro
		-- No se usa DECLARE, para declarar variables
		-- Debe ejecutarse como una sentencia SQL
		-- No contiene un RETURN
		-- Puede retornar un valor, parametros OUT

		-- Sin parametros
			CREATE OR REPLACE nombre_procedimiento
			IS 
			-- Aqui podemos declarar variables
			BEGIN
				...
			END nombre_procedimiento;


		--	Con parametros
			-- Tipos de parametros
				* IN argumento 		
				-- Parametros pasados por refencia al programa - por defecto, no es necesario especificar
				-- El scope del valor es dentro del bloque 

				-- Ejemplo
					CREATE OR REPLACE PROCEDURE nombre_procedimiento (
						-- ejemplo default, tambie se puede asignar := valor
						variable1		IN 	NUMBER DEFAULT 100000, 
						variable2		IN  NUMBER
					) IS
					BEGIN
						...
					END nombre_procedimiento;

				* OUT argumento 
				-- Parametros pasados por valor
				-- debe especificarse
					CREATE OR REPLACE PROCEDURE nombre_procedimiento (

					) IS
					BEGIN

				* IN OUT argumento 	
				-- Parametros pasados por valor
				-- NOCOPY, indica explicitamente que el parametro  sera por referencia
				CREATE OR REPLACE PROCEDURE uso_nocopy(
					variable IN OUT NOCOPY NUMBER
				) IS  ...

			-- Notacion Posicional y Notacion Nominal
				-- Si la declaracion formal del procedimiento P1 fuera
					PROCEDURE P1 (p_par1 number, p_par2 number);
				-- Se puede invocar al procedimiento en un bloque
					P_PROCEDIMIENTO(p_par1 => 10, p_par2 =>3);


	-- FUNCIONES --
		-- Se puede incluir como parte de otra expresion SQL
		-- Debe contener un RETURN 
		-- Se require privilegios de EXECUTE
		-- Si se usa en SQL, no utilizar sentencias DML dentro
		* IN argumento es el unico tipo de parametro
		CREATE OR REPLACE nombre_function(
			parametro TIPO_DE_DATO,
			... ,
			parametroN TIPO_DE_DATO,
		) 
		IS 
			variable TIPO_DE_DATO;
		BEGIN
			...
			RETURN variable;
		END;



	-- Eliminacion de Procedimientos y funciones
		DROP PROCEDURE nombre_procedimiento;
		DROP FUNCTION nombre_funcion;

	-- PARA PODER VER LAS DEPENDENCIAS
		- FROM USER_DEPENDENCIES
		- FROM ALL_DEPENDENCIES
		- FROM DBA_DEPENDENCIES


#	-- EXCEPCIONES#
	-- REFERENCIAS

		-- TIPO DE ERRORES
			-- Error de oracle predefinidos(Son unos 20)
			-- Errores de oracle no predefinidos
			-- Errores definidos por el usuario

		Ejemplo;
			EXCEPTION 
				WHEN exception1 THEN
					...
				WHEN exception2 THEN
					...
				WHEN OTHERS THEN
					...


			EXCEPTION
				WHEN NO_DATA_FOUND THEN
				-- No existen ventas, por lo tanto puedo borrar --
					DELETE FROM table
					WHERE condition;
					COMMIT;

				WHEN OTHERS THEN
					ROLLBACK;
					DBMS_OUTPUT.PUT_LINE ('Error inesperado ');



#	-- TIPO DE DATOS COMPUESTOS SQL#
	- Registros (RECORDS) -- CONJUNTO, parecido al %ROWTYPE pero no igual
	- Colecciones (TABLAS INDEXADAS) -- no es igual a una tabla de DB
		- CONTIENE UN INDICE DEL TIPO BINARY_INTEGER
		- COLUMNAS ESCALARES

	-- CREACION DE REGISTROS
		-- Se puede asignar un valor inicial y tambien como  NOT NULL;
		-- Por defecto los campos son NULL
		TYPE nombre_tipo_registro IS RECORD (
			campo1 		TIPO_DE_DATO [NOT NULL] | [:= X | DEFAULT Y], 
			campo2 		TIPO_DE_DATO
		);

			-- Definir una variable como registro
			variable 	nombre_tipo_registro;	


	-- TABLAS INDEXADAS O TABLAS ASOCIATIVAS
		-- Puede crecer dinamicamente 
		-- Contiene un indice de tipo BINARY_INTEGER, PLS_INTEGER o VARCHAR2
		-- Columnas del tipo escalar
		-- Se debe asignar un valor para que exista el indice
		-- Exclusivo de PL/SQL no se pueden utilizar en operaciones SELECT
		TYPE nombre_tabla_indexada IS TABLE OF TIPO_DE_DATO
		[NOT NULL] 
		INDEX BY BINARY_INTEGER;

			-- Declarando variable del tipo tabla indexada
			v_tabla_indexada	nombre_tabla_indexada;
			
			-- Cargando datos en la tabla indexada
			-- En v_tabla_indexada(INDICE)
			v_tabla_indexada(0) 	:= 	'valor1';
			v_tabla_indexada(1) 	:= 	'valor1';
			v_tabla_indexada(2) 	:= 	'valor1';

			-- Borrar todas las filas de la tabla
			v_tabla_indexada.DELETE;

			-- Ultimo valor del indice de la tabla
			v_tabla_indexada.LAST;


			-- Metodos de tablas indexadas
			- EXISTS(n) -- existe en el indice "n"
			- FIRST	 -- primer elemento
			- LAST	-- ultimo elemento
			- PRIOR(n)	-- Retorna el elemento preview a "n"
			- NEXT(n)	-- Retorna el elemento siguiente a "n"
			- COUNT -- Nro de elemento de las tabla
			- TRIM 	-- elimina un elemento del final de la tabla
			- TRIM(n) -- elimina n elemento al final de la tabla
			- DELETE -- Elimina todos loe elementos
			- DELETE(n) -- elimina el elemento "n"
			- DELETE(n,m) -- elimina elementos del rango


#PAQUETES#		

	-- REFERENCIAS --
		- La especificacion, solo contiene los objetos que se desean como publicos
		- Si se modifican los paquetes, hay que recompilar, porque las referencias quedan invalidas
		- Admite sobrecar de funciones y procedimientos

	--Almacenan separadamente en la DB
		-- Especificacion del paquete
			-- Las declaraciones de podran ser accedidos desde fuera del paquete
			-- La especificacion puede incluir PRAGMAS


		-- Cuerpo (body), el cual es opcional
			-- Desarrollo de los procedimientos y funciones que se especificaron
			-- Se pueden declarar funciones, procedimientos, etc privados


		-- CREACION DE LA ESPECIFICACION
			CREATE OR REPLACE PACKAGE nombre_paquete 
			[declaracion de los derechos del invocador]
			IS
				-- declaraciones, signatures de procedumientos , funciones, etc
				-- No se utiliza BEGIN - END
				PRODECUDE nombre_procedimiento (parametros);
				FUNCTION  nombre_funcion (parametros) return TIPO_DE_DATO;
				...
			END nombre_paquete;

		-- CREACION DEL CUERTPO DEL PAQUETE
			CREATE OR REPLACE PACKAGE BODY nombre_paquete
			IS
				PRODECUDE nombre_procedimiento (parametros) IS
					BEGIN 
						... -- implementaciones de las definiciones
					[EXCEPTION ]
						...
					END;
				END;

				FUNCTION  nombre_funcion (parametros) return TIPO_DE_DATO;
					BEGIN
						... -- implementaciones de las definiciones
					[EXCEPTION ]
						...
					END nombre_paquete;
				END;
			END;

		-- ELIMINAR UN PAQUETE
			-- Elimina la especificacion del paquete
			DROP PACKAGE nombre_paquete;

			-- Elimina el cuerpo de un paquete
			DROP PACKAGE BODY nombre_paquete;


		-- VISUALIZAR PAQUETES EN EL DICCIONARIO
			-- Especificacion o Cuerpo
			SELECT OBJECT_NAME, STATUS, CREATED
			FROM USER_OBJECTS
			WHERE OBJECT_TYPE = 'PACKAGE' | 'PACKAGE BODY';

			-- Visualizar el codigo fuente de los paquetes
			SELECT text
			FROM user_source
			WHERE name = 'nombre_paquete' AND type = 'PACKAGE' | 'PACKAGE BODY';


		-- EJEMPLO DE SOBRECARGA
		CREATE OR REPLACE PACKAGE nombre_paquete IS
			FUNCITON nombre_function (params) return NUMBER;
			FUNCTION nombre_function (param1, param2) return NUMBER;
		END;


		-- DECLARACION DE LOS SERVICIOS DEL INVOCADOR
			-- Afecta como Oracle resuelve la verificacion de objectos
				-- AUTHID CURRENT_USER, el paquete se ejecutara con los privilegios del usuario actual

				-- AUTHID DEFINER, indica que el paquete se ejecutara con el permiso del propietario del esquema en el que reside.
				CREATE OR REPLACE PACKAGE nombre_paquete 
				[AUTHID {CURRENT_USER | DEFINER}] IS
					...
				END;

	-- CONSIDERACIONES SOBRE EL USO DE MEMORIA
		-- AREA GLOBAL (SGA) - SHARED POOL, se usa para mantener el formato compilado de las unidades de programa almacenado.
		-- Cuando se invoca un subprograma de un paquete, la version compilada del paquete se carga en el shared pool
		-- Si otro usuario invoca a la misma unidad de programa, ya estara en memoria, hasta que el SGA se llene. Oracle utiliza LRU(least recently used). para liberar la memoria

	
		-- USO DEL PRAGMA serially_reusable
			- Variables y otros objectos de los paquetes consumen menmoria que corresponden a la session de usuario y permanecen durante toda la session aunque no se utilicen
			- Con el uso del PRAGMA serially_reusable el paquete no se guarda en cada area de memoria del usuario, sino en un solo lugar en la memoria global, permitiendo el uso por diferentes usuarios
			- Al termina el uso el area el liberada


	-- OCULTANDO EL CODIGO INTERNO DEL PAQUETE PL/SQL ( WRAPPER )
	  	- Convierte el codigo fuente en codigo objeto portable, independiente de la plataforma
	  	- Solo el cuerpo del paquete debe ser empaquetado
	  	- El wrap cuando se inicie desde .plb, creara la especificacion


	  		WRAP INAME=archivo_entrada
	  		ONAME=archivo_salida

	  	-- EJEMPLO
	  		-- Hacer wrap
	  		HOST WRAP INAME=../pack_b.sql -- se empaqueta el body
			ONAME=../pack_b.plb -- 

			-- Inicializar
			START ../pack_b.plb


#TRIGGERS#
	- Procedimientos almacanados que se ejecutan (disparan) cuando sucede algun evento DML (INSERT, UPDATE, DELETE)
	- Asociados a una tabla específica y son implicitamente ejecutados, cuando se modifica algo en ella
	- No se deben definir triggers para operaciones controladas por integridad referencia (CASCADE) o constraint CHECK
	- No crear triggers que referencien a la misma tabla

	-- EJEMPLO:
		-- Operation: INSERT | UPDATE | DELETE
		-- No es necesario indicar los campos
		CREATE OR REPLACE TRIGGER nombre_trigger
		BEFORE | AFTER operation/s
		[OF campo, .. ,campoN] ON table_name
		REFERENCING new |old AS alias
		[FOR EACH ROW] [WHEN condition] 
		DECLARE 
		BEGIN
			...
		END;

	-- Para identificar que operacion se realiacion
		IF INSERTING | DELETING | UPDATING  THEN


	-- CLAUSULA FOR EACH ROW
		- Si no se ejecuta for each row, el trigger se dispara una unica vez

	-- IDENTIFICADORES :old Y :new
		-- Se refieren a las columnas de la tabla sobre la que se dispara el trigger
			:new.ID -- puede estar disponible en una operacion de delete
			:old -- no estara disponible en una operacion de insert


	--  Ejemplo de creacion de un paquete
		CREATE OR REPLACE TRIGGER cant_empleados_jefe_tggr 
		AFTER INSERT OR UPDATE ON B_EMPLADOS
		FOR EACH ROW WHEN (NEW.CEDULA_JEFE IS NOT NULL)
		IS
		DECLARE
			V_CANT	NUMBER;
		BEGIN
		
			SELECT COUNT(CEDULA) INTO V_CANT FROM B_EMPLEADOS
			WHERE CEDULA_JEFE = :NEW.CEDULA_JEFE; 
			
			IF NVL(V_CANT, 0) > 0 THEN
				RAISE_APPLICATION_ERROR(-20001, 'El')
			END IF;
			
		END;
	
	-- Trigger de sustitucion (instead of)
		- Para aplicar un trigger de sustitucion, la vista debe ser modificable, es decir, no debe contener operaciones de agregacion, o multiples filas
			-  (SUM, AVG, GROUP BY, COUNT) operaciones de conjunto (UNION, MINUS), o el operador DISTINCT
			
	-- Es ideal definir las funciones, siempre en el DECLARE o antes del BEGIN
		
	
#TRIGGERS DEL SISTEMA#
	-- Disparadores que se ejecutan cuando ocurre un evento en el sistema
	-- Se requiere privilegio de SYSDBA, para crear triggers del sistema
	-- CREATE ANY TRIGGER: Permite crear disparadores en cualquier esquema
	CREATE OR REPLACE TRIGGER nombre_trigger
	BEFORE | AFTER [evento or ..  or eventoN]   -- Evento LOGON
	ON [SCHEMA | DATABASE]
	DECLARE
		...
	BEGIN
		...
	END nombre_trigger;
	

#SQL DINAMICO#
	-- REFERNCIAS --
		- Permite crear sentencias SQL, cuya estructura puede cambiar en el momento de ejecucion
		- Se construye y almacena como string
		- Permite la definicion de sentencias  de definicion DDL, y el control de datos (DC) o de control de sesion
		- No se pueden crear variable del tipo cursor en una especificacion de paquete
		- No se puede utilizar un cursor variable en un bucle FOR LOOP.
	
	-- Todas las sentencias pasan por los siguientes pasos, SQL Estatico
		- Parsing (Verificacion de sintaxis)
		- Binding (Se enlazan las variables)
		- Execution (Ejecuta la sentencia)
		- Fetching (Si existen consultas, se seleccionan y se recuperan en filas restantes - Lectura)
		
	
	-- Maneras de ejecutar SQL Dinamico en PL/SQL
		- Utilizando SQL dinamico nativo
		- Utilizando el paquete DBMS_SQL
		
		-- Utilizando sql dinamico 
			- EXECUTE INMEDIATE -- para sentencias SQL y PL/SQL anonimos
			- CURSORES variables (OPEN FOR)


		-- Ejemplos
			EXCECUTE INMEDIATE sentencia_sql_dinamica  
			[ INTO variable, ..., variableN ]
			[ USING [IN | OUT | IN OUT ] variable_enlace
			[ RETURNING | RETURN ] INTO variable1, ... variableN 


		-- Ejecutando sentencias DDL
			-- En SQL Dinamico la sentencia, que se creara no termina en ';'
			-- Para consultas que devuelven mas de una fila utilizar cursores con (OPEN FOR ...)

			-- Ejemplo 1
			DECLARE
				v_string VARCHAR2(200);

				sentencia VARCHAR2(200);
				type r_emp is record(
					id number, nombre varchar2(30)
				);
				emp_rec = r_emp;
			BEGIN

				-- DDL - Creacion y Eliminando tabla
				v_string := 'DROP TABLE B_PLAN_PAGO';
				EXECUTE INMEDIATE v_string;

				EXECUTE INMEDIATE 'CREATE TABLE dept (ID NUMBER, nombre varchar2(30))';

				-- Binding de variables
				sentencia := 'INSERT INTO dapt VALUES(:1,:2)';
				EXECUTE INMEDIATE sentencia USING 10, 'Administracion';


				-- Cargando en un tipo de dato
				EXECUTE INMEDIATE sentencia INTO emp_rec USING 10;

				-- Ejecutando PL/SQL Dinamicamente
				-- LLama a un procedimiento almacenado
				EXECUTE 'BEGIN P_INS_AREA(:a, :b); END;' USING IN OUT 10, 't';
			END;

	-- CURSOR DINAMICO
		- Semejante a un cursor estatico, pero apunta a la localizacion de momeria, se define un puntero a dicha area en lugar de asignar explicitamente

		-- Modo de utilizacion
			- Definir el tipo de dato
			- Declara variable con el tipo de dato
			- Abrir la variable de tipo cursor, especificando el query
			- Recuperar datos (FETCH)
			- Cerrar Cursor

		DECLARACION:
			DECLARE
				TYPE c_cur IS REF CURSOR 
				RETURN tabla%rowtype;

				emp_cur c_cur;
				emp_reg tabla%rowtype;

			BEGIN
				OPEN emp_cur FOR SELECT * FROM tabla;
				FETCH emp_cur INTO emp_reg;
				DBMS_OUTPUT.PUT_LINE(emp_reg.nombre);
				CLOSE emp_cur;
			END;

		-- Tipo de cursores dinamicos
			-- Tipado Estricto
			TYPE nombre_cursor IS REF CURSOR RETURN tabla%rowtype;

			-- Tipado Debil
			TYPE nombre_cursor IS REF CURSOR;



#-- SQL DINAMICO UTILIZANDO DBMS_SQ#
	-- Pasos a seguir;
		- OPEN_CURSOR / Abrir el cursor
		- Se analiza la cadena / DBMS_SQL.PARSE
		- Binding de variables / DBMS_SQL.BING_VARIABLE
		- Si la instruccion es DML o DDL, ejecutar mediante DBMS_SQL.EXECUTE
		- En caso de un SELECT, se definen los elementos previamente con una lista de seleccion
		- Se devuelven los resultados en variable PL/SQL (COLUMN_VALUE)
		- Se cierra el cursor (CLOSE_CURSOR)




