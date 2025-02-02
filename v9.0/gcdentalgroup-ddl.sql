﻿##################################################################################
#TABLA CATALOGO
#CON ELLO SE DETERMINA DE QUE RUBRO LABORAL ES EL PACIENTE
#INDISPENSABLE PARA GENERAR EL HC DEL PACIENTE
CREATE TABLE perfiles(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    perfil VARCHAR(50) UNIQUE NOT NULL,
    acronimo char(2) UNIQUE NOT NULL #EMBEBIDO EN EL HC
);

##################################################################################
#INFORMACION BASICA DEL PACIENTE
CREATE TABLE pacientes (
  id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nombres varchar(35) NOT NULL,
  apellidos varchar(35) NOT NULL,
  fecha_nacimiento date NOT NULL,
  edad int unsigned NOT NULL,
  sexo enum('Femenino','Masculino') NOT NULL,
  lugar_nacimiento varchar(150),
  direccion VARCHAR(150) NOT NULL,
  ocupacion enum('Estudiante', 'Empleado', 'Ama de casa', 'Otro') NOT NULL,
  nivel_educativo enum('Básica', 'Bachillerato', 'Universitario', 'Maestría', 'Otro') NOT NULL,
  estado_civil enum('Soltero', 'Acompañado', 'Casado', 'Divorciado', 'Viudo') NOT NULL,
  dui char(10) UNIQUE DEFAULT NULL, #OPCIONAL

  id_perfil INT NOT NULL,
  identificador_hc VARCHAR(8) NOT NULL UNIQUE,
  
  FOREIGN KEY (id_perfil) REFERENCES perfiles(id) 
);

#TABLA CATALOGO
CREATE TABLE tipos_correos_pacientes (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    tipo_correo varchar(25) NOT NULL UNIQUE
);

#CORREOS DE LOS PACIENTES
#NO SE CONSIDERARON RESTRICCIONES DE CORREOS REPETIDOS POR PACIENTE
CREATE TABLE correos_pacientes (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    correo varchar(250) NOT NULL,
    id_tipo_correo int(11) NOT NULL,
    id_paciente int(11) NOT NULL,   
    
    FOREIGN KEY (id_tipo_correo) REFERENCES tipos_correos_pacientes(id),
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id)
);

#TABLA CATALOGO
CREATE TABLE tipos_telefonos_pacientes (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    tipo_telefono varchar(25) NOT NULL UNIQUE
);

#TELEFONOS DE LOS PACIENTES
#NO SE CONSIDERARON RESTRICCIONES DE TELEFONOS REPETIDOS POR PACIENTES
CREATE TABLE telefonos_pacientes (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    telefono char(9) NOT NULL,
    id_tipo_telefono int(11) NOT NULL,
    id_paciente int(11) NOT NULL,
    
    FOREIGN KEY (id_tipo_telefono) REFERENCES tipos_telefonos_pacientes(id),
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id)
);

##################################################################################
#TABLA CON LA CONFIGURACION DE SEGURIDAD (NO DEBE DE EDITARSE)
#TABLA CATALOGO
CREATE TABLE roles (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    rol varchar(25) NOT NULL UNIQUE
);

#TABLA CON LA CONFIGURACION DE SEGURIDAD (NO DEBE DE EDITARSE)
#TABLA CATALOGO
CREATE TABLE permisos (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    permiso varchar(25) NOT NULL UNIQUE
);

#TABLA CON LA CONFIGURACION DE SEGURIDAD (NO DEBE DE EDITARSE)
#TABLA MANY TO MANY
CREATE TABLE roles_permisos (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_rol int(11) NOT NULL,
    id_permiso int(11) NOT NULL,
    
    UNIQUE (id_rol, id_permiso),
    FOREIGN KEY (id_rol) REFERENCES roles(id),
    FOREIGN KEY (id_permiso) REFERENCES permisos(id)    
);

