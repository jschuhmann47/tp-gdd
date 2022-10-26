CREATE TABLE [CANAL_VENTA] (
  [ID_CANAL_VENTA] decimal(19,0),
  [CANAL_VENTA] nvarchar(255),
  PRIMARY KEY ([ID_CANAL_VENTA])
);

CREATE TABLE [COMPRA] (
  [COD_COMPRA] decimal(19,0),
  [FECHA_COMPRA] date,
  [MEDIO_PAGO_COMPRA] decimal(19,0),
  [TOTAL_COMPRA] decimal(18,2),
  [CUIT_PROV] nvarchar(50),
  [CODIGO_DESC_COMPRA] decimal(19,0),
  PRIMARY KEY ([COD_COMPRA])
);

CREATE TABLE [COMPRA_PRODUCTO] (
  [CANTIDAD] decimal(18,0),
  [PRECIO_UNIT] decimal(18,2),
  [PRECIO_TOTAL] decimal(18,2),
  [COD_COMPRA] decimal(19,0),
  [COD_PROD] nvarchar(50),
  CONSTRAINT [FK_COMPRA_PRODUCTO.CANTIDAD]
    FOREIGN KEY ([CANTIDAD])
      REFERENCES [COMPRA]([MEDIO_PAGO_COMPRA])
);

CREATE INDEX [PK FK] ON  [COMPRA_PRODUCTO] ([COD_COMPRA], [COD_PROD]);

CREATE TABLE [PROVINCIA] (
  [CODIGO_PROVINCIA] decimal(19,0),
  [NOMBRE] nvarchar(255),
  PRIMARY KEY ([CODIGO_PROVINCIA])
);

CREATE TABLE [MEDIO_ENVIO] (
  [ID_MEDIO_ENVIO] decimal(19,0),
  [COD_POSTAL] decimal(19,0),
  [MEDIO] nvarchar(255),
  PRIMARY KEY ([ID_MEDIO_ENVIO])
);

CREATE TABLE [DESCUENTO_CUPON] (
  [CODIGO_CUPON] nvarchar(255),
  [COD_VENTA] decimal(18,2),
  [VALOR_DESC] decimal(18,2),
  [FECHA_DESDE] date,
  [FECHA_HASTA] date,
  PRIMARY KEY ([CODIGO_CUPON])
);

CREATE TABLE [VENTA_PRODUCTO] (
  [CANTIDAD] decimal(18,0),
  [PRECIO_UNIT] decimal(18,2),
  [PRECIO_TOTAL] decimal(18,2),
  [COD_PROD] nvarchar(50),
  [COD_VENTA] decimal(19,0)
);

CREATE INDEX [PK FK] ON  [VENTA_PRODUCTO] ([COD_PROD], [COD_VENTA]);

CREATE TABLE [DESCUENTO_MEDIO_PAGO] (
  [CODIGO_DESC_MP] nvarchar(255),
  [PORCENTAJE_DESCUENTO] decimal(18,2),
  PRIMARY KEY ([CODIGO_DESC_MP])
);

CREATE TABLE [DESCUENTO_FIJO] (
  [CODIGO_DESC] nvarchar(255),
  [COD_VENTA] decimal(18,2),
  [TIPO_DESC] nvarchar(255),
  [VALOR_DESC] decimal(18,2),
  PRIMARY KEY ([CODIGO_DESC])
);

CREATE TABLE [PROVEEDOR] (
  [CUIT_PROV] nvarchar(50),
  [RAZON_SOCIAL_PROV] nvarchar(50),
  [DOMICILIO_PROV] nvarchar(50),
  [MAIL_PROV] nvarchar(50),
  [LOCALIDAD_PROV] nvarchar(255),
  [CODIGO_POSTAL] decimal(19,0),
  [CODIGO_PROVINCIA] decimal(19,0),
  PRIMARY KEY ([CUIT_PROV])
);

CREATE TABLE [MEDIO_DE_PAGO] (
  [ID_MEDIO_PAGO] decimal(19,0),
  [MEDIO_PAGO] nvarchar(255),
  [VALOR_DESC] decimal(18,2),
  [COSTO_TRANSACCION] decimal(18,2),
  [CODIGO_DESC] nvarchar(255),
  PRIMARY KEY ([ID_MEDIO_PAGO])
);

