CREATE DATABASE mayorista_fiambre_lacteo_DB
GO
USE mayorista_fiambre_lacteo_DB
GO
 CREATE TABLE marcas (
 id_marca int identity (1,1),
 nombre varchar (50) NOT NULL,
 descripcion varchar (100),
 CONSTRAINT PK_marca PRIMARY KEY (id_marca)
)

GO
create table medios_pagos (
id_medio_pago int,
nombre varchar (50) NOT NULL,
recargo decimal (10, 2),
constraint pk_medio_pago_id primary key (id_medio_pago)
);

 GO
 CREATE TABLE Direcciones_Entregas
(
	id_dir_entrega INT IDENTITY (1,1) NOT NULL,
	direccion varchar (50) NOT NULL,
	referencia varchar (50),
	CONSTRAINT pk_dir_entrega PRIMARY KEY (id_dir_entrega)
)
GO
create table provincias(
id_provincia int identity (1,1),
provincia varchar (100) NOT NULL,
constraint fk_id_provincia primary key (id_provincia)
)

GO
 CREATE TABLE tipos_productos (
 id_tipo_producto int identity (1,1),
  nombre varchar (50) NOT NULL,
  descripcion varchar (100)
 CONSTRAINT PK_tipo_producto PRIMARY KEY (id_tipo_producto)
)
GO

 CREATE TABLE categorias (
 id_categoria int identity (1,1),
 nombre varchar (50) NOT NULL,
 descripcion varchar (100),
 CONSTRAINT PK_categoria PRIMARY KEY (id_categoria)
 )
 GO
 CREATE TABLE Tipos_Contactos
(
	id_tipo_contacto INT IDENTITY (1,1) NOT NULL,
	tipo varchar(50) NOT NULL,
	CONSTRAINT pk_tipo_cont PRIMARY KEY (id_tipo_contacto)
)
GO

CREATE TABLE cargos (
id_cargo INT IDENTITY(1,1),
cargo VARCHAR(50) NOT NULL

CONSTRAINT pk_cargo PRIMARY KEY (id_cargo)
)
GO
CREATE TABLE canales_compras (
id_canal_compra INT,
descripcion VARCHAR(50) NOT NULL

CONSTRAINT pk_canal_compra PRIMARY KEY (id_canal_compra)
)
GO
CREATE TABLE Clientes 
(
	id_cliente INT IDENTITY (1,1 ) NOT NULL,
	nombre_completo varchar (50) NOT NULL,
	CONSTRAINT pk_cliente PRIMARY KEY (id_cliente)
)
GO
CREATE TABLE Contactos
(
	id_contacto INT IDENTITY (1,1) NOT NULL,
	contacto varchar(100) NOT NULL,
	tipo_contacto_id int NOT NULL,
	cliente_id int,
	CONSTRAINT pk_contacto PRIMARY KEY (id_contacto),
	CONSTRAINT fk_tipo_cont FOREIGN KEY (tipo_contacto_id) REFERENCES Tipos_contactos (id_tipo_contacto),
	CONSTRAINT fk_cliente_contacto FOREIGN KEY (cliente_id) REFERENCES Clientes (id_cliente)
)
GO

