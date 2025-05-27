CREATE DATABASE mayorista_fiambres_lacteos_DB

GO
USE mayorista_fiambres_lacteos_DB

GO

--Tabla zonas_envio
CREATE TABLE zonas_envio (
  id_zona_envio int,
  descripcion VARCHAR(50),
  recargo_zona DECIMAL(10,2)
  CONSTRAINT pk_zona_envio PRIMARY KEY (id_zona_envio)
)

GO

--Tabla limites
CREATE TABLE limites_stock (
    id_limite_stock int NOT NULL,
    limite int NOT NULL,
    CONSTRAINT PK_limite_stock PRIMARY KEY (id_limite_stock)
)

-- Tabla estados pedido
CREATE TABLE estados_pedido (
    id_estado_pedido int NOT NULL,
    estado varchar(50) NULL,
    CONSTRAINT PK_estado_pedido PRIMARY KEY (id_estado_pedido)
)

GO

-- Tabla marcas
CREATE TABLE marcas (
    id_marca int IDENTITY(1,1),
    nombre varchar(50) NOT NULL,
    descripcion varchar(100),
    CONSTRAINT PK_marca PRIMARY KEY (id_marca)
)

GO

-- Tabla medios_pagos
CREATE TABLE medios_pagos (
    id_medio_pago int,
    nombre varchar(50) NOT NULL,
    recargo decimal(10,2),
    CONSTRAINT pk_medio_pago_id PRIMARY KEY (id_medio_pago)
)

GO

-- Tabla provincias
CREATE TABLE provincias (
    id_provincia int IDENTITY(1,1),
    provincia varchar(100) NOT NULL,
    CONSTRAINT fk_id_provincia PRIMARY KEY (id_provincia)
)

GO

-- Tabla tipos_productos
CREATE TABLE tipos_productos (
    id_tipo_producto int IDENTITY(1,1),
    nombre varchar(50) NOT NULL,
    descripcion varchar(100),
    CONSTRAINT PK_tipo_producto PRIMARY KEY (id_tipo_producto)
)

GO

-- Tabla categorias
CREATE TABLE categorias (
    id_categoria int IDENTITY(1,1),
    nombre varchar(50) NOT NULL,
    descripcion varchar(100),
    CONSTRAINT PK_categoria PRIMARY KEY (id_categoria)
)

GO

-- Tabla Tipos_Contactos
CREATE TABLE Tipos_Contactos (
    id_tipo_contacto INT IDENTITY(1,1) NOT NULL,
    tipo varchar(50) NOT NULL,
    CONSTRAINT pk_tipo_cont PRIMARY KEY (id_tipo_contacto)
)

GO

-- Tabla cargos
CREATE TABLE cargos (
    id_cargo INT IDENTITY(1,1),
    cargo VARCHAR(50) NOT NULL,
    CONSTRAINT pk_cargo PRIMARY KEY (id_cargo)
)

GO

-- Tabla canales_compras
CREATE TABLE canales_compras (
    id_canal_compra INT,
    descripcion VARCHAR(50) NOT NULL,
    CONSTRAINT pk_canal_compra PRIMARY KEY (id_canal_compra)
)

GO

-- Tabla Clientes
CREATE TABLE Clientes (
    id_cliente INT IDENTITY(1,1) NOT NULL,
    nombre_completo varchar(50) NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (id_cliente)
)

GO

-- Tabla tipos_movimientos
CREATE TABLE tipos_movimientos (
    id_mov_tipo int IDENTITY(1,1),
    tipo_mov varchar(50) NOT NULL,
    CONSTRAINT pk_tipo_mov PRIMARY KEY (id_mov_tipo)
)

GO

-- Tabla tipos_vehiculos
CREATE TABLE tipos_vehiculos (
    id_tipo_vehiculo int,
    tipo varchar(50) NOT NULL,
    CONSTRAINT pk_vehiculo PRIMARY KEY (id_tipo_vehiculo)
)

GO

--Tabla flotas
CREATE TABLE flotas (
  id_flota int,
  tipo_flota VARCHAR(50) NOT NULL, --INTERTA / EXTERNA
  nombre_flota VARCHAR(100),
  recargo DECIMAL(10,2) NOT NULL

  CONSTRAINT pk_flota PRIMARY KEY (id_flota)
)

GO

CREATE TABLE transportes (
  id_transporte int,
  flota_id int,
  nombre_transportista VARCHAR(100),
  cuit VARCHAR(15),
  telefono VARCHAR(20)

  CONSTRAINT pk_transporte PRIMARY KEY (id_transporte),
  CONSTRAINT FK_flota_transporte FOREIGN KEY (flota_id) REFERENCES flotas (id_flota)
)

GO

-- Tabla Direcciones_Entregas
CREATE TABLE Direcciones_Entregas (
    id_dir_entrega INT IDENTITY(1,1) NOT NULL,
    direccion varchar(50) NOT NULL,
    referencia varchar(50) NULL,
    cliente_id INT NULL,
	zona_envio_id INT 

    CONSTRAINT pk_dir_entrega PRIMARY KEY (id_dir_entrega)
	CONSTRAINT fk_zona_envio_dir_entr FOREIGN KEY (zona_envio_id) REFERENCES zonas_envio (id_zona_envio),
	CONSTRAINT fk_cliente_dir_entrega FOREIGN KEY (cliente_id) REFERENCES Clientes (id_cliente)
)

GO

-- Tabla ciudades
CREATE TABLE ciudades (
    id_ciudad int IDENTITY(1,1),
    ciudad varchar(100) NOT NULL,
    provincia_id int NOT NULL,
    CONSTRAINT pk_id_ciudad PRIMARY KEY (id_ciudad),
    CONSTRAINT fk_provincia_ciudad FOREIGN KEY (provincia_id) REFERENCES provincias (id_provincia)
)

GO

-- Tabla barrios
CREATE TABLE barrios (
    id_barrio int IDENTITY(1,1),
    barrio varchar(150) NOT NULL,
    ciudad_id int NOT NULL,
    CONSTRAINT pk_id_barrio PRIMARY KEY (id_barrio),
    CONSTRAINT fk_id_ciudad_barrio FOREIGN KEY (ciudad_id) REFERENCES ciudades (id_ciudad)
)

GO

-- Tabla sucursales
CREATE TABLE sucursales (
    id_sucursal int,
    nombre varchar(50) NOT NULL,
    direccion varchar(50) NOT NULL,
    telefono varchar(50) NOT NULL,
    barrio_id int NOT NULL,
    CONSTRAINT pk_sucursal PRIMARY KEY (id_sucursal),
    CONSTRAINT fk_barrio_sucursal FOREIGN KEY (barrio_id) REFERENCES barrios (id_barrio)
)

GO

CREATE TABLE vehiculos (
  id_vehiculo int,
  patente VARCHAR(10) NOT NULL,
  capacidad_kg DECIMAL(10,2),
  tipo_vehiculo_id int,
  transporte_id int,
  refrigeracion bit NULL

  CONSTRAINT pk_id_vehiculo PRIMARY KEY (id_vehiculo),
  CONSTRAINT FK_transporte_vehiculo FOREIGN KEY (transporte_id) REFERENCES transportes (id_transporte),
  CONSTRAINT FK_tipo_vehiculo_vehiculo FOREIGN KEY (tipo_vehiculo_id) REFERENCES tipos_vehiculos (id_tipo_vehiculo)
)

GO

-- Tabla depositos
CREATE TABLE depositos (
    id_deposito INT,
    cliente_id INT NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    capacidad DECIMAL(8,2) NOT NULL,
    CONSTRAINT pk_deposito PRIMARY KEY (id_deposito),
    CONSTRAINT fk_cliente_deposito FOREIGN KEY (cliente_id) REFERENCES clientes (id_cliente)
)

GO

-- Tabla hojas rutas
CREATE TABLE hojas_rutas (
    id_hoja_ruta INT IDENTITY(1,1),
    fecha DATE NOT NULL,
    transporte_id INT NOT NULL,
    observaciones VARCHAR(255) NULL,
    fecha_salida DATETIME NULL,
    fecha_regreso DATETIME NULL,
    distancia_km DECIMAL(10,2)

    CONSTRAINT pk_hoja_ruta PRIMARY KEY (id_hoja_ruta),
    CONSTRAINT fk_transporte_hoja_ruta FOREIGN KEY (transporte_id) REFERENCES transportes (id_transporte)
)

GO

-- Tabla Contactos
CREATE TABLE Contactos (
    id_contacto INT IDENTITY(1,1) NOT NULL,
    contacto varchar(100) NOT NULL,
    tipo_contacto_id int NOT NULL,
    cliente_id int NULL,
    CONSTRAINT pk_contacto PRIMARY KEY (id_contacto),
    CONSTRAINT fk_tipo_cont FOREIGN KEY (tipo_contacto_id) REFERENCES Tipos_contactos (id_tipo_contacto),
    CONSTRAINT fk_cliente_contacto FOREIGN KEY (cliente_id) REFERENCES Clientes (id_cliente)
)

GO

