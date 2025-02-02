﻿###############################################################
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
(NULL, 'ROLE_ADMIN'),
(NULL, 'ROLE_ASISTENTE'),
(NULL, 'ROLE_DOCTOR'),
(NULL, 'ROLE_SECRETARIA');

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
(NULL, 'Sysadmin', '', 'sysadmin', '$2a$10$Qg2uZy2YjlsncSZI.gyG3uopSjgJAHleSdrsXntI1oyCrvhy636.K', '1', 1), 
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

###############################################################
INSERT INTO `especialidades` (`id`, `especialidad`) VALUES 
(NULL, 'GCG'), 
(NULL, 'Endodoncista'), 
(NULL, 'Anestecista'), 
(NULL, 'Odontopediatra'), 
(NULL, 'Maxilofacial'), 
(NULL, 'Peridoncia'), 
(NULL, 'Preventivo'), 
(NULL, 'Implantología'), 
(NULL, 'Rehabilitador Oral');

###############################################################
INSERT INTO `piezas` (`id`, `pieza`) VALUES 
(NULL, '18'), 
(NULL, '17'), 
(NULL, '16'), 
(NULL, '15'), 
(NULL, '14'), 
(NULL, '13'), 
(NULL, '12'), 
(NULL, '11'), 
(NULL, '21'), 
(NULL, '22'), 
(NULL, '23'), 
(NULL, '24'), 
(NULL, '25'), 
(NULL, '26'), 
(NULL, '27'), 
(NULL, '28'), 
(NULL, '48'), 
(NULL, '47'), 
(NULL, '46'), 
(NULL, '45'), 
(NULL, '44'), 
(NULL, '43'), 
(NULL, '42'), 
(NULL, '41'), 
(NULL, '31'), 
(NULL, '32'), 
(NULL, '33'), 
(NULL, '34'), 
(NULL, '35'), 
(NULL, '36'), 
(NULL, '37'), 
(NULL, '38');

###############################################################
INSERT INTO `tratamientos_odontogramas` (`id`, `tratamiento`, `codigo`, `precio`) VALUES 
(NULL, 'Tratamiento de conductos radiculares (Endodoncia)', 'TCR', '0.00'), 
(NULL, 'Implante quirúrgico', 'I Qx', '0.00'), 
(NULL, 'Implante protésico', 'I Prosto', '0.00'), 
(NULL, 'Sensibilidad Dental', 'Sens', '0.00'), 
(NULL, 'Extrución dental', 'Extrucion', '0.00'), 
(NULL, 'Giroversión dental', 'Giro', '0.00'), 
(NULL, 'Trangresión dental', 'Transgr', '0.00'), 
(NULL, 'Resina', 'Res', '0.00'), 
(NULL, 'Amalgama de plata', 'Ag', '0.00'), 
(NULL, 'Calculo dental', 'Calc', '0.00'), 
(NULL, 'Reseción gingival', 'Recesión', '0.00'), 
(NULL, 'Periodontitis', 'Perio', '0.00'), 
(NULL, 'Gingivitis', 'Gingivitis', '0.00'), 
(NULL, 'TCR Monoradicular', 'TCR mo', '0.00'), 
(NULL, 'TCR Biradicular', 'TCR bi', '0.00'), 
(NULL, 'TCR Multiradicular', 'TCR Mu', '0.00'), 
(NULL, 'Discromia dental', 'DIScr', '0.00'), 
(NULL, 'Diente en proceso de erupción', 'Erupción', '0.00'), 
(NULL, 'Macrodoncia', 'MAC', '0.00'), 
(NULL, 'Microdoncia', 'MiC', '0.00'), 
(NULL, 'Movilidad grado 1', 'MOV 1', '0.00'), 
(NULL, 'Movilidad grado 2', 'MOV 2', '0.00'), 
(NULL, 'Movilidad grado 3', 'MOV 3', '0.00'), 
(NULL, 'Resto Radicular', 'RR', '0.00'), 
(NULL, 'Incrustacion de Oro', 'Incr Oro', '0.00'), 
(NULL, 'Incrustacion de Metal', 'Incr Met', '0.00'), 
(NULL, 'Incrustacion de Resina', 'Incr Res', '0.00'), 
(NULL, 'Incrustacion de Polividrio', 'Incr Pol', '0.00'), 
(NULL, 'Incrustacion de Ceramica', 'Incr Cer', '0.00'), 
(NULL, 'Incrustacion de CAD/CAM', 'Incr CAD', '0.00'), 
(NULL, 'Provisional', 'Prov', '0.00'), 
(NULL, 'Sellante de fosas y fisuras', 'SFF', '0.00'), 
(NULL, 'Fasetas de dsgastes', 'FD', '0.00'), 
(NULL, 'Abración dental', 'ABR', '0.00'), 
(NULL, 'Gemación', 'GEM', '0.00'), 
(NULL, 'Dentinogenesis imperfecta', 'D imp', '0.00'), 
(NULL, 'Amelogenesis imperfecta', 'A imp', '0.00'), 
(NULL, 'Descalcificación', 'DESC', '0.00');