--USE [GD2C2022]
--GO
--create schema gd_esquema

CREATE TABLE [gd_esquema].[BI_DIM_TIEMPO](
    [ID_FECHA] decimal(19,0) IDENTITY(1,1),
    [MES] decimal(2,0),
    [ANIO] decimal(4,0),
    PRIMARY KEY  ([ID_FECHA])
);

GO

CREATE TABLE [gd_esquema].[BI_DIM_PROVINCIA](
    [CODIGO_PROVINCIA] decimal(19,0) IDENTITY(1,1),
    [NOMBRE_PROV] nvarchar(255),
    PRIMARY KEY ([CODIGO_PROVINCIA])
);

GO

CREATE TABLE [gd_esquema].[BI_DIM_RANGO_ETARIO](
  [ID_CLIENTE] decimal(19,0) IDENTITY (1,1),
  [RANGO_ETARIO] nvarchar(255),
  PRIMARY KEY ([ID_CLIENTE]) 
);

GO

CREATE TABLE [gd_esquema].[BI_DIM_CANAL_VENTA](
  [ID_CANAL_VENTA] decimal(19,0),
  [CANAL_VENTA] nvarchar(255),
  PRIMARY KEY ([ID_CANAL_VENTA])
);

GO

CREATE TABLE [gd_esquema].[BI_DIM_MEDIO_PAGO](
  [ID_MEDIO_PAGO] decimal(19,0) IDENTITY(1,1),
  [MEDIO_PAGO] nvarchar(255),
  PRIMARY KEY ([ID_MEDIO_PAGO])  
);

GO

CREATE TABLE [gd_esquema].[BI_DIM_CATEGORIA_PRODUCTO](
  [ID_CATEGORIA] decimal(19,0) IDENTITY (1,1),
  [CATEGORIA] nvarchar(255),
  PRIMARY KEY ([ID_CATEGORIA])
);

GO

CREATE TABLE [gd_esquema].[BI_DIM_PRODUCTO](
  [COD_PROD] nvarchar(50),
  [NOMBRE_PROD] nvarchar(50),
  [DESCRIPCION_PROD] nvarchar(50),
  PRIMARY KEY ([COD_PROD])
);

GO

CREATE TABLE [gd_esquema].[BI_DIM_TIPO_DESCUENTO](
  [ID_DESC] decimal(19,0) IDENTITY(1,1), --averiguar tema id
  [TIPO_DESCUENTO] char(10), --COMPRA, VENTA, MEDIO_PAGO, etc
  --[VALOR_DESCUENTO] decimal(18,2), --ver donde va el valor ya que una venta/compra tiene varios descuentos
  PRIMARY KEY ([ID_DESC])
);

GO

CREATE TABLE [gd_esquema].[BI_DIM_TIPO_ENVIO](
  [ID_MEDIO_ENVIO] decimal(19,0) IDENTITY(1,1),
  [MEDIO] nvarchar(255),
  PRIMARY KEY ([ID_MEDIO_ENVIO])
);

CREATE TABLE [gd_esquema].[BI_HECHOS_COMPRAVENTA](
    [ID_FECHA] decimal(19,0), --fk
    [CODIGO_PROVINCIA] decimal(19,0), --fk
    [ID_CLIENTE] decimal(19,0), --fk nullable
    [ID_CANAL_VENTA] decimal(19,0), --fk
    [ID_MEDIO_PAGO] decimal(19,0), --fk
    [ID_CATEGORIA] decimal(19,0), --fk
    [COD_PROD] nvarchar(50), --fk
    --proveedor?
    [ID_DESC] decimal(19,0), --fk
    [ID_MEDIO_ENVIO] decimal(19,0), --fk
    [SUBTOTAL_COMPRAVENTA] decimal(18,2),
    [TOTAL_DESCUENTOS] decimal(18,2),
    [MEDIO_ENVIO_COSTO] decimal(18,2),
    [CANAL_VENTA_COSTO] decimal(18,2)
);

GO