-- Tabla productos
CREATE TABLE productos (
    id_producto int,
    nombre varchar(50) NOT NULL,
    descripcion varchar(100),
    tipo_producto_id int NOT NULL,
    marca_id int NOT NULL,
    categoria_id int NOT NULL,
    peso_kg decimal(18,2),
	limite_stock_id int NOT NULL
    CONSTRAINT PK_producto PRIMARY KEY (id_producto),
    CONSTRAINT FK_marca_producto FOREIGN KEY (marca_id) REFERENCES marcas (id_marca),
    CONSTRAINT FK_tipo_producto FOREIGN KEY (tipo_producto_id) REFERENCES tipos_productos (id_tipo_producto),
    CONSTRAINT FK_categoria_producto FOREIGN KEY (categoria_id) REFERENCES categorias (id_categoria),
	CONSTRAINT FK_limite_stock_producto FOREIGN KEY (limite_stock_id) REFERENCES limites_stock (id_limite_stock)
)

GO

-- Tabla inventarios
CREATE TABLE inventarios (
    id_inventario int,
    sucursal_id int NOT NULL,
    producto_id int NOT NULL,
    cantidad int NOT NULL,
    CONSTRAINT pk_inventario PRIMARY KEY (id_inventario),
    CONSTRAINT fk_sucursal_inventario FOREIGN KEY (sucursal_id) REFERENCES sucursales (id_sucursal),
    CONSTRAINT FK_producto_inventario FOREIGN KEY (producto_id) REFERENCES productos (id_producto)
)

GO

-- Tabla empleados
CREATE TABLE empleados (
    id_empleado INT,
    sucursal_id INT NOT NULL,
    cargo_id INT NOT NULL,
    nombre_completo VARCHAR(90) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    supervisor_id INT NULL,
    barrio_id INT NULL,
    CONSTRAINT pk_id_empleado PRIMARY KEY (id_empleado),
    CONSTRAINT FK_empleados_supervisor FOREIGN KEY (supervisor_id) REFERENCES empleados (id_empleado),
    CONSTRAINT fk_sucursal_empleados FOREIGN KEY (sucursal_id) REFERENCES sucursales (id_sucursal),
    CONSTRAINT fk_cargo_empleados FOREIGN KEY (cargo_id) REFERENCES cargos (id_cargo),
    CONSTRAINT FK_empleados_barrios FOREIGN KEY (barrio_id) REFERENCES barrios (id_barrio)
)

GO

-- Tabla contactos_empleados
CREATE TABLE contactos_empleados (
    id_contacto_empleado INT NOT NULL,
    contacto varchar(50) NOT NULL,
    tipo_contacto_id int NULL,
    empleado_id int NULL,
    CONSTRAINT PK_contactos_empleados PRIMARY KEY (id_contacto_empleado),
    CONSTRAINT FK_contactos_empleados_empleados FOREIGN KEY (empleado_id) REFERENCES empleados (id_empleado),
    CONSTRAINT FK_contactos_empleados_Tipos_Contactos FOREIGN KEY (tipo_contacto_id) REFERENCES Tipos_Contactos (id_tipo_contacto)
)

GO

-- Tabla pedidos
CREATE TABLE pedidos (
    id_pedido INT,
    empleado_armado_id INT NOT NULL,
    fecha DATE NOT NULL,
    canal_compra_id INT NOT NULL,
	estado_id int,
	direccion_entrega_id int NOT NULL

    CONSTRAINT pk_pedido PRIMARY KEY (id_pedido),   
	CONSTRAINT fk_direccion_entrega_pedido FOREIGN KEY (direccion_entrega_id) REFERENCES direcciones_entregas (id_dir_entrega),
    CONSTRAINT fk_empleado_armado_pedidos FOREIGN KEY (empleado_armado_id) REFERENCES empleados (id_empleado),
    CONSTRAINT fk_canal_compra_pedidos FOREIGN KEY (canal_compra_id) REFERENCES canales_compras (id_canal_compra),
	CONSTRAINT fk_estado_pedido FOREIGN KEY (estado_id) REFERENCES estados_pedido (id_estado_pedido)
)

GO

-- Tabla Facturas
CREATE TABLE Facturas (
    id_factura int NOT NULL,
    pedido_id int NOT NULL,
    sucursal_id int NOT NULL,
    empleado_factura_id int NOT NULL,
    transporte_id int NULL,   
    fecha date NOT NULL,
    subtotal decimal(10,2) NOT NULL	


    CONSTRAINT pk_id_factura PRIMARY KEY (id_factura),
    CONSTRAINT fk_pedido_id FOREIGN KEY (pedido_id) REFERENCES pedidos (id_pedido),
    CONSTRAINT fk_sucursal_id FOREIGN KEY (sucursal_id) REFERENCES sucursales (id_sucursal),
    CONSTRAINT fk_empleado_factura_id FOREIGN KEY (empleado_factura_id) REFERENCES empleados (id_empleado),
    CONSTRAINT fk_transporte_factura FOREIGN KEY (transporte_id) REFERENCES transportes (id_transporte)
)

GO

-- Tabla Facturas_medios_pago
CREATE TABLE Facturas_medios_pago (
    id_factura_medio_pago int,
    monto decimal(10,2) NOT NULL,
    medio_pago_id int NOT NULL,
    factura_id int NULL,
    CONSTRAINT pk_factura_medio_pago PRIMARY KEY (id_factura_medio_pago),
    CONSTRAINT fk_factura_id FOREIGN KEY (factura_id) REFERENCES facturas (id_factura),
    CONSTRAINT fk_medio_pago_id FOREIGN KEY (medio_pago_id) REFERENCES medios_pagos (id_medio_pago)
)

GO

-- Tabla detalles_facturas
CREATE TABLE detalles_facturas (
    id_det_fact int,
    factura_id int NOT NULL,
    producto_id int NOT NULL,
    cantidad int NOT NULL,
    prec_uni decimal(10,2) NOT NULL,
    peso_total_kg decimal(15,2) NULL,
    CONSTRAINT pk_det_factura PRIMARY KEY (id_det_fact),
    CONSTRAINT fk_factura_det_fac FOREIGN KEY (factura_id) REFERENCES facturas (id_factura),
    CONSTRAINT fk_producto_det_fac FOREIGN KEY (producto_id) REFERENCES productos (id_producto)
)

GO

-- Tabla detalle_pedidos
CREATE TABLE detalle_pedidos (
    id_det_pedido int,
    producto_id int NOT NULL,
    cantidad int NOT NULL,
    prec_uni decimal(10,2) NOT NULL,
    pedido_id int NOT NULL,
    peso_total_kg decimal(15,2) NULL,
    CONSTRAINT pk_det_pedido PRIMARY KEY (id_det_pedido),
    CONSTRAINT fk_prod_det_ped FOREIGN KEY (producto_id) REFERENCES productos (id_producto),
    CONSTRAINT fk_pedido_det_ped FOREIGN KEY (pedido_id) REFERENCES pedidos (id_pedido)
)

GO

-- Tabla registro_inventario
CREATE TABLE registro_inventario (
    id_registro int NOT NULL,
    producto_id int NOT NULL,
    sucursal_id int NOT NULL,
    tipo_movimiento_id int NOT NULL,
    cantidad int NOT NULL,
    motivo varchar(70) NULL,
    fecha datetime NOT NULL,
    sucursal_destino_id int NULL,
    CONSTRAINT PK_registro_inventario PRIMARY KEY (id_registro),
    CONSTRAINT fk_prod_registro FOREIGN KEY (producto_id) REFERENCES productos (id_producto),
    CONSTRAINT fk_suc_registro FOREIGN KEY (sucursal_id) REFERENCES sucursales (id_sucursal),
    CONSTRAINT fk_tipo_mov FOREIGN KEY (tipo_movimiento_id) REFERENCES tipos_movimientos (id_mov_tipo),
    CONSTRAINT fk_suc_destino FOREIGN KEY (sucursal_destino_id) REFERENCES sucursales (id_sucursal)
)

GO

-- Tabla detalles hoja ruta
CREATE TABLE detalles_hoja_ruta (
    id_detalle_hoja_ruta INT IDENTITY(1,1),
    hoja_ruta_id INT NOT NULL,
    pedido_id INT NOT NULL,
    direccion_entrega_id INT NOT NULL,
    orden_entrega INT NOT NULL,
    hora_estimada_entrega TIME NULL,
    hora_real_entrega TIME NULL,
    observacion_entrega VARCHAR(255) NULL,
    
    CONSTRAINT pk_detalle_hoja_ruta PRIMARY KEY (id_detalle_hoja_ruta),
    CONSTRAINT fk_hoja_ruta_detalle FOREIGN KEY (hoja_ruta_id) REFERENCES hojas_rutas (id_hoja_ruta),
    CONSTRAINT fk_pedido_detalle_hoja FOREIGN KEY (pedido_id) REFERENCES pedidos (id_pedido),
    CONSTRAINT fk_dir_entrega_detalle_hoja FOREIGN KEY (direccion_entrega_id) REFERENCES Direcciones_Entregas (id_dir_entrega)
)

GO

--SET DATEFORMAT dmy;

------------INSERTS
--marcas
--GO