create table ciudades(
id_ciudad int identity (1,1),
ciudad varchar(100) NOT NULL,
provincia_id int NOT NULL,
constraint pk_id_ciudad primary key (id_ciudad),
constraint fk_provincia_ciudad foreign key (provincia_id)
    references provincias (id_provincia)
)
GO
create table barrios(
id_barrio int identity (1,1),
barrio varchar (150) NOT NULL,
ciudad_id int NOT NULL,
constraint pk_id_barrio primary key (id_barrio),
constraint fk_id_ciudad_barrio foreign key (ciudad_id)
    references ciudades (id_ciudad)
)
GO
create table sucursales(
id_sucursal int,
nombre varchar (50) NOT NULL,
direccion varchar (50) NOT NULL,
telefono int NOT NULL,
barrio_id int NOT NULL,
constraint pk_sucursal primary key (id_sucursal),
constraint fk_barrio_sucursal foreign key (barrio_id)
    references barrios (id_barrio)
)
GO
create table tipos_movimientos(
id_mov_tipo int identity(1,1),
tipo_mov varchar(50) NOT NULL,
constraint pk_tipo_mov primary key(id_mov_tipo)
)
GO
CREATE TABLE productos(
	id_producto int identity (1,1),
	nombre varchar (50) NOT NULL,
	descripcion varchar(100),
	limite_minimo int NOT NULL,
	tipo_producto_id int NOT NULL,
	marca_id int NOT NULL,
	categoria_id int NOT NULL,
	peso_kg decimal (18,2)
 CONSTRAINT PK_producto PRIMARY KEY  (id_producto),
 CONSTRAINT FK_marca_producto FOREIGN KEY (marca_id) 
	REFERENCES marcas (id_marca),
CONSTRAINT FK_tipo_producto FOREIGN KEY (tipo_producto_id)
	REFERENCES tipos_productos (id_tipo_producto), 
CONSTRAINT FK_categoria_producto FOREIGN KEY (categoria_id)
	REFERENCES categorias (id_categoria)
 )
 GO
 create table inventarios(
id_inventario int,
sucursal_id int NOT NULL,
producto_id int NOT NULL,
cantidad int NOT NULL,
tipo_movimiento_id int NOT NULL,
motivo varchar(70),
fecha datetime NOT NULL,
sucursal_destino_id int
constraint pk_inventario primary key (id_inventario),
constraint fk_sucursal_inventario foreign key(sucursal_id) references sucursales (id_sucursal),
CONSTRAINT FK_producto_inventario FOREIGN KEY (producto_id) REFERENCES productos (id_producto),
constraint fk_movimiento_inventario foreign key (tipo_movimiento_id) references tipos_movimientos(id_mov_tipo),
)
GO
create table tipos_vehiculos (
id_tipo_vehiculo int ,
vehiculo varchar(50) NOT NULL
--camiones, furgonetas, furgones
constraint pk_vehiculo primary key (id_tipo_vehiculo)
)
GO

create table caract_transportes(
id_carac_trans int,
capacidad_carga decimal(10,2) NOT NULL,
refrigeracion bit NOT NULL,
tipo_vehiculo_id int NOT NULL

constraint pk_carac_trans primary key (id_carac_trans),
constraint fk_tipo_vehiculo foreign key (tipo_vehiculo_id) references tipos_vehiculos (id_tipo_vehiculo)
)
GO
create table transportes_terceros(
id_transporte_tercero int,
empresa varchar(50) NOT NULL,
contacto varchar(50) NOT NULL,
carac_trans_id int NOT NULL
constraint pk_transporte_terceros primary key (id_transporte_tercero),
constraint fk_carac_trans_terceros foreign key (carac_trans_id) references caract_transportes (id_carac_trans)
)
GO
create table transportes(
id_transportes int,
disponibilidad varchar(2) NOT NULL,
carac_trans_id int NOT NULL
constraint pk_transportes primary key(id_transportes),
constraint fk_carac_trans_transporte foreign key (carac_trans_id) references caract_transportes (id_carac_trans)
)
GO