##################################################################################
#INFORMACION DEL USUARIO
CREATE TABLE usuarios (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombres varchar(35) NOT NULL,
    apellidos varchar(35) NOT NULL,
    nombre_sistema varchar(25) NOT NULL UNIQUE,
    contrasena varchar(60) NOT NULL,
    habilitado tinyint(1) NOT NULL,
    id_rol INT NOT NULL,
    
    UNIQUE (nombres, apellidos),
    
    FOREIGN KEY (id_rol) REFERENCES roles(id)
);

#TABLA CATALOGO
CREATE TABLE tipos_telefonos_usuarios (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    tipo_telefono varchar(25) NOT NULL UNIQUE
);

#NO SE CONSIDRARON RESTRICCIONES DE TELEFONOS REPETIDOS POR USUARIOS
CREATE TABLE telefonos_usuarios (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    telefono char(9) NOT NULL,
    id_tipo_telefono int(11) NOT NULL,
    id_usuario int(11) NOT NULL,
    
    FOREIGN KEY (id_tipo_telefono) REFERENCES tipos_telefonos_usuarios(id),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

#TABLA CATALOGO
CREATE TABLE tipos_correos_usuarios (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    tipo_correo varchar(25) NOT NULL UNIQUE
);

#NO SE CONSIDRARON RESTRICCIONES DE CORREOS REPETIDOS POR USUARIOS
CREATE TABLE correos_usuarios (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    correo varchar(100) NOT NULL,
    id_tipo_correo int(11) NOT NULL,
    id_usuario int(11) NOT NULL,
    
    FOREIGN KEY (id_tipo_correo) REFERENCES tipos_correos_usuarios(id),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

#TABLA CON LA CONFIGURACION DE SEGURIDAD (SOLO SE EDITA PROGRAMATICAMENTE)
#TABLA MANY TO MANY
CREATE TABLE usuarios_permisos (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    estado tinyint(1) NOT NULL,
    id_usuario int(11) NOT NULL,
    id_permiso int(11) NOT NULL,
    
    UNIQUE (id_usuario, id_permiso),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_permiso) REFERENCES permisos(id)    
);

#PACIENTE TIENE 0,1,* EVALUACIONES
#INFORMACION DE LAS EVALUACIONES
#LAS EVALUACIONES SON UN PROCESO LARGO, ESTA TABLA UNE MUCHAS TABLAS
CREATE TABLE evaluaciones(
	id INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    estado_evaluacion ENUM('En Proceso', 'Finalizado'),
    #FECHA EN QUE SE CREO    
    #ESTADO DE DIAGNOSTICO, PLAN DE TRATAMIENTO, PROCEDIMIENTOS
    
    id_paciente INT NOT NULL,
    
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id)
);

##################################################################################
#TABLA CATALOGO
CREATE TABLE especialidades(
	id INT PRIMARY KEY AUTO_INCREMENT,
    especialidad VARCHAR(35) NOT NULL UNIQUE
);

#USUARIO TIENE 0,1,* ESPECIALIDADES
CREATE TABLE usuarios_especialidades(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_especialidad INT NOT NULL,
    
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_especialidad) REFERENCES especialidades(id),
    UNIQUE (id_usuario, id_especialidad)
);

#EVALUACION TIENE 0,* PROCEDIMIENTOS
#SE MANEJAN LOS PROCEDIMIENTOS POR ESPECIALIDAD (SIEMPRE PARA UN MISMO EVALUACION)
CREATE TABLE procedimientos(
	id INT PRIMARY KEY AUTO_INCREMENT,
    cita INT NOT NULL NOT NULL, #CORRELATIVO NUMERICO
    fecha_registro DATE NOT NULL,
    procedimiento VARCHAR(20000) NOT NULL,
    
    id_especialidad INT NOT NULL,
    id_evaluacion INT NOT NULL,
    id_usuario INT NOT NULL,    
    
    UNIQUE (cita, id_especialidad, id_evaluacion),
    FOREIGN KEY (id_especialidad) REFERENCES especialidades(id),
    FOREIGN KEY (id_evaluacion) REFERENCES evaluaciones(id),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);