insert into marcas (nombre, descripcion) values 
('Fiambres Artesanales Don José', 'Elaborados con recetas tradicionales y carnes premium'),  
('Chacras del Sur', 'Jamones crudos y cocidos madurados naturalmente'),  
('Embutidos La Estancia', 'Salamines y chorizos ahumados con leña de roble'),  
('Quesería y Fiambrería La Abuela', 'Productos artesanales sin conservantes artificiales'),  
('Delicias del Iberá', 'Fiambres bajos en sodio y aptos para celíacos'),
('Lácteos Campo Verde', 'Leche orgánica y quesos frescos de vacas pastoreadas'),  
('Quesos El Colonial', 'Quesos añejos en cámaras naturales por más de 12 meses'),  
('Manteca La Serenísima', 'Manteca premium con 85% de materia grasa láctea'),  
('Yogurtería Fresco', 'Yogures probióticos con frutas de estación'),  
('Dulce de Leche Estrella', 'Elaborado con leche entera y cocción a fuego lento'),
('Pampa Gourmet', 'Fiambres y lácteos para gastronomía profesional'),  
('Caserío del Valle', 'Productos regionales con certificación de origen');

--medios de pagos
GO

insert into medios_pagos (id_medio_pago, nombre, recargo) values (1, 'Efectivo', 0),  (2, 'Tarjeta débito', 0),  (3, 'Tarjeta crédito', 0.3),(4, 'Transferencia', 0),(5, 'Pago con QR', 0.2);

--zonas envios
GO

INSERT INTO zonas_envio (id_zona_envio, descripcion, recargo_zona)
VALUES (1, 'Zona Norte', 0.00), (2, 'Zona Centro', 12.50), (3, 'Zona Sur', 0.00), (4, 'Zona Este', 7.80), (5, 'Zona Oeste', 0.00),(6, 'Zona Noreste', 11.00);

--provincias
GO

INSERT INTO provincias ( provincia) VALUES
('Buenos Aires'),
('Córdoba'),
('Santa Fe'),
('Mendoza'),
('Tucumán'),
('Salta'),
('Entre Ríos'),
('Corrientes'),
('Chaco'),
( 'San Juan'),
( 'Jujuy'),
( 'Río Negro'),
( 'Misiones'),
( 'Santiago del Estero'),
( 'Ciudad Autónoma de Buenos Aires');

--tipos productos
GO

INSERT INTO tipos_productos (nombre, descripcion) VALUES
('Fiambres', 'Productos cárnicos curados y procesados para consumo en frío'),
('Lácteos', 'Derivados de leche para consumo humano'),
('Fiambres Premium', 'Cortes seleccionados con procesos de maduración extendidos'),
('Lácteos Deslactosados', 'Productos lácteos sin lactosa para dietas especiales'),
('Fiambres Ahumados', 'Carnes sometidas a procesos de ahumado natural'),
('Lácteos Fermentados', 'Productos con cultivos vivos y procesos bioactivos'),
('Fiambres Especiados', 'Embutidos con mezclas exclusivas de especias'),
('Lácteos Light', 'Versiones reducidas en grasas y calorías'),
('Fiambres de Aves', 'Embutidos y cortes fríos de pollo y pavo'),
('Lácteos Vegetales', 'Alternativas vegetales a base de soja y almendras');
							
--categorias
GO

INSERT INTO categorias (nombre, descripcion) VALUES
('Frescos', 'Productos que requieren refrigeración inmediata'),
('Congelados', 'Alimentos Congelados'),
('Orgánicos', 'Productos naturales sin conservantes'),
('Económicos', 'Línea de productos de costo reducido'),
('Gourmet', 'Productos de la mas alta calidad'),
('Sin TACC', 'Aptos para celíacos, sin trigo, avena, cebada ni centeno'),
('Importados', 'Productos de origen internacional'),
('Picadas', 'Tabla de picada armada'),
('Porciones Individuales', 'Empaquetado para consumo unitario'),
('Granel', 'Producto suelto por mayor');

--tipos contactos
GO

INSERT INTO Tipos_Contactos (tipo) VALUES
('Email'),
('Teléfono móvil'),
('Teléfono fijo'),
('Telegram');

--cargos
GO

INSERT INTO cargos (cargo) VALUES
('Gerente General'),
('Jefe de Ventas Mayoristas'),
('Supervisor de Almacén'),
('Coordinador de Logística'),
('Analista de Compras'),
('Representante de Atención al Cliente'),
('Especialista en Control de Calidad'),
('Supervisor de Seguridad Alimentaria'),
('Jefe de Recursos Humanos'),
('Coordinador de Transporte Refrigerado'),
('Asistente de Inventarios'),
('Supervisor de Flota');

--canales de compras
GO

INSERT INTO canales_compras (id_canal_compra, descripcion) VALUES
(1, 'Tienda Online'),
(2, 'Visita en Sucursal'),
(3, 'Llamado Telefónico');

--tipos de vehiculos
GO

INSERT INTO tipos_vehiculos (id_tipo_vehiculo, tipo) VALUES
(1, 'Camión'),
(2, 'Furgoneta'),
(3, 'Camioneta de Reparto'),
(4, 'Tráiler'),
(5, 'Utilitario');

--estado pedidos
GO

INSERT INTO estados_pedido (id_estado_pedido, estado) VALUES
(1, 'Recibido'),
(2, 'En Preparación'),
(3, 'Listo para Despacho'),
(4, 'En Camino'),
(5, 'Entregado'),
(6, 'Cancelado'),
(7, 'Rechazado por Stock');

--Clientes
GO

INSERT INTO Clientes (nombre_completo) VALUES

('Distribuidora La Anónima S.A.'),
('Carnicerías Pampeanas Ltda.'),
('Alimentos Frescos del Sur'),
('Mayorista Don Gaucho'),
('Cadena de Queserías Patagonia'),
('Supermercado Granja'),
('Maxikiosco El Dandy'),
('Fiambreria La Gallega'),
('Distribuidora El Salame'),
('Despensa El Norte');

--ciudades
GO

INSERT INTO ciudades (ciudad, provincia_id) VALUES
('La Plata', 1),
('Mar del Plata', 1),
('Bahía Blanca', 1),
('Córdoba Capital', 2),
('Villa María', 2),
('Tartagal',6),
('Despeñaderos',2),
('Lozada',2),
('Alta Gracia',2),
('Puerto Iguazú',13);

--barrios
GO

INSERT INTO barrios (barrio, ciudad_id) VALUES
('Centro', 1),
('Tolosa', 1),
('La Perla', 2),
('General Paz', 4),
('Nueva Córdoba', 4),
('Almirante Brown',5),
('Palermo',5),
('Barrio Sur',9),
('Parque del virrey',9),
('Independiente Rivadavia',9);

--sucursales
GO

INSERT INTO sucursales (id_sucursal, nombre, direccion, telefono, barrio_id) VALUES
(1001, 'Central Frigorífica', 'Av. 7 1250', '221-555-1001', 1),
(1002, 'Zona Portuaria', 'Alvarado 2200', '223-555-2002', 3),
(1003, 'Distribución Córdoba', 'Bv. San Juan 550', '351-555-3003', 5),
(1004,'Sucursal NortePack', 'Av. Los Fresnos 1234','351-6098234',3),
(1005,'LogiCentro','Calle 9 de Julio 567', '351-7841200',4),
(1006,'Sucursal Distribeck','Boulevard Central 8900','351-4329187',2),
(1007,'Distribución FiamExpress','Ruta Provincial 20 km 12,5','351-5500912',7),
(1008,'Sucursal PuntoFrío','Pasaje El Ceibo 245','351-6654778',6),
(1009,'Sucursal RápidoSur','Camino a La Estancia 3321','351-8124567',8),
(1010,'Sucursal MaxiRuta','Av. San Martín 4020','351-7903345',6);


---limites_stock 
GO

INSERT INTO limites_stock (id_limite_stock, limite) VALUES 
(1, 30),
(2, 13),
(3, 6),
(4, 21),
(5, 51),
(6, 63),
(7, 86),
(8, 25),
(9, 40),
(10, 75),
(11, 100),
(12, 10);
---Productos 
GO

INSERT INTO productos (id_producto, 	nombre,				descripcion,				tipo_producto_id,			marca_id,		categoria_id,		peso_kg,	limite_stock_id) VALUES
			(879,		'Jamón Cocido Premium', 	'Corte seleccionado',			1,					1,			5,			2.5,		11),
			(880,		'Queso Gouda Ahumado',		'Madurado 6 meses',			2,					4,			8,			3.0,		3),
			(932,		'Salchichón Primavera',		'Elaboración Artesanal',		3,					11,			7,			1.8,		11),
			(965,		'Salame Colonia Caroya',	'Elaboración Artesanal',		3,					4,			1,			0.5,		5),
			(876,		'Bondiola especiada',		'Producto Regional',			7,					12,			5,			1.0,		10),
			(345,		'parmesano reggiano',		'Importado de Italia',			2,					4,			7,			10.0,		3),
			(456,		'Queso Light',			'Producto dietetico',			8,					7,			3,			1.5,		5),
			(623,	'Salame Milán Picado Grueso',		'Gama económica',			1,					2,			4,			5.0,		9),
			(765,		'Crema De Leche',		'producto suelto',			2,					10,			10,			null,		8),
			(133,		'Mortadela bologna Light',	'Importado de Italia',			1,					5,			6,			2.0,		8),
			(423,		'Queso Cremoso',		'producto regional',			2,					7,			1,			1.2,		10),
			(647,		'Jamón Natural',		'Producto regional cordobés',		1,					2,			5,			2.0,		2),
			(234,		'Yogur Bebible',		'Frutilla y durazno',			10,					9,			10,			0.9,		7),
			(843,		'Salchicha Viena',		'segunda marca',			1,					4,			4,			1.0,		12),
			(754,		'Leche Descremada',		'Envasada en origen',			3,					6,			3,			1.0,		6);							
							
