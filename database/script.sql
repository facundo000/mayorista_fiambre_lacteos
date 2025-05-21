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


-- Tabla estados_pedido
CREATE TABLE estados_pedido (
    id_estado_perdido int NOT NULL,
    estado varchar(50) NULL,
    CONSTRAINT PK_estados_pedido PRIMARY KEY (id_estado_perdido)
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
    referencia varchar(50),
    cliente_id INT NULL,
	zona_envio_id INT 

    CONSTRAINT pk_dir_entrega PRIMARY KEY (id_dir_entrega)
	CONSTRAINT fk_zona_envio_dir_entr FOREIGN KEY (zona_envio_id) REFERENCES zonas_envio (id_zona_envio)
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

-- Tabla hojas_rutas
CREATE TABLE hojas_rutas (
    id_hoja_ruta INT IDENTITY(1,1),
    fecha DATE NOT NULL,
    transporte_id INT NOT NULL,
    observaciones VARCHAR(255) NULL,
    fecha_salida DATETIME NULL,
    fecha_regreso DATETIME NULL,
    
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
    id_producto int IDENTITY(1,1),
    nombre varchar(50) NOT NULL,
    descripcion varchar(100),
    tipo_producto_id int NOT NULL,
    marca_id int NOT NULL,
    categoria_id int NOT NULL,
    peso_kg decimal(18,2),
	estado_id int NOT NULL
    CONSTRAINT PK_producto PRIMARY KEY (id_producto),
    CONSTRAINT FK_marca_producto FOREIGN KEY (marca_id) REFERENCES marcas (id_marca),
    CONSTRAINT FK_tipo_producto FOREIGN KEY (tipo_producto_id) REFERENCES tipos_productos (id_tipo_producto),
    CONSTRAINT FK_categoria_producto FOREIGN KEY (categoria_id) REFERENCES categorias (id_categoria),
	CONSTRAINT FK_productos_estados_pedido FOREIGN KEY (estado_id) REFERENCES estados_pedido (id_estado_perdido)
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
	CONSTRAINT fk_estado_pedido FOREIGN KEY (estado_id) REFERENCES estados_pedido (id_estado_perdido)
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
    subtotal decimal(10,2) NOT NULL,
	distancia_km DECIMAL(10,2)


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

-- Tabla detalles_hoja_ruta
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