##################################################################################
#TABLA CATALOGO
CREATE TABLE piezas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    pieza CHAR(2) UNIQUE NOT NULL
);
##################################################################################
#EVALUACION TIENE 0,1 DIAGNOSTICO DE IMPLANTOLOGIA
CREATE TABLE diagnosticos_implantologias(
	id INT PRIMARY KEY AUTO_INCREMENT,    
    motivo_consulta ENUM('1ª Consulta', 'Reevaluación'),
	fecha_registro DATE NOT NULL, #FECHA DE REGISTRO DE LA INFORMACION DE DIAGNOSTICO DE IMPLANTOLOGIA

    id_evaluacion INT NOT NULL UNIQUE,
    
    FOREIGN KEY (id_evaluacion) REFERENCES evaluaciones(id)
);
##################################################################################
#DIAGNOSTICO DE IMPLANTOLOGIA TIENE 0,1 HISTORIA CLINICA
CREATE TABLE historias_clinicas(
	id INT PRIMARY KEY AUTO_INCREMENT,
	hx_enfermedad VARCHAR(2500) DEFAULT '',  
    antecedentes VARCHAR(2500) DEFAULT '', 
    historia_medica VARCHAR(2500) DEFAULT '',
    historia_odontologica VARCHAR(2500) DEFAULT '',
    
    id_diagnostico_implantologia INT NOT NULL UNIQUE,
    
    FOREIGN KEY (id_diagnostico_implantologia) REFERENCES diagnosticos_implantologias(id)	
);

#TABLA CATALOGO
CREATE TABLE sintomas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    sintoma VARCHAR(35) NOT NULL UNIQUE
);

#HISTORIA CLINICA TIENE 0, * SINTOMAS
CREATE TABLE sintomas_historias_clinicas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    
    id_sintoma INT NOT NULL,
    id_historia_clinica INT NOT NULL,
    
    UNIQUE (id_sintoma, id_historia_clinica),
    FOREIGN KEY(id_sintoma) REFERENCES sintomas(id),
    FOREIGN KEY(id_historia_clinica) REFERENCES historias_clinicas(id)
);

#DIAGNOSTICO DE IMPLANTOLOGIA TIENE 0,1 APRECIACION
CREATE TABLE apreciaciones(
	id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_paciente ENUM('Filosófico', 'Exigente', 'Histérico', 'Indiferente'),
    motivacion_general VARCHAR(2500) DEFAULT '',
    expectativas_tratamiento VARCHAR(2500) DEFAULT '',
    apreciacion_general VARCHAR(2500) DEFAULT '',
    motivacion_real ENUM('Estética', 'Cambio de status', 'Presión Social', 'Factores Económicos', 'Patología'),
    
    id_diagnostico_implantologia INT NOT NULL UNIQUE,
    
    FOREIGN KEY (id_diagnostico_implantologia) REFERENCES diagnosticos_implantologias(id)
);

#DIAGNOSTICO DE IMPLANTOLOGIA TIENE 0, 1 AREA EXTRAESTOMATOGNATICA
CREATE TABLE areas_extraestomatognaticas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    piel VARCHAR(1000) DEFAULT '',
    ojos_anexos VARCHAR(1000) DEFAULT '',
    oidos VARCHAR(1000) DEFAULT '',
    nariz_anexos VARCHAR(1000) DEFAULT '',
    extremidades VARCHAR(1000) DEFAULT '',
    osteoarticular VARCHAR(1000) DEFAULT '',
    neuromuscular VARCHAR(1000) DEFAULT '',
    maxilar VARCHAR(1000) DEFAULT '',
    maxilar_inferior VARCHAR(1000) DEFAULT '',
    senos_paranasales VARCHAR(1000) DEFAULT '',
    vasos VARCHAR(1000) DEFAULT '',
    ganglios VARCHAR(1000) DEFAULT '',
    labios VARCHAR(1000) DEFAULT '',

    id_diagnostico_implantologia INT NOT NULL UNIQUE,
    
    FOREIGN KEY (id_diagnostico_implantologia) REFERENCES diagnosticos_implantologias(id)
);