---Inventarios
GO

INSERT INTO inventarios (id_inventario, sucursal_id, producto_id, cantidad) VALUES
(7011, 1001, 879, 120),
(7012, 1002, 880, 95), 
(7013, 1003, 932, 180),
(7014, 1004, 965, 210),
(7015, 1005, 876, 130),
(7016, 1006, 345, 45), 
(7017, 1007, 456, 160),
(7018, 1008, 623, 200),
(7019, 1009, 765, 110),
(7020, 1010, 133, 185),
(7021, 1002, 423, 90), 
(7022, 1003, 647, 140),
(7023, 1001, 234, 155),
(7024, 1002, 843, 190),
(7025, 1003, 754, 170);

---Tipos movimientos
GO

INSERT INTO tipos_movimientos (tipo_mov) VALUES
('Entrada'),
('Salida'),
('Ajuste de stock');

--- registro inventario
GO

INSERT INTO registro_inventario (id_registro, 	producto_id, 	sucursal_id, 	tipo_movimiento_id, 	cantidad, 	motivo, 		fecha, 			sucursal_destino_id) VALUES
				(8101, 		879, 		1001, 		1, 			120, 		'Stock inicial', 	'2024-02-14 09:30', 	NULL),
				(8102, 		880, 		1002, 		2, 			-30, 		'Venta a cliente', 	'2024-07-22 11:10', 	NULL),
				(8103, 		932, 		1004, 		3, 			-5, 		'Reconteo físico', 	'2025-01-10 15:00', 	NULL),
				(8104, 		965, 		1001, 		1, 			210, 		'Reposición mensual', 	'2024-03-18 08:45', 	1002),
				(8105, 		876, 		1002, 		2, 			-40, 		'Despacho mayorista', 	'2025-03-04 10:15', 	1003),
				(8106, 		345, 		1003, 		3, 			3, 	'Ajuste por ingreso no registrado', '2024-12-01 07:50', 1001),
				(8107, 		456, 		1005, 		1, 			160, 		'Stock inicial', 	'2024-10-19 14:20', 	NULL),
				(8108, 		623, 		1006, 		2, 			-60, 		'Salida por pedido', 	'2025-04-15 09:00', 	NULL),
				(8109, 		765, 		1007, 		1, 			110, 		'Stock inicial', 	'2024-06-21 12:00', 	NULL),
				(8110, 		133, 		1008, 		3, 			-10, 		'Pérdida por rotura', 	'2025-03-30 16:10', 	NULL),
				(8111, 		423, 		1009, 		1, 			90, 		'Compra a proveedor', 	'2024-02-28 08:30', 	NULL),
				(8112, 		647, 		1003, 		2, 			-50, 		'Remito a sucursal', 	'2024-11-12 13:35', 	1001),
				(8113, 		234, 		1001, 		3, 			5, 		'Ingreso por ajuste', 	'2025-02-18 10:25', 	NULL),	
				(8114, 		843,		1010, 		1, 			190, 		'Stock inicial', 	'2024-05-03 09:45', 	NULL),
				(8115, 		754, 		1003, 		2, 			-70, 		'Venta mayorista', 	'2024-08-24 11:50', 	NULL);


--INSERTS EMPLEADOS
GO

INSERT INTO empleados (id_empleado, sucursal_id, cargo_id, nombre_completo, direccion, supervisor_id, barrio_id) 
VALUES                (101,         1001,            2,     'Juan Pérez',  'Gob. Roca 334', 110,          1),
(102,         1002,            3,     'Hector Dominguez',  'Francia 2', 101,          2),
 (103,         1001,            5,     'Rocio Cabrera',  'Nilo 33 ', 105,          1)
,(104,         1003,            5,     'Paula Salomon',  'Polonia 121', 105,          5)
,(105,         1002,            4,     'Matias Colomar',  'Las Amapolas 109', 102,          5)
,(106,         1004,            6,     'Alexander Herrrera',  'Los Andes 99', 105,          3)
,(107,         1006,            6,     'Thiago Silva',  'Rio De La Plata 34', 105,          5)
,(108,         1004,            7,     'Pablo Zambrotta',  'Rio Parana 555', 102,          3)
,(109,         1007,            8,     'Enzo Fernandez',  'Rawson 1001', 110,          9)
,(110,         1002,            1,     'Exequiel Santoro',  '25 De Mayo 709', NULL,          7)
,(111,         1008,            9,     'Agustin Palacios',  '9 De Julio 335', 110,          8)
,(112,         1006,            10,     'Juan Ocampos',  'Italia 98', 101,          5)
,(113,         1005,            11,     'Lucas Buffa',  'India 1111', 103,          5)
,(114,         1001 ,            12,     'Fransisco Cordoba',  'Rio Negro 100', 110,          1)
,(116,            1002,            4,        'Mariana Díaz', 'Calle 45 200', 102, 3)
,(117,            1002,            7,        'Carlos Méndez', 'Av. Libertador 1223', 102, 3)
,(118,            1002,            5,        'Soledad Peralta', 'Pasaje Luna 98', 102, 2)
,(119,            1002,            6,        'Pedro Alvarez', 'Mitre 321', 102, 2)
,(120,            1002,            6,        'Luciana Vera', 'Belgrano 999', NULL, 2)
,(121,            1003,            6,        'Ernesto Ramírez', 'Sarmiento 12', 104, 2);

--INSERTS CONTACTOS
GO

INSERT INTO Contactos (contacto, tipo_contacto_id, cliente_id)  
VALUES  
('contacto@laanonima.com.ar', 1, 1),  
('+54 11 4321-0000', 3, 1),  
('ventas@pampeanascarnes.com', 1, 2),  
('+54 291 455-6789', 3, 2),  
('info@frescosdelsur.com', 1, 3),  
('+54 221 512-3400', 3, 3),  
('logistica@donghaucho.com', 1, 4),  
('+54 351 600-1234', 2, 4),  
('administracion@queseriapatagonia.com', 1, 5),  
('+54 294 477-8899', 3, 5),  
('compras@supermercadogranja.com', 1, 6),  
('@SuperGranjaOficial', 4, 6),  
('maxidandy@kioscoelite.com', 1, 7),  
('+54 261 533-2020', 2, 7),  
('clientes@fiambrerialagallega.com', 1, 8),  
('+54 341 409-8765', 3, 8),  
('pedidos@distribuidoraelsalame.com', 1, 9),  
('+54 299 488-1122', 2, 9),  
('soporte@despensaelnorte.com', 1, 10),  
('+54 387 512-3456', 3, 10); 

--INSERTS CONTACTOS_EMPLEADOS
GO

INSERT INTO contactos_empleados (id_contacto_empleado, contacto, tipo_contacto_id, empleado_id) 
VALUES (2001, 'Juanperez@gmail.com', 1, 101),
(2002, '+54 678 898-6799', 2, 102),
(2003, '+54 333 444-5555', 2, 103),
(2004, '021 521-1478', 3, 104),
(2005, '@MColomar', 4, 105),
(2006, '+54 868 777-1111', 2, 106),
(2007, '@T_silva', 4, 107),
(2008, '555 555-5555', 3, 108),
(2009, 'Enzofernandez@gmail.com.', 1, 109),
(2010, 'Exequielsantoro@lanonima.com.ar', 1, 110),
(2011, '+54 435 345-3456', 2, 111),
(2012, '000 890-5467', 3, 112),
(2013, '+54 222 666-6666', 2, 113),
(2014, '+54 333 738-8737', 2, 114),
(2015, '@Maria_diaz', 1, 116),
(2016, '@carlos_m', 4, 117),
(2017, '@sole07', 4, 118),
(2018, '@pedro_alv', 4, 119),
(2019, '@luciVera', 4, 120);

--Direcciones_Entregas
GO

INSERT INTO Direcciones_Entregas(direccion,referencia,cliente_id,zona_envio_id) VALUES 
('8043 Oriole Avenue','Portón negro', 1, 3),
('17 Warbler Court', NULL, 2, 4),
('37 Springs Avenue', 'Frente al hospital', 3, 5), 
('11 Loftsgordon Street',NULL, 4, 1),
('Ruta Nacional 9 km 45','A 300 metros del cruce con la Ruta 19',5,1),
('Calle Los Naranjos 620','A la vuelta de la estación de servicio YPF',6,2),
('Pasaje Monteverde 850',NULL,7,1),
('Av. Córdoba 3400',NULL,8,4),
('Camino San Pedro 112',NULL,9,5),
('Av. Las Palmeras 1540','Frente al supermercado mayorista Macro',10,2);

-- TABLA pedidos
GO