CREATE TABLE empleados (
id_empleado INT,
sucursal_id INT NOT NULL,
cargo_id INT NOT NULL,
nombre_completo VARCHAR(90) NOT NULL,
direccion VARCHAR(50) NOT NULL,
mail VARCHAR(50) NOT NULL,
num_tel VARCHAR(50) NOT NULL,
supervisor_id INT

CONSTRAINT pk_id_empleado PRIMARY KEY (id_empleado),
CONSTRAINT FK_empleados_supervisor FOREIGN KEY (supervisor_id) 
    REFERENCES empleados (id_empleado),
CONSTRAINT fk_sucursal_empleados FOREIGN KEY (sucursal_id)
	REFERENCES sucursales (id_sucursal),
CONSTRAINT fk_cargo_empleados FOREIGN KEY (cargo_id)
	REFERENCES cargos (id_cargo)
)
GO
CREATE TABLE pedidos(
id_pedido INT,
cliente_id INT NOT NULL,
direccion_entrega_id INT NOT NULL,
empleado_armado_id INT NOT NULL,
fecha DATE NOT NULL,
estado CHAR(1) NOT NULL,
canal_compra_id INT NOT NULL,

CONSTRAINT pk_pedido PRIMARY KEY (id_pedido),
CONSTRAINT fk_cliente_pedidos FOREIGN KEY (cliente_id)
	REFERENCES clientes (id_cliente),
CONSTRAINT fk_empleado_armado_pedidos FOREIGN KEY (empleado_armado_id)
	REFERENCES empleados (id_empleado),
CONSTRAINT fk_canal_compra_pedidos FOREIGN KEY (canal_compra_id)
	REFERENCES canales_compras (id_canal_compra),
CONSTRAINT fk_direccion_entrega_pedido FOREIGN KEY (direccion_entrega_id)	
	REFERENCES Direcciones_Entregas (id_dir_entrega)
)
GO
CREATE TABLE depositos (
id_deposito INT,
cliente_id INT NOT NULL,
direccion VARCHAR(50) NOT NULL,
capacidad DECIMAL(8,2) NOT NULL

CONSTRAINT pk_deposito PRIMARY KEY (id_deposito),
CONSTRAINT fk_cliente_deposito FOREIGN KEY (cliente_id)
	REFERENCES clientes (id_cliente)
)
GO
create table Facturas (
id_factura int not null,
pedido_id int not null,
sucursal_id int NOT NULL,
empleado_factura_id int NOT NULL,
transporte_id int,
transporte_terceros_id int,
fecha date NOT NULL,
total decimal (10, 2) NOT NULL,
constraint pk_id_factura primary key (id_factura),--PK facturas
constraint fk_pedido_id foreign key (pedido_id) --FK Pedido
	references pedidos (id_pedido), --referencia a tabla pedido
constraint fk_sucursal_id foreign key (sucursal_id) --FK sucursal
	references sucursales (id_sucursal), --referencia tabla sucursales
constraint fk_empleado_factura_id foreign key (empleado_factura_id)--FK empleado factura
	references empleados (id_empleado), --referenc9ia tabla empleados
constraint fk_transporte_id foreign key (transporte_id)--FK transporte
	references transportes (id_transportes), --referencia a tabla transportes
constraint fk_trans_terc foreign key (transporte_terceros_id) --FK transportes terceros
	references transportes_terceros (id_transporte_tercero)
);

create table Facturas_medios_pago (
id_factura_medio_pago int,
monto decimal (10, 2) NOT NULL,
medio_pago_id int NOT NULL,
factura_id int
constraint pk_factura_medio_pago primary key (id_factura_medio_pago),
constraint fk_factura_id foreign key (factura_id) 
	references facturas (id_factura),
constraint fk_medio_pago_id foreign key (medio_pago_id)
	references medios_pagos (id_medio_pago)
);

GO
create table detalles_facturas (
id_det_fact int,
factura_id int NOT NULL,
producto_id int NOT NULL,
cantidad int NOT NULL,
prec_uni decimal (10, 2) NOT NULL,
peso_total_kg decimal(15, 2)
constraint pk_det_factura primary key (id_det_fact),
constraint fk_factura_det_fac foreign key (factura_id) 
	references facturas (id_factura),
constraint fk_producto_det_fac foreign key (producto_id) 
	references productos (id_producto)
	)
GO
create table detalle_pedidos(
id_det_pedido int,
producto_id int NOT NULL,
cantidad int NOT NULL,
prec_uni decimal (10, 2) NOT NULL,
pedido_id int NOT NULL,
peso_total_kg decimal(15, 2)
constraint pk_det_pedido primary key (id_det_pedido),
constraint fk_prod_det_ped foreign key (producto_id)
	references productos (id_producto),
constraint fk_pedido_det_ped foreign key (pedido_id)
	references pedidos (id_pedido)
)


 