#DIAGNOSTICO DE IMPLANTOLOGIA TIENE 0,1 ATM
CREATE TABLE atm(
	id INT PRIMARY KEY AUTO_INCREMENT,
    imagen_apertura VARCHAR(255),
    imagen_cierre VARCHAR(255),
    apertura_maxima_voluntaria INT,
    apertura_maxima_asistida INT,
    
    id_diagnostico_implantologia INT NOT NULL UNIQUE,
    
    FOREIGN KEY (id_diagnostico_implantologia) REFERENCES diagnosticos_implantologias(id)
);

#ATM TIENE 0,* SINTOMAS
CREATE TABLE sintomas_atm(
	id INT PRIMARY KEY AUTO_INCREMENT,
    sintoma_atm ENUM(
		'Ruido Articular',
        'Dolor Articular',
        'Dolor Muscular',
        'Desviaciones Mandíbula'
    ),
    
    id_atm INT NOT NULL,
    
    UNIQUE (sintoma_atm, id_atm),
    FOREIGN KEY (id_atm) REFERENCES atm(id)
);

#DIAGNOSTICO DE IMPLANTOLOGIA TIENE 0,1 DIMENSIONES VERTICALES
CREATE TABLE dimensiones_verticales(
	id INT PRIMARY KEY AUTO_INCREMENT,
    dvr VARCHAR(35) DEFAULT '',
	dvo VARCHAR(35) DEFAULT '',
    elio VARCHAR(35) DEFAULT '',
    observaciones VARCHAR(255) DEFAULT '',
    
    id_diagnostico_implantologia INT NOT NULL UNIQUE,
    
    FOREIGN KEY (id_diagnostico_implantologia) REFERENCES diagnosticos_implantologias(id)
);

#DIAGNOSTICO DE IMPLANTOLOGIA TIENE 0, 1 ANALISIS ESTATICOS
CREATE TABLE analisis_estaticos(
	id INT PRIMARY KEY AUTO_INCREMENT,
    linea_media_dental VARCHAR(255) DEFAULT '',
    rel_molar_derecha VARCHAR(255) DEFAULT '',
    rel_canina_derecha VARCHAR(255) DEFAULT '',
    rel_molar_izquierda VARCHAR(255) DEFAULT '',
    rel_canina_izquierda VARCHAR(255) DEFAULT '',
    sobremordida_horiz VARCHAR(255) DEFAULT '', 
    sobremordida_vert VARCHAR(255) DEFAULT '',
    
    id_diagnostico_implantologia INT NOT NULL UNIQUE,
    
    FOREIGN KEY (id_diagnostico_implantologia) REFERENCES diagnosticos_implantologias(id)
);

#DIAGNOSTICO DE IMPLANTOLOGIA TIENE 0, 1 ANALISIS DINAMICOS
CREATE TABLE analisis_dinamicos(
	id INT PRIMARY KEY AUTO_INCREMENT,
    lateral_derecha VARCHAR(255) DEFAULT '',
    interf_late_derecha VARCHAR(255) DEFAULT '',
    lateral_izquie VARCHAR(255) DEFAULT '',
    interf_late_izquie VARCHAR(255) DEFAULT '',
    deslizamientos VARCHAR(255) DEFAULT '',
    contac_prema VARCHAR(255) DEFAULT '',
    
    id_diagnostico_implantologia INT NOT NULL UNIQUE,
    
    FOREIGN KEY (id_diagnostico_implantologia) REFERENCES diagnosticos_implantologias(id)
);