CREATE TABLE [CODIGO_POSTAL] (
  [CODIGO_POSTAL] decimal(19,0),
  [CODIGO_PROVINCIA] decimal(19,0),
  PRIMARY KEY ([CODIGO_POSTAL]),
  CONSTRAINT [FK_CODIGO_POSTAL.CODIGO_POSTAL]
    FOREIGN KEY ([CODIGO_POSTAL])
      REFERENCES [PROVEEDOR]([MAIL_PROV])
);

CREATE TABLE [CLIENTE] (
  [ID_CLIENTE] decimal(19,0),
  [NOMBRE_CLIENTE] nvarchar(255),
  [APELLIDO_CLIENTE] nvarchar(255),
  [DNI_CLIENTE] decimal(18,0),
  [DIRECCION_CLIENTE] nvarchar(255),
  [TELEFONO_CLIENTE] decimal(18,0),
  [MAIL_CLIENTE] nvarchar(255),
  [FECHA_NAC_CLIENTE] date,
  [LOCALIDAD_CLIENTE] nvarchar(255),
  [CODIGO_POSTAL] decimal(19,0),
  [CODIGO_PROVINCIA] decimal(19,0),
  PRIMARY KEY ([ID_CLIENTE])
);

CREATE TABLE [VENTA] (
  [COD_VENTA] decimal(19,0),
  [FECHA_VENTA] date,
  [ID_CLIENTE] decimal(19,0),
  [ID_CANAL_VENTA] decimal(19,0),
  [ID_MEDIO_ENVIO] decimal(19,0),
  [ID_MEDIO_PAGO] decimal(19,0),
  [CODIGO_DESC_VENTA] nvarchar(255),
  [TOTAL_VENTA] decimal(18,2),
  [PRECIO_ENVIO] decimal(18,2),
  PRIMARY KEY ([COD_VENTA]),
  CONSTRAINT [FK_VENTA.ID_CANAL_VENTA]
    FOREIGN KEY ([ID_CANAL_VENTA])
      REFERENCES [CANAL_VENTA]([CANAL_VENTA]),
  CONSTRAINT [FK_VENTA.ID_CANAL_VENTA]
    FOREIGN KEY ([ID_CANAL_VENTA])
      REFERENCES [CLIENTE]([DIRECCION_CLIENTE]),
  CONSTRAINT [FK_VENTA.ID_MEDIO_PAGO]
    FOREIGN KEY ([ID_MEDIO_PAGO])
      REFERENCES [MEDIO_DE_PAGO]([VALOR_DESC]),
  CONSTRAINT [FK_VENTA.FECHA_VENTA]
    FOREIGN KEY ([FECHA_VENTA])
      REFERENCES [MEDIO_ENVIO]([MEDIO])
);

CREATE TABLE [PRODUCTO] (
  [COD_PROD] nvarchar(50),
  [NOMBRE_PROD] nvarchar(50),
  [DESCRIPCION_PROD] nvarchar(50),
  [MARCA_PROD] nvarchar(255),
  [CATEGORIA_PROD] nvarchar(255),
  [MATERIAL_PROD] nvarchar(50),
  PRIMARY KEY ([COD_PROD])
);

CREATE TABLE [VARIANTE] (
  [CODIGO_VAR] nvarchar(50),
  [CODIGO_TIPO_VAR] nvarchar(50),
  [VALOR] nvarchar(50),
  PRIMARY KEY ([CODIGO_VAR])
);

CREATE TABLE [PRODUCTO_VARIANTE] (
  [CODIGO_VAR] nvarchar(50),
  [COD_PROD] nvarchar(50),
  [PRECIO_UNITARIO_PROD] decimal(18,2),
  [COD_PRODUCTO_VARIANTE] nvarchar(50),
  [STOCK] decimal(19,0),
  [DESCRIPCION] nvarchar(50),
  PRIMARY KEY ([COD_PRODUCTO_VARIANTE]),
  CONSTRAINT [FK_PRODUCTO_VARIANTE.CODIGO_VAR]
    FOREIGN KEY ([CODIGO_VAR])
      REFERENCES [PRODUCTO]([COD_PROD]),
  CONSTRAINT [FK_PRODUCTO_VARIANTE.COD_PROD]
    FOREIGN KEY ([COD_PROD])
      REFERENCES [VARIANTE]([CODIGO_VAR])
);