INSERT INTO pedidos (id_pedido, empleado_armado_id, fecha, canal_compra_id, estado_id, direccion_entrega_id) VALUES
                       (1,              101,       '2025-05-01',    1,            2,           1),
                       (2,              102,       '2025-05-02',    2,            3,           2),
                       (3,              103,       '2025-05-03',    1,            2,           3),
                       (4,              101,       '2025-05-04',    2,            1,           4),
                       (5,              102,       '2025-05-05',    1,            3,           5),
                       (6,              104,       '2025-05-05',    1,            3,           6),
                       (7,              105,       '2025-05-05',    1,            3,           7),
                       (8,              106,       '2025-05-05',    1,            3,           8),
                       (9,              107,       '2025-05-05',    1,            3,           9),
                       (10,              108,       '2025-05-05',    1,            3,           10);

-- TABLA detalle_pedidos
GO

INSERT INTO detalle_pedidos (id_det_pedido, producto_id, cantidad, prec_uni, pedido_id, peso_total_kg) VALUES
                                (1,            879,           10,     1200.00,     1,         12.0),
                                (2,            880,            5,      900.00,     1,          5.5),
                                (3,            932,            8,      500.00,     2,          4.0),
                                (4,            965,            3,      1500.00,    2,          9.0),
                                (5,            876,            6,      800.00,     3,          5.4),
                                (6,            456,            10,      950.00,    3,          11.0),
                                (7,            879,            4,      1200.00,    4,          4.8),
                                (8,            880,            7,      900.00,     4,          7.7),
                                (9,            932,            10,      500.00,    5,          5.0);
---Flotas
GO

INSERT INTO flotas (id_flota, tipo_flota, nombre_flota, recargo) VALUES
(2001, 'INTERNA', 'Flota Pequeña', 0.00),
(2002, 'EXTERNA', 'Flota Pequeña', 15.00),
(2003, 'INTERNA', 'Flota Mediana', 0.00),
(2004, 'EXTERNA', 'Flota Mediana', 25.00),
(2005, 'INTERNA', 'Flota Grande', 0.00),
(2006, 'EXTERNA', 'Flota Grande', 30.00);


---Transportes
GO

INSERT INTO transportes (id_transporte, flota_id, nombre_transportista, cuit, telefono) VALUES
(3001, 2001, 'Juan Perez', '30-12345678-9', '0800-555-0001'),
(3002, 2002, 'Alberto Fernandez', '30-87654321-0', '0800-555-0002'),
(3003, 2003, 'Cristian Castro', '20-01654327-3', '0800-555-0003'),
(3004, 2004, 'Cristiano Ronaldo', '25-31054027-3', '0800-555-0004'),
(3005, 2005, 'Roberto Carlos', '29-32054322-8', '0800-555-0005'),
(3006, 2006, 'Ricardo Montaner', '31-52554525-5', '0800-555-0006'),
(3007, 2001, 'Carlos Gardel', '21-72757527-7', '0800-555-0007'),
(3008, 2002, 'Abel Pintos', '11-92957929-9', '0800-555-0008'),
(3009, 2003, 'Juan Román Riquelme', '14-44947424-4', '0800-555-0019');


-- TABLA facturas
GO

INSERT INTO facturas (id_factura, pedido_id, sucursal_id, empleado_factura_id, transporte_id, fecha, subtotal) VALUES
                       (1,            1,          1001,           101,                      3001, '2025-05-01', 19500.00),
                       (2,            2,          1001,           102,                      3002, '2025-05-02', 11400.00),
                       (3,			  3,		1002,		  103,					  3001, '2025-05-03', 16700.00),  
					   (4,			  4,		1001,		  104,					  NULL, '2025-05-04', 11100.00),  
					   (5,			  5,		1002,		  102,					  3002, '2025-05-05', 5000.00)

-- TABLA facturas_medios_pago
GO

INSERT INTO facturas_medios_pago (id_factura_medio_pago, monto, medio_pago_id, factura_id) VALUES
                                   (1,                  10000.00,     1,           1),
                                   (2,                  6500.00,      2,           1),
                                   (3,                  6400.00,      1,           2),
                                   (4,                  5000.00,      3,           2),
                                   (5,                  6700.00,      1,           3),
                                   (6,                  10000.00,     2,           3),
                                   (7,                  11100.00,     1,           4),
                                   (8,                  5000.00,      3,           5);

-- TABLA detalles_facturas
GO

INSERT INTO detalles_facturas (id_det_fact, factura_id, producto_id, cantidad, prec_uni, peso_total_kg) VALUES
                                (1,           1,          879,          10,       1200.00,     12.0),
                                (2,           1,          880,          5,         900.00,      5.5),
                                (3,           2,          932,          8,         500.00,      4.0),
                                (4,           2,          965,          3,        1500.00,      9.0),
                                (5,           3,          876,          6,         800.00,      5.4),
                                (6,           3,          345,          10,        950.00,      11.0),
                                (7,           4,          879,          4,         1200.00,     4.8),
                                (8,           4,          880,          7,          900.00,     7.7),
                                (9,           5,          932,          10,         500.00,     5.0);

--Tabla vehiculos
GO

INSERT INTO vehiculos (id_vehiculo, patente, capacidad_kg, tipo_vehiculo_id, transporte_id, refrigeracion) VALUES
(4001, 'AB123CD', 5000.00, 1, 3001, 1),
(4002, 'EF456GH', 3000.00, 2, 3002, 1),
(4003, 'QE456GH', 1000.00, 3, 3001, 0),
(4004, 'RE456GR', 6000.00, 1, 3005, 1),
(4005, 'SE456GS', 10000.00, 1, 3001, 1),
(4006, 'XE456GX', 3000.00, 3, 3008, 0),
(4007, 'YE456GY', 5500.00, 4, 3003, 1),
(4008, 'ZE456GZ', 15000.00, 1, 3006, 1),
(4009, 'VE456GV', 1100.00, 3, 3009, 1),
(4010, 'IE456GI', 5001.20, 5, 3004, 0);

---hojas_rutas
GO

INSERT INTO hojas_rutas (fecha, transporte_id, observaciones, fecha_salida, fecha_regreso, distancia_km) VALUES
('2024-03-15', 3001, 'Ruta 2 - Control térmico permanente', '2024-03-15 07:00', '2024-03-15 19:30', 450.00),
('2023-04-01', 3002, 'Ruta sin incidencias', '2023-04-01 12:00', '2023-04-01 15:03', 120.00),
('2022-01-16', 3003, NULL, '2022-01-16 14:10', '2022-01-16 19:30', 40.00),
('2025-11-22', 3004, 'Ruta con desvío por obras viales', '2025-11-22 09:10', '2025-11-22 13:13', 111.50),
('2022-06-03', 3005, 'Ruta estándar sin incidencias', '2022-06-03 18:20', '2022-06-03 18:55', 30.10),
('2023-04-01', 3006, 'Reposición de stock', '2023-04-01 12:00', '2023-04-01 15:03', 120.00),
('2024-05-30', 3007, 'Entrega fuera de horario pactado', '2024-05-30 21:00', '2024-05-30 23:55', 100.09),
('2023-06-10', 3008, NULL, '2023-06-10 10:15', '2023-06-10 12:30', 75.00),
('2025-01-20', 3009, 'Ruta costera con alta demanda', '2025-12-20 08:30', '2025-12-20 18:45', 250.00),
('2025-04-01', 3001, 'Ruta de prueba', '2025-04-01 12:05', '2025-04-01 15:03', 23.00),
('2023-12-01', 3002, NULL, '2023-12-01 11:45', '2023-12-01 13:12', 55.00);

---Detalles_hoja_ruta
GO

INSERT INTO detalles_hoja_ruta (hoja_ruta_id, pedido_id, direccion_entrega_id, orden_entrega, hora_estimada_entrega) VALUES
(1, 1, 1, 1, '20:00'),
(2, 2, 2, 2, '15:00'),
(3, 3, 3, 3, '20:30'),
(4, 4, 4, 4, '20:00'),
(5, 5, 5, 5, '14:30'),
(6, 6, 6, 6, '15:10'),
(7, 7, 7, 7, '21:00'),
(8, 8, 8, 8, '11:30'),
(9, 9, 9, 9, '17:45'),
(10, 10, 10, 10, '15:00');

--Depositos
GO

INSERT INTO depositos (id_deposito, cliente_id, direccion, capacidad) VALUES
(5001, 1, 'Av. 7 1300', 10000.00),
(5002, 2, 'Ruta 3 km 12, Berisso', 15000.00),  
(5003, 3, 'Calle 60 1200, Ensenada', 8000.00),  
(5004, 4, 'Av. Montevideo 450, CABA', 20000.00),  
(5005, 5, 'Camino Centenario 2200, Tolosa', 7500.00),
(5006, 6, 'Ruta 3 km 15, Berisso', 18000.00),  
(5007, 7, 'Calle 10 333, Berisso', 12000.00),  
(5008, 8, 'Av. Circunvalación 2000, Berisso', 16000.00),  
(5009, 9, 'Ruta 11 km 8, Berisso', 22000.00),  
(5010, 10, 'Calle 25 789, Berisso', 9000.00),
(5011, 2, 'Ruta 3 km 12, Berisso (Sector Norte)', 15000.00);


-- Inserts adicionales para satisfacer algunas consultas
GO