#DIAGNOSTICO DE IMPLANTOLOGIA TIENE 0, 1 EXAMEN INTRAACO
CREATE TABLE examenes_intraarco_superior(
	id INT PRIMARY KEY AUTO_INCREMENT,
    forma_arco VARCHAR(255) DEFAULT '',
    malposiciones VARCHAR(255) DEFAULT '',
    facetas_desgaste VARCHAR(255) DEFAULT '',
    apinamientos VARCHAR(255) DEFAULT '',
    diastemas VARCHAR(255) DEFAULT '',
    espacios VARCHAR(255) DEFAULT '',
    ausentes VARCHAR(255) DEFAULT '',
    clasif_seibert VARCHAR(255) DEFAULT '',
    id_diagnostico_implantologia INT NOT NULL UNIQUE,
    
    
    FOREIGN KEY(id_diagnostico_implantologia) REFERENCES diagnosticos_implantologias(id)
);

#DIAGNOSTICO DE IMPLANTOLOGIA TIENE 0, 1EXAMEN INTRAACO
CREATE TABLE examenes_intraarco_inferior(
	id INT PRIMARY KEY AUTO_INCREMENT,
    forma_arco VARCHAR(255) DEFAULT '',
    malposiciones VARCHAR(255) DEFAULT '',
    facetas_desgaste VARCHAR(255) DEFAULT '',
    apinamientos VARCHAR(255) DEFAULT '',
    diastemas VARCHAR(255) DEFAULT '',
    espacios VARCHAR(255) DEFAULT '',
    ausentes VARCHAR(255) DEFAULT '',
    clasif_seibert VARCHAR(255) DEFAULT '',
    id_diagnostico_implantologia INT NOT NULL UNIQUE,
    
    
    FOREIGN KEY(id_diagnostico_implantologia) REFERENCES diagnosticos_implantologias(id)
);

