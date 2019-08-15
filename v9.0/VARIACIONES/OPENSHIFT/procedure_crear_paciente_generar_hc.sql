DELIMITER $$
CREATE PROCEDURE procedure_crear_paciente_generar_hc(
    IN nombresIn VARCHAR(35),
    IN apellidosIn VARCHAR(35),
    IN fechaNacimientoIn DATE,
    IN edadIn INT,
    IN sexoIn ENUM('Femenino', 'Masculino'),
    IN lugarNacimientoIn VARCHAR(150),
    IN direccionIn VARCHAR(150),
    IN ocupacionIn ENUM('Estudiante', 'Empleado', 'Ama de casa', 'Otro'),
    IN nivelEducativoIn ENUM('Básica', 'Bachillerato', 'Universitario', 'Maestría', 'Otro'),
    IN estadoCivilIn ENUM('Soltero', 'Acompañado', 'Casado', 'Divorciado', 'Viudo'),
    IN duiIn CHAR(10),
    IN idPerfilIn INT,
    OUT idPacienteOut INT
    )
BEGIN	
	SET @ANIO_ACTUAL:=(SELECT YEAR(NOW())); #RECUPERAMOS EL ANIO ACTUAL (BRINDADO POR EL SISTEMA)
	SET @ANIO_ACTUAL_SUB_CADENA:=(SELECT RIGHT(@ANIO_ACTUAL, 2)); #EXTRAEMOS LOS DOS ULTIMOS DIGITOS
    
    SET @ACRONIMO:=(SELECT acronimo FROM perfiles WHERE id = idPerfilIn); #RECUPERAMOS EL ACRONIMO DE ACUERDO AL PERFIL SELECCIONADO
    
    #CONSTRUIMOS EL CORRELATIVO
    #RECUPERAMOS EL identificador_hc MAXIMO (NO EL ULTIMO SI NO EL MAYOR) DE ACUERDO PERFIL SELECCIONADO
    #CON EL LIKE LOGRAMOS DIFERENCIAS EL ANIO (LO QUE NOS PERMITE REINICIAR EL CORRELATIVO)
    SET @HC_MAXIMO:=(SELECT MAX(identificador_hc) FROM pacientes WHERE id_perfil = idPerfilIn AND identificador_hc LIKE CONCAT(@ANIO_ACTUAL_SUB_CADENA, '%') LIMIT 1);
    
    IF @HC_MAXIMO IS NULL THEN
        #CREAMOS EL PRIMER REGISTRO
        SET @CORRELATIVO:=(SELECT LPAD('1', 4,'0')); #CONSTRUIMOS EL CORRELATIVO CON CUATRO POSICIONES Y RELLENAMOS CON CEROS A LA IZQUIERDA
    	SET @HC_NUEVO:=(SELECT CONCAT(@ANIO_ACTUAL_SUB_CADENA, @ACRONIMO, @CORRELATIVO));
        
    	INSERT INTO pacientes VALUES 
        (NULL, nombresIn, apellidosIn,
        fechaNacimientoIn, edadIn, sexoIn,
        lugarNacimientoIn, direccionIn, ocupacionIn,
        nivelEducativoIn, estadoCivilIn, duiIn,
        idPerfilIn, @HC_NUEVO);

        SET idPacienteOut = (SELECT id FROM pacientes WHERE identificador_hc = @HC_NUEVO LIMIT 1);
    ELSE
        #CREAMOS OTRO REGISTRO NUEVO
    	#EXTRAEMOS COMO CADENA LOS NUMEROS
		SET @HC_MAXIMO_SUB_CADENA:=(SELECT RIGHT(@HC_MAXIMO, 4));
        
        #CONVERTIMOS A ENTERO (SE PIEDEN LOS CEROS A LA IZQUIERDA)
        SET @HC_MAXIMO_ENTERO:=(SELECT CAST(@HC_MAXIMO_SUB_CADENA AS UNSIGNED));
        
    	IF @HC_MAXIMO_ENTERO < 9999 THEN        	
        	SET @CANTIDAD:=(@HC_MAXIMO_ENTERO + 1);  #INCREMENTAMOS PARA EL NUEVO REGISTRO
            SET @CORRELATIVO:=(SELECT LPAD(@CANTIDAD, 4,'0')); #CONSTRUIMOS EL CORRELATIVO CON CUATRO POSICIONES Y RELLENAMOS CON CEROS A LA IZQUIERDA SI ES NECESARIO
            SET @HC_NUEVO:=(SELECT CONCAT(@ANIO_ACTUAL_SUB_CADENA, @ACRONIMO, @CORRELATIVO));
        
    	    INSERT INTO pacientes VALUES 
            (NULL, nombresIn, apellidosIn,
            fechaNacimientoIn, edadIn, sexoIn,
            lugarNacimientoIn, direccionIn, ocupacionIn,
            nivelEducativoIn, estadoCivilIn, duiIn,
            idPerfilIn, @HC_NUEVO); 

            SET idPacienteOut = (SELECT id FROM pacientes WHERE identificador_hc = @HC_NUEVO LIMIT 1);  
        END IF;
    END IF;
END
$$
DELIMITER ;