-- Primero, agregar más direcciones de entrega en Zona Centro (id = 2)
INSERT INTO Direcciones_Entregas(direccion, referencia, cliente_id, zona_envio_id) VALUES 
('Av. San Martín 1450', 'Entre calles 14 y 15', 3, 2),
('Calle 7 890', 'Edificio azul', 5, 2),
('Diagonal 74 N° 1200', 'Local comercial', 7, 2),
('Calle 50 N° 567', 'Frente a la plaza', 8, 2),
('Av. 1 N° 2100', 'Esquina con calle 21', 9, 2);
GO

-- Agregar más pedidos para el año 2025 con las nuevas direcciones
INSERT INTO pedidos (id_pedido, empleado_armado_id, fecha, canal_compra_id, estado_id, direccion_entrega_id) VALUES
(11, 103, '2025-05-06', 1, 5, 11),
(12, 104, '2025-05-07', 2, 5, 12),
(13, 105, '2025-05-08', 1, 5, 13),
(14, 106, '2025-05-09', 2, 5, 14),
(15, 107, '2025-05-10', 1, 5, 15);
GO

-- Agregar más detalles de pedidos
INSERT INTO detalle_pedidos (id_det_pedido, producto_id, cantidad, prec_uni, pedido_id, peso_total_kg) VALUES
(10, 345, 5, 1800.00, 11, 50.0),
(11, 647, 8, 1100.00, 11, 16.0),
(12, 423, 12, 750.00, 12, 14.4),
(13, 234, 15, 450.00, 12, 13.5),
(14, 754, 10, 380.00, 13, 10.0),
(15, 843, 20, 520.00, 13, 20.0),
(16, 133, 6, 980.00, 14, 12.0),
(17, 765, 25, 290.00, 14, NULL),
(18, 876, 8, 1150.00, 15, 8.0),
(19, 456, 18, 650.00, 15, 27.0);
GO

-- Agregar más facturas para el año 2025
INSERT INTO facturas (id_factura, pedido_id, sucursal_id, empleado_factura_id, transporte_id, fecha, subtotal) VALUES
(6, 11, 1003, 103, 3003, '2025-05-06', 17800.00),
(7, 12, 1004, 104, 3004, '2025-05-07', 15750.00),
(8, 13, 1005, 105, 3005, '2025-05-08', 14200.00),
(9, 14, 1006, 106, 3006, '2025-05-09', 13130.00),
(10, 15, 1007, 107, 3007, '2025-05-10', 20900.00);
GO

-- Agregar más detalles de facturas
INSERT INTO detalles_facturas (id_det_fact, factura_id, producto_id, cantidad, prec_uni, peso_total_kg) VALUES
(10, 6, 345, 5, 1800.00, 50.0),
(11, 6, 647, 8, 1100.00, 16.0),
(12, 7, 423, 12, 750.00, 14.4),
(13, 7, 234, 15, 450.00, 13.5),
(14, 8, 754, 10, 380.00, 10.0),
(15, 8, 843, 20, 520.00, 20.0),
(16, 9, 133, 6, 980.00, 12.0),
(17, 9, 765, 25, 290.00, NULL),
(18, 10, 876, 8, 1150.00, 8.0),
(19, 10, 456, 18, 650.00, 27.0);
GO

-- Agregar medios de pago para las nuevas facturas con montos > 1000
INSERT INTO facturas_medios_pago (id_factura_medio_pago, monto, medio_pago_id, factura_id) VALUES
(9, 12000.00, 1, 6),   -- Efectivo
(10, 5800.00, 2, 6),   -- Tarjeta débito
(11, 8500.00, 1, 7),   -- Efectivo
(12, 7250.00, 3, 7),   -- Tarjeta crédito
(13, 14200.00, 2, 8),  -- Tarjeta débito
(14, 6130.00, 1, 9),   -- Efectivo
(15, 7000.00, 4, 9),   -- Transferencia
(16, 15900.00, 1, 10), -- Efectivo
(17, 5000.00, 2, 10);  -- Tarjeta débito

GO
-- Agregar categorías faltantes si no existen
INSERT INTO categorias (nombre, descripcion) VALUES
('Fiambres', 'Productos cárnicos procesados y embutidos'),
('Lácteos', 'Productos derivados de la leche');
GO

-- Ahora agregar más productos en estas categorías
INSERT INTO productos (id_producto, nombre, descripcion, tipo_producto_id, marca_id, categoria_id, peso_kg, limite_stock_id) VALUES
(1001, 'Jamón Crudo Serrano', 'Curado tradicional 18 meses', 1, 1, 11, 2.2, 10),
(1002, 'Queso Roquefort', 'Queso azul importado', 2, 7, 12, 1.8, 8),
(1003, 'Salchichón Extra', 'Con pimienta negra', 1, 3, 11, 1.5, 9),
(1004, 'Mozzarella Premium', 'Para pizza artesanal', 2, 6, 12, 2.0, 7),
(1005, 'Panceta Ahumada', 'Proceso artesanal', 1, 2, 11, 3.0, 6),
(1006, 'Queso Cheddar', 'Madurado 8 meses', 2, 7, 12, 2.5, 5),
(1007, 'Chorizo Colorado', 'Especiado tradicional', 1, 4, 11, 0.8, 12),
(1008, 'Ricota Fresca', 'Elaboración diaria', 2, 8, 12, 1.0, 10),
(1009, 'Longaniza Casera', 'Receta familiar', 1, 12, 11, 1.2, 8),
(1010, 'Provolone Picante', 'Sabor intenso', 2, 7, 12, 1.7, 9);
GO

-- Agregar inventario para los nuevos productos
INSERT INTO inventarios (id_inventario, sucursal_id, producto_id, cantidad) VALUES
(8001, 1001, 1001, 150),
(8002, 1002, 1002, 200),
(8003, 1003, 1003, 180),
(8004, 1001, 1004, 220),
(8005, 1002, 1005, 160),
(8006, 1003, 1006, 190),
(8007, 1001, 1007, 250),
(8008, 1002, 1008, 180),
(8009, 1003, 1009, 170),
(8010, 1001, 1010, 200);
GO

-- Agregar más direcciones de entrega
INSERT INTO Direcciones_Entregas(direccion, referencia, cliente_id, zona_envio_id) VALUES 
('Calle Belgrano 1800', 'Local comercial esquina', 1, 3),
('Av. Rivadavia 2500', 'Frente al banco', 2, 4),
('San Martín 980', 'Edificio corporativo', 4, 1),
('Mitre 1560', 'Casa particular portón verde', 6, 2),
('9 de Julio 2200', 'Supermercado central', 8, 5),
('Sarmiento 1100', 'Oficina administrativa', 3, 3),
('Moreno 1700', 'Depósito trasero', 5, 4),
('Córdoba 800', 'Local gastronómico', 7, 1);
GO

-- Agregar pedidos en el segundo trimestre (abril-junio 2025)
INSERT INTO pedidos (id_pedido, empleado_armado_id, fecha, canal_compra_id, estado_id, direccion_entrega_id) VALUES
(16, 101, '2025-04-15', 1, 5, 16),
(17, 102, '2025-04-20', 2, 5, 17),
(18, 103, '2025-05-12', 1, 5, 18),
(19, 104, '2025-05-18', 3, 5, 19),
(20, 105, '2025-06-05', 1, 5, 20),
(21, 106, '2025-06-10', 2, 5, 21),
(22, 107, '2025-06-15', 1, 5, 22),
(23, 108, '2025-04-25', 3, 5, 23),
(24, 109, '2025-05-28', 1, 5, 16),
(25, 110, '2025-06-20', 2, 5, 17);

GO

-- Agregar detalles de pedidos con cantidades entre 5 y 50
-- Usando los nuevos productos y algunos existentes de las categorías correctas
INSERT INTO detalle_pedidos (id_det_pedido, producto_id, cantidad, prec_uni, pedido_id, peso_total_kg) VALUES
-- Pedido 16
(20, 1001, 15, 2500.00, 16, 33.0),  -- Jamón Crudo (Fiambres)
(21, 1002, 8, 1800.00, 16, 14.4),   -- Queso Roquefort (Lácteos)

-- Pedido 17  
(22, 1003, 25, 1200.00, 17, 37.5),  -- Salchichón (Fiambres)
(23, 1004, 12, 950.00, 17, 24.0),   -- Mozzarella (Lácteos)

-- Pedido 18
(24, 1005, 10, 1600.00, 18, 30.0),  -- Panceta (Fiambres)
(25, 1006, 18, 1100.00, 18, 45.0),  -- Cheddar (Lácteos)

-- Pedido 19
(26, 1007, 35, 800.00, 19, 28.0),   -- Chorizo (Fiambres)
(27, 1008, 22, 650.00, 19, 22.0),   -- Ricota (Lácteos)

-- Pedido 20
(28, 1009, 20, 950.00, 20, 24.0),   -- Longaniza (Fiambres)
(29, 1010, 14, 1300.00, 20, 23.8),  -- Provolone (Lácteos)

-- Pedido 21
(30, 1001, 12, 2500.00, 21, 26.4),  -- Jamón Crudo (Fiambres)
(31, 1002, 16, 1800.00, 21, 28.8),  -- Roquefort (Lácteos)