#DIAGNOSTICO DE IMPLANTOLOGIA TIENE 0,1 DIAGNOSTICO RESUMEN
CREATE TABLE diagnosticos_resumenes(
    id INT PRIMARY KEY AUTO_INCREMENT,    
    periodontal VARCHAR(2500) DEFAULT '',
    pulpar VARCHAR(2500) DEFAULT '',
    rehabilitacion_oral VARCHAR(2500) DEFAULT '',
    musculo_articular VARCHAR(2500) DEFAULT '',
    otros VARCHAR(2500) DEFAULT '',
    pronostico_general VARCHAR(2500) DEFAULT '',
        
    id_diagnostico_implantologia INT NOT NULL UNIQUE,
    
    FOREIGN KEY (id_diagnostico_implantologia) REFERENCES diagnosticos_implantologias(id)	
);
##################################################################################
#DIAGNOSTICO DE IMPLANTOLOGIA TIENE 0,* FOTOS
CREATE TABLE fotos(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    foto VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255),
    categoria_foto enum('Radriografía', 'Implantonlogía', '3D'),
    tipo_foto enum('Cámara', 'SOPRO', 'Otro'),
    
    id_diagnostico_implantologia INT NOT NULL,
    
    FOREIGN KEY (id_diagnostico_implantologia) REFERENCES diagnosticos_implantologias(id)
);
##################################################################################
#DIAGNOSTICO DE IMPLANTOLOGIA TIENE 1,*? PERIODONTOGRAMAS
#LA INFORMACION DE ESTA TABLA ES MUY AMPLIA, SE AGRUPADO LA INFORMACION EN OTRAS TABLAS PARA NORMALIZAR LA DB
CREATE TABLE periodontogramas(
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_reg DATE NOT NULL,
    contexto_periodontograma enum('1ª Visita', 'Reevaluación', 'Otro'),
    descripcion_otro VARCHAR(100),
    observacion VARCHAR(100),
    
    id_diagnostico_implantologia INT NOT NULL, #UNIQUE?
    id_usuario INT NOT NULL,
    
    FOREIGN KEY (id_diagnostico_implantologia) REFERENCES diagnosticos_implantologias(id),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

#PERIODONTOGRAMA TIENE * PIEZAS
#MANY TO MANY
CREATE TABLE piezas_periodontogramas(
    id INT PRIMARY KEY AUTO_INCREMENT,    
    estado boolean DEFAULT TRUE,       
    perspectiva_diente enum('Superior', 'Inferior'), 
    
    id_pieza INT NOT NULL,    
    id_periodontograma INT NOT NULL,
    
    UNIQUE (id_pieza, id_periodontograma),
    FOREIGN KEY (id_pieza) REFERENCES piezas(id),
    FOREIGN KEY (id_periodontograma) REFERENCES periodontogramas(id)
);
 
#PIEZA DE PERIODONTOGRAMA TIENE 1 ESTADO
CREATE TABLE estados_piezas_periodontogramas(
    id INT PRIMARY KEY AUTO_INCREMENT,
    implante BOOLEAN DEFAULT FALSE,
	movilidad INT DEFAULT 0,
    pronostico CHAR(1) DEFAULT '',
    anchura DECIMAL DEFAULT NULL,
	margen_profundidad_html VARCHAR(20000),
    nota VARCHAR(50),
    
    id_pieza_periodontograma INT NOT NULL UNIQUE,
    
    FOREIGN KEY (id_pieza_periodontograma) REFERENCES piezas_periodontogramas(id)
);

#ESTADO DE PIEZA
CREATE TABLE furcas(
 	id INT PRIMARY KEY AUTO_INCREMENT,
    cara_diente enum('Vestibular', 'Palatino', 'Lingual'),
    furca_vestibular enum('False', 'Inicial', 'Abierta', 'Completa') DEFAULT 'False',
    
	id_estado_pieza_periodontograma INT NOT NULL,
    
    UNIQUE(id_estado_pieza_periodontograma, cara_diente),
    FOREIGN KEY (id_estado_pieza_periodontograma) REFERENCES estados_piezas_periodontogramas(id)
);

#ESTADO DE PIEZA
CREATE TABLE furcas_palatinos(
 	id INT PRIMARY KEY AUTO_INCREMENT,    
    furca_palatino_izquierda enum('False', 'Inicial', 'Abierta', 'Completa') DEFAULT 'False',   
    furca_palatino_derecha enum('False', 'Inicial', 'Abierta', 'Completa') DEFAULT 'False',
    
	id_estado_pieza_periodontograma INT UNIQUE NOT NULL,
    
    FOREIGN KEY (id_estado_pieza_periodontograma) REFERENCES estados_piezas_periodontogramas(id)
);

#ESTADO DE PIEZA
CREATE TABLE sangrados_supuraciones(
 	id INT PRIMARY KEY AUTO_INCREMENT,
    cara_diente enum('Vestibular', 'Palatino', 'Lingual'),
    superficie_diente_mesial enum('False', 'Sangrado', 'Sangrado/Supuración') DEFAULT 'False',
    superficie_diente_distal enum('False', 'Sangrado', 'Sangrado/Supuración') DEFAULT 'False',
    superficie_diente_vestibular enum('False', 'Sangrado', 'Sangrado/Supuración') DEFAULT 'False', 
    
	id_estado_pieza_periodontograma INT NOT NULL,
    
    UNIQUE(id_estado_pieza_periodontograma, cara_diente),
    FOREIGN KEY (id_estado_pieza_periodontograma) REFERENCES estados_piezas_periodontogramas(id)
);

#ESTADO DE PIEZA
CREATE TABLE placas(
    id INT PRIMARY KEY AUTO_INCREMENT,    
    cara_diente enum('Vestibular', 'Palatino', 'Lingual'),
    superficie_diente_mesial BOOLEAN DEFAULT FALSE,
    superficie_diente_distal BOOLEAN DEFAULT FALSE,
    superficie_diente_vestibular BOOLEAN DEFAULT FALSE,
    
    id_estado_pieza_periodontograma INT NOT NULL,
    
    UNIQUE(id_estado_pieza_periodontograma, cara_diente),
    FOREIGN KEY (id_estado_pieza_periodontograma) REFERENCES estados_piezas_periodontogramas(id)
);

#ESTADO DE PIEZA
CREATE TABLE margenes_gingivales(
    id INT PRIMARY KEY AUTO_INCREMENT,   
    cara_diente enum('Vestibular', 'Palatino', 'Lingual'),
    izquierda INT DEFAULT 0,
    centro INT DEFAULT 0,
    derecha INT DEFAULT 0,
    
    id_estado_pieza_periodontograma INT NOT NULL,
    
    UNIQUE(id_estado_pieza_periodontograma, cara_diente),
    FOREIGN KEY (id_estado_pieza_periodontograma) REFERENCES estados_piezas_periodontogramas(id)
);

#ESTADO DE PIEZA
CREATE TABLE profundidades_sondajes(
    id INT PRIMARY KEY AUTO_INCREMENT,    
    cara_diente enum('Vestibular', 'Palatino', 'Lingual'),
    izquierda INT DEFAULT 0,
    centro INT DEFAULT 0,
    derecha INT DEFAULT 0,
    
    id_estado_pieza_periodontograma INT NOT NULL,
    
    UNIQUE(id_estado_pieza_periodontograma, cara_diente),
    FOREIGN KEY (id_estado_pieza_periodontograma) REFERENCES estados_piezas_periodontogramas(id)
);

#TABLA CATALOGO
CREATE TABLE patologias(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    patologia VARCHAR(50) UNIQUE NOT NULL
);

#PERIODONTOGRAMA TIENE 0,* PATOLOGIAS
CREATE TABLE diagnosticos_patologias(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,    
    piezas VARCHAR(100),
    id_patologia INT NOT NULL,
    
    id_periodontograma INT NOT NULL,
    
    UNIQUE (id_patologia, id_periodontograma),
    FOREIGN KEY (id_patologia) REFERENCES patologias(id),    
    FOREIGN KEY (id_periodontograma) REFERENCES periodontogramas(id)    
);

#
CREATE TABLE fases_periodontitis(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    fase_periodontitis ENUM(
        'Inicial', 
        'Moderada',
        'Avanzada', 
        'Crónica', 
        'Agresiva', 
        'Manifestacion de enfermedades sistématicas'),
    descripcion VARCHAR(100),
    
    id_diagnostico_patologia INT NOT NULL,
    
    UNIQUE (fase_periodontitis, id_diagnostico_patologia),
    FOREIGN KEY (id_diagnostico_patologia) REFERENCES diagnosticos_patologias(id)
);

#
CREATE TABLE tratamientos_periodontogramas(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    instrucciones varchar(2500) DEFAULT NULL,
    sesiones int(11) DEFAULT NULL,
    estado_tratamiento enum('Realizado', 'Pendiente'),
    ajuste_ocusal varchar(2500) DEFAULT NULL,
    periodontal_quirurgico mediumtext,
    implantes mediumtext,
    profilaxis varchar(2500) DEFAULT NULL,
    otros varchar(2500) DEFAULT NULL,
    
    id_periodontograma INT NOT NULL UNIQUE,
    
    FOREIGN KEY (id_periodontograma) REFERENCES periodontogramas(id)
);

##################################################################################

#EL PLAN DE TRATAMIENTO Y EL ODONTOGRAMA ESTAN FUERTEMENTE RELACIONADOS
#DIAGNOSTICO DE IMPLANTOLOGIA TIENE 0, 1 PLAN DE TRATAMIENTO
CREATE TABLE planes_tratamientos(
    id INT PRIMARY KEY AUTO_INCREMENT,    
    fecha_inicio DATE, #FECHA DE INICIO DEL plan
    fecha_finalizacion DATE, #FECHA DE FINALIZACION DEL plan    
    
    fase_urgencia VARCHAR(5000),
    fase_sistematica VARCHAR(5000),
    fase_reevaluacion VARCHAR(5000),
    fase_mantenimiento VARCHAR(5000),
    
    id_diagnostico_implantologia INT NOT NULL UNIQUE,
    
    FOREIGN KEY (id_diagnostico_implantologia) REFERENCES diagnosticos_implantologias(id)
);
    
CREATE TABLE fases_higienicas(
    id INT PRIMARY KEY AUTO_INCREMENT,
    periodoncia VARCHAR(5000),
    endodoncia VARCHAR(5000),
    cirugia VARCHAR(5000),
    rehabilitacion VARCHAR(5000),
    
    id_plan_tratamiento INT NOT NULL UNIQUE,
    
    FOREIGN KEY (id_plan_tratamiento) REFERENCES planes_tratamientos(id)
);
    
CREATE TABLE fases_correctivas(
    id INT PRIMARY KEY AUTO_INCREMENT,
    periodoncia VARCHAR(5000),
    rehabilitacion VARCHAR(5000),
    
    id_plan_tratamiento INT NOT NULL UNIQUE,
    
    FOREIGN KEY (id_plan_tratamiento) REFERENCES planes_tratamientos(id)
);

##################################################################################
#TABLA CATALOGO
CREATE TABLE descuentos_odontogramas_perfiles(
	id INT PRIMARY KEY AUTO_INCREMENT,   
    descuento DECIMAL(4,2) UNSIGNED NOT NULL, #PORCENTAJE
	estado TINYINT(1) NOT NULL,
    fecha_inicio DATE,
    fecha_fin DATE,
	id_perfil INT NOT NULL,   
     
    FOREIGN KEY (id_perfil) REFERENCES perfiles(id)
);

#TABLA CATALOGO
CREATE TABLE tratamientos_odontogramas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    tratamiento VARCHAR(50) NOT NULL UNIQUE,
    codigo VARCHAR(15) NOT NULL UNIQUE,
    precio DECIMAL(6,2) UNSIGNED NOT NULL DEFAULT 0.00 
);

