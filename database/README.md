# Base de Datos: Mayorista de Fiambres y Lácteos

Este proyecto implementa una base de datos para gestionar las operaciones de un mayorista de fiambres y lácteos. La base de datos está diseñada para manejar información sobre productos, clientes, empleados, sucursales, transportes, pedidos, facturas y más. A continuación, se describen los principales componentes y su propósito.

## Tecnología Utilizada
- SQL Server

## Estructura de la Base de Datos

![Diagrama de la Base de Datos](/database/Diagrama_mayorista_fiambre.png)

### Tablas Principales

1. **Productos y Categorías**
   - **`productos`**: Almacena información sobre los productos, como nombre, descripción, peso, límite mínimo de stock, tipo, marca y categoría.
   - **`categorias`**: Define las categorías de los productos.
   - **`tipos_productos`**: Clasifica los productos en diferentes tipos.
   - **`marcas`**: Contiene las marcas de los productos.

2. **Clientes y Contactos**
   - **`clientes`**: Registra los datos de los clientes.
   - **`contactos`**: Almacena los contactos asociados a los clientes.
   - **`tipos_contactos`**: Define los tipos de contacto (por ejemplo, teléfono, email).

3. **Sucursales y Ubicaciones**
   - **`sucursales`**: Contiene información sobre las sucursales, como dirección, teléfono y barrio.
   - **`barrios`**, **`ciudades`**, **`provincias`**: Estructuran la ubicación geográfica de las sucursales y direcciones de entrega.

4. **Pedidos y Facturación**
   - **`pedidos`**: Registra los pedidos realizados por los clientes, incluyendo el estado, fecha y empleado encargado.
   - **`detalle_pedidos`**: Detalla los productos incluidos en cada pedido.
   - **`facturas`**: Almacena las facturas generadas a partir de los pedidos.
   - **`detalles_facturas`**: Detalla los productos incluidos en cada factura.
   - **`facturas_medios_pago`**: Relaciona las facturas con los medios de pago utilizados.

5. **Inventarios**
   - **`inventarios`**: Gestiona el stock de productos en las sucursales, incluyendo movimientos de inventario.

6. **Transportes**
   - **`transportes`**: Registra los transportes propios disponibles.
   - **`transportes_terceros`**: Almacena información sobre transportes de terceros.
   - **`caract_transportes`**: Define las características de los transportes, como capacidad de carga y refrigeración.
   - **`tipos_vehiculos`**: Clasifica los vehículos en diferentes tipos.

7. **Empleados**
   - **`empleados`**: Contiene información sobre los empleados, como nombre, dirección, cargo y sucursal asignada.
   - **`cargos`**: Define los diferentes cargos que pueden ocupar los empleados.

8. **Medios de Pago**
   - **`medios_pagos`**: Registra los medios de pago aceptados, como tarjetas de crédito o efectivo.

### Relaciones Clave
- Las tablas están relacionadas mediante claves primarias y foráneas para garantizar la integridad referencial.
- Ejemplo: La tabla `productos` está relacionada con `categorias`, `marcas` y `tipos_productos` para clasificar los productos.

## Uso de la Base de Datos
1. **Creación de la Base de Datos**: El script SQL crea la base de datos `mayorista_fiambre_lacteo_DB` y todas las tablas necesarias.
2. **Gestión de Datos**: Permite registrar y consultar información sobre productos, clientes, pedidos, inventarios, transportes y más.
3. **Consultas y Reportes**: Facilita la generación de reportes sobre ventas, inventarios, facturación y logística.