CREATE TABLE [DESCUENTO_COMPRA] (
  [CODIGO_DESC_COMPRA] decimal(18,2),
  [PORCENTAJE_DESC_COMPRA] decimal(19,0),
  [TIPO_DESC_COMPRA] decimal(19,0),
  PRIMARY KEY ([CODIGO_DESC_COMPRA])
);

CREATE TABLE [TIPO_VARIANTE] (
  [CODIGO_TIPO_VAR] nvarchar(50),
  [DESCRIPCION_TIPO_VAR] nvarchar(50),
  PRIMARY KEY ([CODIGO_TIPO_VAR])
);

CREATE TABLE [MEDIO_ENVIO_X_CODIGO_POSTAL] (
  [ID_MEDIO_ENVIO] decimal(19,0),
  [CODIGO_POSTAL] decimal(19,0),
  [TIEMPO_EST] decimal(18,2),
  [PRECIO] decimal(18,2),
  PRIMARY KEY ([ID_MEDIO_ENVIO], [CODIGO_POSTAL]),
  CONSTRAINT [FK_MEDIO_ENVIO_X_CODIGO_POSTAL.ID_MEDIO_ENVIO]
    FOREIGN KEY ([ID_MEDIO_ENVIO])
      REFERENCES [MEDIO_ENVIO]([ID_MEDIO_ENVIO]),
  CONSTRAINT [FK_MEDIO_ENVIO_X_CODIGO_POSTAL.ID_MEDIO_ENVIO]
    FOREIGN KEY ([ID_MEDIO_ENVIO])
      REFERENCES [CODIGO_POSTAL]([CODIGO_PROVINCIA])
);

CREATE TABLE [DESCUENTO_X_COMPRA] (
  [COD_COMPRA] decimal(19,0),
  [CODIGO_DESC_COMPRA] decimal(18,2),
  PRIMARY KEY ([COD_COMPRA], [CODIGO_DESC_COMPRA]),
  CONSTRAINT [FK_DESCUENTO_X_COMPRA.COD_COMPRA]
    FOREIGN KEY ([COD_COMPRA])
      REFERENCES [COMPRA]([MEDIO_PAGO_COMPRA]),
  CONSTRAINT [FK_DESCUENTO_X_COMPRA.COD_COMPRA]
    FOREIGN KEY ([COD_COMPRA])
      REFERENCES [DESCUENTO_COMPRA]([PORCENTAJE_DESC_COMPRA])
);

CREATE TABLE [VENTA_MEDIANTE_CUPON] (
  [COD_VENTA] nvarchar(255),
  [CODIGO_CUPON] nvarchar(255),
  [] <type>,
  PRIMARY KEY ([COD_VENTA])
);

CREATE TABLE [VENTA_MEDIANTE_DESCUENTO_FIJO] (
  [COD_VENTA] nvarchar(255),
  [CODIGO_DESCUENTO] nvarchar(255),
  [] <type>,
  PRIMARY KEY ([COD_VENTA], [CODIGO_DESCUENTO])
);

CREATE TABLE [DESCUENTO_X_MEDIO_DE_PAGO] (
  [CODIGO_DESC_MP] decimal(19,0),
  [ID_MEDIO_PAGO] decimal(18,2),
  PRIMARY KEY ([CODIGO_DESC_MP], [ID_MEDIO_PAGO]),
  CONSTRAINT [FK_DESCUENTO_X_MEDIO_DE_PAGO.CODIGO_DESC_MP]
    FOREIGN KEY ([CODIGO_DESC_MP])
      REFERENCES [DESCUENTO_MEDIO_PAGO]([CODIGO_DESC_MP]),
  CONSTRAINT [FK_DESCUENTO_X_MEDIO_DE_PAGO.CODIGO_DESC_MP]
    FOREIGN KEY ([CODIGO_DESC_MP])
      REFERENCES [MEDIO_DE_PAGO]([VALOR_DESC])
);