#EVALUACION TIENE 0,1 ODONTOGRAMA
#UNA EVALUACION DEBERIA DE TENER A LO MAXIMO 2 ODONTOGRAMAS (EL DE REFERENCIA (EN CASO DE QUE TENGA) Y EL DE PRESUPUESTO)
CREATE TABLE odontogramas(
	id INT PRIMARY KEY AUTO_INCREMENT,    
    fecha_creacion DATE NOT NULL,
    tratamientos_piezas_descripcion JSON,
    tratamientos_piezas_grafico JSON, 
    tipo_odontograma ENUM('Diagnóstico','Tratamiento') NOT NULL,
    
    id_odontograma_referencia INT DEFAULT NULL, #CAMPO PUEDE APUNTAR AL ODONTOGRAMA DE DIAGNOSTICO O AL DE LA EVALUACION ANTERIOR DEL PACIENTE
    id_evaluacion INT NOT NULL,
    id_usuario INT NOT NULL,
    
    FOREIGN KEY (id_evaluacion) REFERENCES evaluaciones(id),
    FOREIGN KEY (id_odontograma_referencia) REFERENCES odontogramas(id),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    UNIQUE(tipo_odontograma, id_evaluacion),

    CHECK (JSON_VALID(tratamientos_piezas_descripcion)),
    CHECK (JSON_VALID(tratamientos_piezas_grafico))
);

CREATE TABLE presupuestos_odontogramas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    descuento DECIMAL(6,2) UNSIGNED NOT NULL,
    #AVERIGUAR SI HAY OTRO TIPO DE DESCUENTOS
    #AVERIGUAR SI EXISTEN OTROS COSTOS
    precio_bruto DECIMAL(8,2) UNSIGNED NOT NULL,
    precio_neto DECIMAL(8,2) UNSIGNED NOT NULL, 
    comentario VARCHAR(250),
    id_odontograma INT NOT NULL UNIQUE,
    
    FOREIGN KEY (id_odontograma) REFERENCES odontogramas(id)
);