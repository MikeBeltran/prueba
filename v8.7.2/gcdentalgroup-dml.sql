###############################################################
INSERT INTO `perfiles` (`id`, `perfil`, `acronimo`) VALUES
(NULL, 'Origen Desconocido', 'Px'),
(NULL, 'Diario', 'D'),
(NULL, 'Residencia Extranjero', 'E'),
(NULL, 'Familiar', 'F'),
(NULL, 'Colegio Highlands', 'HG'),
(NULL, 'Referido de otra Persona', 'P'),
(NULL, 'Rotarios', 'R'),
(NULL, 'Social', 'S'),
(NULL, 'Televisión', 'T'),
(NULL, 'Turismo Médico', 'TM'),
(NULL, 'Sin Datos', 'SD'),
(NULL, 'Banco Agrícola', 'BA'),
(NULL, 'Banco Davivienda', 'BD'),
(NULL, 'Dra. Villacorta', 'DV'),
(NULL, 'Externos', 'X');

###############################################################
INSERT INTO `permisos` (`id`, `permiso`) VALUES
(NULL, 'Permiso Total'),
(NULL, 'Crear Usuarios'),
(NULL, 'Leer Usuarios'),
(NULL, 'Actualizar Usuarios'),
(NULL, 'Eliminar Usuarios'),
(NULL, 'Crear Pacientes'),
(NULL, 'Leer Pacientes'),
(NULL, 'Actualizar Pacientes'),
(NULL, 'Eliminar Pacientes');

###############################################################
INSERT INTO `roles` (`id`, `rol`) VALUES
(NULL, 'Administrador'),
(NULL, 'Asistente'),
(NULL, 'Doctor'),
(NULL, 'Secretaria');

###############################################################
INSERT INTO `tipos_correos_usuarios` (`id`, `tipo_correo`) VALUES 
(NULL, 'Personal'), 
(NULL, 'Trabajo');

###############################################################
INSERT INTO `tipos_correos_pacientes` (`id`, `tipo_correo`) VALUES 
(NULL, 'Personal'), 
(NULL, 'Trabajo'),
(NULL, 'Familiar');

###############################################################
INSERT INTO `tipos_telefonos_pacientes` (`id`, `tipo_telefono`) VALUES 
(NULL, 'Personal'), 
(NULL, 'Trabajo'), 
(NULL, 'Colegio'), 
(NULL, 'Familiar');

###############################################################
INSERT INTO `tipos_telefonos_usuarios` (`id`, `tipo_telefono`) VALUES 
(NULL, 'Personal'), 
(NULL, 'Trabajo');

###############################################################
INSERT INTO `roles_permisos` (`id`, `id_rol`, `id_permiso`) VALUES 
(NULL, '1', '1'), 
(NULL, '2', '2'), 
(NULL, '2', '3'), 
(NULL, '2', '4'), 
(NULL, '2', '5'), 
(NULL, '2', '6'), 
(NULL, '2', '7'), 
(NULL, '2', '8'), 
(NULL, '2', '9'), 
(NULL, '3', '6'), 
(NULL, '3', '7'), 
(NULL, '3', '8'), 
(NULL, '3', '9');

###############################################################
INSERT INTO `usuarios`(`id`, `nombres`, `apellidos`, `nombre_sistema`, `contrasena`, `habilitado`, `id_rol`) VALUES 
(NULL, 'admin', 'admin', 'admin', '$2a$10$Qg2uZy2YjlsncSZI.gyG3uopSjgJAHleSdrsXntI1oyCrvhy636.K', '1', 1), 
(NULL, 'Rafael Eduardo', 'Guerrero Arias', 'rafael_rafael', '$2a$10$LrpxVuYuX21QqXOoaoFzRO/3rDDbWHrXPSY7.S9vhFdKJzoh9Y60W', '1', 1), 
(NULL, 'Laura Carolina', 'Contreras de Guerrero', 'laura_laura', '$2a$10$wA3IZNASIXYXTC3Ge0UVxemvgeqwRsTepnF5WvlAAZLrph5Hkw4Pu', '1', 1), 
(NULL, 'Silvia', 'Silvia', 'silvia_silvia', '$2a$10$cXsC9R9s8PIL0aR1.99jku6c3h/kpovyVG7EEtV/uDCFIpy1ibrHC', '1', 2), 
(NULL, 'Marbella', 'Ibarra', 'marbella_marbella', '$2a$10$6Ll.bYJ4v4wwfxKPp09iYeSwqsNfr7M0sl6SJbTLlkrnFgotILe6S', '1', 1), 
(NULL, 'Juan Miguel', 'Beltran Peñate', 'juan_juan', '$2a$10$F43Ksm6h//K5zDnJYBd4Mu0O4HFtnyVw09/9wiOScxKt9v.Scv9Yi', '1', 1), 
(NULL, 'Helder Josue', 'Hernández Díaz', 'helder_helder', '$2a$10$8veGcVQgbWHI3uUUxthTbuobaXi1NCRRWVRGJqIDNju8djvZ9fNmS', '1', 1);

###############################################################
INSERT INTO `usuarios_permisos` (`id`, `id_usuario`, `id_permiso`, `estado`) VALUES 
(NULL, '1', '1', '1'), 
(NULL, '2', '1', '1'), 
(NULL, '3', '1', '1'), 
(NULL, '4', '2', '1'), 
(NULL, '4', '3', '1'), 
(NULL, '4', '4', '1'), 
(NULL, '4', '5', '1'), 
(NULL, '4', '6', '1'), 
(NULL, '4', '7', '1'), 
(NULL, '4', '8', '1'), 
(NULL, '4', '9', '1'), 
(NULL, '5', '1', '1'), 
(NULL, '6', '1', '1'), 
(NULL, '7', '1', '1');

###############################################################
INSERT INTO `sintomas` (`id`, `sintoma`) VALUES 
(NULL, 'SCV'), 
(NULL, 'SR'), 
(NULL, 'SGI'), 
(NULL, 'SGU'), 
(NULL, 'SH'), 
(NULL, 'SME'), 
(NULL, 'SE'), 
(NULL, 'SI'), 
(NULL, 'LOC'), 
(NULL, 'T.A'), 
(NULL, 'PULSO'), 
(NULL, 'FR'), 
(NULL, 'T°');

INSERT INTO `especialidades` (`id`, `especialidad`) VALUES (NULL, 'GCG'), (NULL, 'Endodoncista'), (NULL, 'Anestecista'), (NULL, 'Odontopediatra'), (NULL, 'Maxilofacial'), (NULL, 'Peridoncia'), (NULL, 'Preventivo'), (NULL, 'Implantología'), (NULL, 'Rehabilitador Oral');