-- Pedido 22
(32, 1003, 30, 1200.00, 22, 45.0),  -- Salchichón (Fiambres)
(33, 423, 25, 750.00, 22, 30.0),    -- Queso Cremoso existente (reasignar a Lácteos)

-- Pedido 23
(34, 1005, 8, 1600.00, 23, 24.0),   -- Panceta (Fiambres)
(35, 1004, 28, 950.00, 23, 56.0),   -- Mozzarella (Lácteos)

-- Pedido 24
(36, 1007, 40, 800.00, 24, 32.0),   -- Chorizo (Fiambres)
(37, 1006, 11, 1100.00, 24, 27.5),  -- Cheddar (Lácteos)

-- Pedido 25
(38, 1009, 24, 950.00, 25, 28.8),   -- Longaniza (Fiambres)
(39, 1008, 33, 650.00, 25, 33.0);   -- Ricota (Lácteos)
GO

-- Actualizar algunos productos existentes para que tengan las categorías correctas
-- Cambiar productos existentes a categorías 'Fiambres' y 'Lácteos'
UPDATE productos SET categoria_id = 11 WHERE id_producto IN (879, 965, 876, 623, 133, 647, 843); -- Fiambres
GO

UPDATE productos SET categoria_id = 12 WHERE id_producto IN (880, 345, 456, 423, 765, 754, 234); -- Lácteos
GO

-- Agregar facturas para los nuevos pedidos
INSERT INTO facturas (id_factura, pedido_id, sucursal_id, empleado_factura_id, transporte_id, fecha, subtotal) VALUES
(11, 16, 1001, 101, 3001, '2025-04-15', 51900.00),
(12, 17, 1002, 102, 3002, '2025-04-20', 41400.00),
(13, 18, 1003, 103, 3003, '2025-05-12', 35800.00),
(14, 19, 1004, 104, 3004, '2025-05-18', 42300.00),
(15, 20, 1005, 105, 3005, '2025-06-05', 37200.00),
(16, 21, 1006, 106, 3006, '2025-06-10', 58800.00),
(17, 22, 1007, 107, 3007, '2025-06-15', 54750.00),
(18, 23, 1008, 108, 3008, '2025-04-25', 39400.00),
(19, 24, 1009, 109, 3009, '2025-05-28', 43100.00),
(20, 25, 1010, 110, 3001, '2025-06-20', 43250.00);

GO

-- Agregar detalles de facturas correspondientes
INSERT INTO detalles_facturas (id_det_fact, factura_id, producto_id, cantidad, prec_uni, peso_total_kg) VALUES
-- Factura 11
(20, 11, 1001, 15, 2500.00, 33.0),
(21, 11, 1002, 8, 1800.00, 14.4);

GO

-- Factura 12
INSERT INTO detalles_facturas (id_det_fact, factura_id, producto_id, cantidad, prec_uni, peso_total_kg) VALUES
(22, 12, 1003, 25, 1200.00, 37.5),
(23, 12, 1004, 12, 950.00, 24.0);

GO

-- Factura 13
INSERT INTO detalles_facturas (id_det_fact, factura_id, producto_id, cantidad, prec_uni, peso_total_kg) VALUES
(24, 13, 1005, 10, 1600.00, 30.0),
(25, 13, 1006, 18, 1100.00, 45.0);

GO

-- Factura 14
INSERT INTO detalles_facturas (id_det_fact, factura_id, producto_id, cantidad, prec_uni, peso_total_kg) VALUES
(26, 14, 1007, 35, 800.00, 28.0),
(27, 14, 1008, 22, 650.00, 22.0);

GO

-- Factura 15
INSERT INTO detalles_facturas (id_det_fact, factura_id, producto_id, cantidad, prec_uni, peso_total_kg) VALUES
(28, 15, 1009, 20, 950.00, 24.0),
(29, 15, 1010, 14, 1300.00, 23.8);

GO

-- Factura 16
INSERT INTO detalles_facturas (id_det_fact, factura_id, producto_id, cantidad, prec_uni, peso_total_kg) VALUES
(30, 16, 1001, 12, 2500.00, 26.4),
(31, 16, 1002, 16, 1800.00, 28.8);

GO

-- Factura 17
INSERT INTO detalles_facturas (id_det_fact, factura_id, producto_id, cantidad, prec_uni, peso_total_kg) VALUES
(32, 17, 1003, 30, 1200.00, 45.0),
(33, 17, 423, 25, 750.00, 30.0);

GO

-- Factura 18
INSERT INTO detalles_facturas (id_det_fact, factura_id, producto_id, cantidad, prec_uni, peso_total_kg) VALUES
(34, 18, 1005, 8, 1600.00, 24.0),
(35, 18, 1004, 28, 950.00, 56.0);

GO

-- Factura 19
INSERT INTO detalles_facturas (id_det_fact, factura_id, producto_id, cantidad, prec_uni, peso_total_kg) VALUES
(36, 19, 1007, 40, 800.00, 32.0),
(37, 19, 1006, 11, 1100.00, 27.5);

GO

-- Factura 20
INSERT INTO detalles_facturas (id_det_fact, factura_id, producto_id, cantidad, prec_uni, peso_total_kg) VALUES
(38, 20, 1009, 24, 950.00, 28.8),
(39, 20, 1008, 33, 650.00, 33.0);

GO

-- Agregar medios de pago para las nuevas facturas
INSERT INTO facturas_medios_pago (id_factura_medio_pago, monto, medio_pago_id, factura_id) VALUES
(18, 51900.00, 1, 11),  -- Efectivo
(19, 41400.00, 2, 12),  -- Tarjeta débito
(20, 35800.00, 1, 13),  -- Efectivo
(21, 42300.00, 4, 14),  -- Transferencia
(22, 37200.00, 1, 15),  -- Efectivo
(23, 58800.00, 2, 16),  -- Tarjeta débito
(24, 54750.00, 1, 17),  -- Efectivo
(25, 39400.00, 3, 18),  -- Tarjeta crédito
(26, 43100.00, 1, 19),  -- Efectivo
(27, 43250.00, 2, 20);  -- Tarjeta débito

GO

-- Inventario asociado con stock entre 100 y 300
INSERT INTO inventarios (id_inventario, sucursal_id, producto_id, cantidad) VALUES
(9001, 1001, 1001, 150),
(9002, 1002, 1002, 180),
(9003, 1003, 1003, 200),
(9004, 1004, 1004, 120),
(9005, 1005, 1005, 250);

GO

---Consultas

--Nicolás Guzmán
--1) TRANSPORTISTAS QUE HICIERON ENTREGAS EN TIEMPO Y FORMA
SELECT 
nombre_transportista AS 'TRANSPORTISTA',
tv.tipo AS 'VEHICULO',
distancia_km AS 'DISTANCIA',
FORMAT(CONVERT(DATE, fecha_salida), 'dd/MM/yyyy') AS 'FECHA',
DATEPART(hour, fecha_salida) AS 'HORA SALIDA',
DATEPART(hour, hora_estimada_entrega) AS 'HORA ESTIMADA DE ENTREGA',
DATEPART(hour, fecha_regreso) AS 'HORA DE REGRESO',
es.estado AS 'ESTADO DEL PEDIDO',
p.nombre AS 'PRODUCTO',
df.cantidad AS 'CANTIDAD'
FROM productos p
JOIN detalles_facturas df ON p.id_producto = df.producto_id
JOIN Facturas f ON f.id_factura = df.factura_id
JOIN pedidos ped ON ped.id_pedido = f.pedido_id
JOIN detalles_hoja_ruta dhr ON dhr.pedido_id = ped.id_pedido
JOIN hojas_rutas hr ON hr.id_hoja_ruta = dhr.hoja_ruta_id
JOIN transportes t ON t.id_transporte = hr.transporte_id
JOIN vehiculos v ON v.transporte_id = t.id_transporte
JOIN tipos_vehiculos tv ON tv.id_tipo_vehiculo = v.tipo_vehiculo_id
JOIN estados_pedido es ON es.id_estado_pedido = ped.estado_id
WHERE distancia_km > 100 AND YEAR(fecha_salida) BETWEEN 2023 AND 2024

--Nicolás Guzmán
---2)
SELECT
cl.nombre_completo AS 'CLIENTE',
COUNT( dep.cliente_id) AS 'CANTIDAD DE DEPÓSITOS',
COUNT(ped.id_pedido) AS 'VECES QUE COMPRÓ',
c.nombre AS 'CATEGORÍA',
cc.descripcion AS 'FORMA DE COMPRA', 
co.contacto AS 'CONTACTO',
SUM(cantidad*prec_uni) AS 'SUBTOTAL DEL PEDIDO'
FROM categorias c
JOIN productos p ON p.categoria_id = c.id_categoria
JOIN detalle_pedidos dp ON dp.producto_id = p.id_producto
JOIN pedidos ped ON ped.id_pedido = dp.pedido_id
JOIN canales_compras cc ON cc.id_canal_compra = ped.canal_compra_id
JOIN Direcciones_Entregas de ON de.id_dir_entrega = ped.direccion_entrega_id
JOIN Clientes cl ON cl.id_cliente = de.cliente_id
JOIN depositos dep ON dep.cliente_id = cl.id_cliente
JOIN Contactos co ON co.cliente_id = cl.id_cliente
WHERE co.contacto IS NOT NULL AND (cl.nombre_completo LIKE '%S.A.' OR cl.nombre_completo LIKE '%Ltda.')

GROUP BY cl.nombre_completo, c.nombre,co.contacto, cc.descripcion
ORDER BY [SUBTOTAL DEL PEDIDO] DESC

------augusto
--3)
SELECT e.id_empleado AS 'ID', CONCAT(UPPER(e.nombre_completo), ' - ', c.cargo) AS 'Nombre completo y Cargo', ce.contacto AS 'Contacto Telegram', s.nombre AS 'Sucursal' FROM empleados e JOIN cargos c ON e.cargo_id = c.id_cargo JOIN sucursales s ON e.sucursal_id = s.id_sucursal JOIN contactos_empleados ce ON ce.empleado_id = e.id_empleado JOIN tipos_contactos tc ON ce.tipo_contacto_id = tc.id_tipo_contacto WHERE tc.tipo = 'Telegram'
AND s.nombre LIKE '%Zona%'
AND e.supervisor_id IS NOT NULL

------augusto
---4)
SELECT pr.nombre AS Producto, m.nombre AS Marca, df.prec_uni AS 'Precio Unitario',
SUM(df.cantidad) AS 'Cantidad Total vendida',
SUM(df.prec_uni * df.cantidad) AS 'Total Facturado',
YEAR(f.fecha) AS 'Año Facturación' 
FROM detalles_facturas df
JOIN productos pr ON df.producto_id = pr.id_producto
JOIN marcas m ON pr.marca_id = m.id_marca
JOIN facturas f ON df.factura_id = f.id_factura
WHERE df.prec_uni > 800
AND pr.marca_id IN (1, 2, 4)
AND f.fecha BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY pr.nombre, m.nombre, df.prec_uni, YEAR(f.fecha)

---bautista
--5)
SELECT 
    pr.nombre AS producto,
    pr.peso_kg,
    c.nombre AS categoria,
    mp.nombre AS medio_pago,
    mp.recargo
FROM detalle_pedidos dp
JOIN productos pr ON dp.producto_id = pr.id_producto
JOIN categorias c ON pr.categoria_id = c.id_categoria
JOIN pedidos p ON dp.pedido_id = p.id_pedido
JOIN facturas f ON f.pedido_id = p.id_pedido
JOIN Facturas_medios_pago fmp ON fmp.factura_id = f.id_factura
JOIN medios_pagos mp ON mp.id_medio_pago = fmp.medio_pago_id
WHERE
	UPPER(mp.nombre) LIKE '%TARJETA%'
    AND pr.peso_kg BETWEEN 1 AND 5              
    AND c.nombre != ('Congelados')
	OR mp.recargo > 0


---bautista
----6)

SELECT 
    p.id_producto,
    p.descripcion,
    dp.prec_uni,
    FORMAT(CONVERT(DATE, ped.fecha), 'dd/MM/yyyy') AS 'fecha',
    ze.descripcion
FROM Productos p
JOIN detalle_pedidos dp ON dp.producto_id = p.id_producto
JOIN pedidos ped ON ped.id_pedido = dp.pedido_id
JOIN Direcciones_Entregas dire ON dire.id_dir_entrega = ped.direccion_entrega_id
JOIN zonas_envio ze ON ze.id_zona_envio = dire.zona_envio_id
WHERE 
    ped.fecha >= DATEADD(YEAR, -5, GETDATE())
    AND ze.id_zona_envio IS NOT NULL
    AND dp.prec_uni IN (500, 900, 1200)
	ORDER BY ped.fecha DESC


-----martin
---7)

SELECT 
    f.id_factura,
    FORMAT(f.fecha, 'dd-MM-yyyy') AS Fecha_Factura,
    mp.nombre AS Medio_Pago,
    fmp.monto AS Monto_Pago,
    z.descripcion AS Zona_Entrega,
    pr.nombre AS Producto,
    df.cantidad AS Cantidad,
    df.prec_uni AS Precio_Unitario,
    (df.cantidad * df.prec_uni) AS Total_Producto
FROM facturas f
JOIN facturas_medios_pago fmp ON f.id_factura = fmp.factura_id
JOIN medios_pagos mp ON fmp.medio_pago_id = mp.id_medio_pago
JOIN pedidos p ON f.pedido_id = p.id_pedido
JOIN direcciones_entregas d ON p.direccion_entrega_id = d.id_dir_entrega
JOIN zonas_envio z ON d.zona_envio_id = z.id_zona_envio
JOIN detalles_facturas df ON f.id_factura = df.factura_id
JOIN productos pr ON df.producto_id = pr.id_producto
WHERE 
    fmp.monto > 1000
    AND z.descripcion LIKE '%Centro%'
    AND YEAR(f.fecha) = 2025
ORDER BY fmp.monto DESC;


-----martin
----8)
SELECT 
    p.id_pedido,
    cc.descripcion AS Canal_Compra,
    cat.nombre AS Categoria,
    pr.nombre AS Producto,
    dp.cantidad,
    dp.prec_uni,
    (dp.cantidad * dp.prec_uni) AS Total_Venta,
    FORMAT(p.fecha, 'MMMM yyyy', 'es-ES') AS Mes_Año
FROM pedidos p
JOIN detalle_pedidos dp ON p.id_pedido = dp.pedido_id
JOIN productos pr ON dp.producto_id = pr.id_producto
JOIN categorias cat ON pr.categoria_id = cat.id_categoria
JOIN canales_compras cc ON p.canal_compra_id = cc.id_canal_compra
WHERE 
    dp.cantidad BETWEEN 5 AND 50                         -- rango de cantidad
    AND cat.nombre IN ('Lácteos', 'Fiambres')            -- conjunto
    AND pr.peso_kg IS NOT NULL                           -- valor no nulo
    AND MONTH(p.fecha) BETWEEN 4 AND 6                   -- segundo trimestre
ORDER BY Total_Venta DESC;

--Franco 
--9) 
SELECT 
    p.id_pedido, pr.nombre AS Producto, dp.prec_uni AS Precio, z.descripcion AS Zona_Envio, pr.peso_kg AS Peso_Producto, YEAR(p.fecha) AS Año
FROM pedidos p
JOIN detalle_pedidos dp ON p.id_pedido = dp.pedido_id
JOIN productos pr ON dp.producto_id = pr.id_producto
JOIN direcciones_entregas d ON p.direccion_entrega_id = d.id_dir_entrega
JOIN zonas_envio z ON d.zona_envio_id = z.id_zona_envio
WHERE 
    pr.nombre NOT LIKE '%Light%'                                        --  patrón
    AND pr.nombre NOT LIKE '%Granel%'                                    --  patrón
    AND z.descripcion IN ('Zona Norte', 'Zona Centro', 'Zona Sur')       -- conjunto
    AND pr.peso_kg > 1.5                                                -- Comparación
    AND YEAR(p.fecha) = 2025
ORDER BY dp.prec_uni DESC;


--Franco 
----10)
SELECT 
    pr.nombre AS Producto,i.cantidad AS Stock, cat.nombre AS Categoria, pr.peso_kg AS Peso, s.nombre AS Sucursal, tp.nombre AS Tipo_Producto
FROM inventarios i
JOIN productos pr ON i.producto_id = pr.id_producto
JOIN categorias cat ON pr.categoria_id = cat.id_categoria
JOIN tipos_productos tp ON pr.tipo_producto_id = tp.id_tipo_producto
JOIN sucursales s ON i.sucursal_id = s.id_sucursal
WHERE 
    i.cantidad BETWEEN 100 AND 300                              -- Rango
    AND cat.nombre IN ('Gourmet', 'Granel', 'Importados')       -- Conjunto
    AND pr.peso_kg IS NOT NULL                                  -- Valor no nulo
ORDER BY i.cantidad DESC;

--Nahir
--11)
SELECT 
    e.id_empleado AS ID_Empleado,
    e.nombre_completo AS Nombre_Empleado,
    c.cargo AS Cargo,
    tc.tipo AS Tipo_Contacto,
    ce.contacto AS Detalle_Contacto
FROM empleados e
JOIN cargos c ON e.cargo_id = c.id_cargo
JOIN contactos_empleados ce ON ce.empleado_id = e.id_empleado
JOIN tipos_contactos tc ON ce.tipo_contacto_id = tc.id_tipo_contacto
WHERE 
    e.cargo_id >= 2
    AND e.nombre_completo LIKE '%A%'
    AND ce.tipo_contacto_id IS NOT NULL;

--Nahir
--12)
SELECT 
    p.id_producto AS ID_Producto,
    p.nombre AS Nombre_Producto,
    ls.id_limite_stock AS ID_Limite_Stock,
    ls.limite AS Descripcion_Limite,
    f.fecha AS Fecha_Factura
FROM Productos p
JOIN Limites_stock ls ON p.limite_stock_id = ls.id_limite_stock
JOIN detalles_facturas df ON p.id_producto = df.producto_id
JOIN facturas f ON df.factura_id = f.id_factura
WHERE 
    p.id_producto BETWEEN 100 AND 800
    AND ls.id_limite_stock IN (2, 3, 5, 7, 8, 9)
    AND YEAR(f.fecha) IN (2024, 2025)
ORDER BY f.fecha DESC;