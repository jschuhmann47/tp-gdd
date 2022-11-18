USE [GD2C2022]
GO


CREATE TABLE  [gd_esquema].[MEDIO_DE_PAGO] (
  [ID_MEDIO_PAGO] decimal(19,0) IDENTITY (1,1),
  [MEDIO_PAGO] nvarchar(255),
  [VALOR_DESC] decimal(18,2),
  [COSTO_TRANSACCION] decimal(18,2),
--  [CODIGO_DESC_MP] decimal(19,0),
   PRIMARY KEY  ([ID_MEDIO_PAGO])
);


CREATE TABLE [gd_esquema].[COMPRA] (
  [COD_COMPRA] decimal(19,0),
  [FECHA_COMPRA] date,
  [ID_MEDIO_PAGO] decimal(19,0),
  [TOTAL_COMPRA] decimal(18,2),
  [CUIT_PROV] nvarchar(50),
--  [CODIGO_DESC_COMPRA] decimal(19,0),
  PRIMARY KEY ([COD_COMPRA])
);

CREATE TABLE [gd_esquema].[PROVINCIA] (
  [CODIGO_PROVINCIA] decimal(19,0) IDENTITY (1,1),
  [NOMBRE_PROV] nvarchar(255),
  PRIMARY KEY ([CODIGO_PROVINCIA])
);

CREATE TABLE [gd_esquema].[VENTA_MEDIANTE_CUPON] (
  [COD_VENTA] decimal(19,0),
  [CODIGO_CUPON] nvarchar(255),
  [IMPORTE] decimal(18,2),
  PRIMARY KEY ([COD_VENTA], [CODIGO_CUPON])
);



CREATE TABLE [gd_esquema].[PROVEEDOR] (
  [CUIT_PROV] nvarchar(50),
  [RAZON_SOCIAL_PROV] nvarchar(50),
  [DOMICILIO_PROV] nvarchar(50),
  [MAIL_PROV] nvarchar(50),
  [LOCALIDAD_PROV] nvarchar(255),
  [CODIGO_POSTAL] decimal(19,0),
  [CODIGO_PROVINCIA] decimal(19,0),
  PRIMARY KEY ([CUIT_PROV])
);

CREATE TABLE [gd_esquema].[CLIENTE] (
  [ID_CLIENTE] decimal(19,0) IDENTITY (1,1),
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

CREATE TABLE [gd_esquema].[DESCUENTO_COMPRA] (
  [CODIGO_DESC_COMPRA] decimal(19,0) IDENTITY (1,1),
  [MONTO_DESC_COMPRA] decimal(19,0),
  PRIMARY KEY ([CODIGO_DESC_COMPRA])
);


CREATE TABLE [gd_esquema].[DESCUENTO_MEDIO_PAGO] (
  [CODIGO_DESC_MP] DECIMAL(19,0) IDENTITY (1,1),
  [PORCENTAJE_DESCUENTO] decimal(18,2),
  PRIMARY KEY ([CODIGO_DESC_MP])
);


CREATE TABLE [gd_esquema].[PRODUCTO] (
  [COD_PROD] nvarchar(50),
  [NOMBRE_PROD] nvarchar(50),
  [DESCRIPCION_PROD] nvarchar(50),
  [ID_MARCA_PROD] decimal(19,0), --todo hacer las constraints
  [ID_CATEGORIA_PROD] decimal(19,0),
  [ID_MATERIAL_PROD] decimal(19,0),
  PRIMARY KEY ([COD_PROD])
);

CREATE TABLE [gd_esquema].[MARCA] (
  [ID_MARCA] decimal(19,0),
  [MARCA] nvarchar(255),
  PRIMARY KEY ([ID_MARCA])
);

CREATE TABLE [gd_esquema].[CATEGORIA] (
  [ID_CATEGORIA] decimal(19,0),
  [CATEGORIA] nvarchar(255),
  PRIMARY KEY ([ID_CATEGORIA])
);

CREATE TABLE [gd_esquema].[MATERIAL] (
  [ID_MATERIAL] decimal(19,0), --todo alter table fk
  [MATERIAL] nvarchar(50),
  PRIMARY KEY ([ID_MATERIAL])
);

CREATE TABLE [gd_esquema].[VARIANTE] (
  [CODIGO_VAR] nvarchar(50),
  [CODIGO_TIPO_VAR] nvarchar(50),
  [VALOR] nvarchar(50),
  PRIMARY KEY ([CODIGO_VAR])
);

CREATE TABLE [gd_esquema].[TIPO_VARIANTE] (
  [CODIGO_TIPO_VAR] nvarchar(50),
  [DESCRIPCION_TIPO_VAR] nvarchar(50),
  PRIMARY KEY ([CODIGO_TIPO_VAR])
);

CREATE TABLE [gd_esquema].[VENTA_MEDIANTE_DESCUENTO_FIJO] (
  [COD_VENTA] decimal(19,0),
  [CODIGO_DESCUENTO] decimal(19,0),
  [IMPORTE] decimal(18,2),
  PRIMARY KEY ([COD_VENTA], [CODIGO_DESCUENTO])
);

CREATE TABLE [gd_esquema].[CANAL_VENTA] (
  [ID_CANAL_VENTA] decimal(19,0) IDENTITY (1,1),
  [CANAL_VENTA] nvarchar(255),
  [CANAL_COSTO] decimal(19,0),
  PRIMARY KEY ([ID_CANAL_VENTA])
);

CREATE TABLE [gd_esquema].[DESCUENTO_CUPON] (
  [CODIGO_CUPON] nvarchar(255),
  --[COD_VENTA] decimal(19,0),
  [VALOR_DESC] decimal(19,0),
  [FECHA_DESDE] date,
  [FECHA_HASTA] date,
  PRIMARY KEY ([CODIGO_CUPON])
);


CREATE TABLE [gd_esquema].[VENTA_PRODUCTO] (
  [CANTIDAD] decimal(18,0),
  [PRECIO_UNIT] decimal(18,2),
  [PRECIO_TOTAL] decimal(18,2),
  [COD_PRODUCTO_VARIANTE] nvarchar(50),
  [COD_VENTA] decimal(19,0),
  PRIMARY KEY ([COD_PRODUCTO_VARIANTE], [COD_VENTA])
);


CREATE TABLE [gd_esquema].[DESCUENTO_FIJO] (
  [CODIGO_DESCUENTO] decimal(19,0) IDENTITY (1,1),
  --[COD_VENTA] decimal(18,2),
  [TIPO_DESC] nvarchar(255),
  [VALOR_DESC] decimal(18,2),
  PRIMARY KEY ([CODIGO_DESCUENTO])
);

CREATE TABLE [gd_esquema].[PRODUCTO_VARIANTE] (
  [CODIGO_VAR] nvarchar(50),
  [COD_PROD] nvarchar(50),
  [COD_PRODUCTO_VARIANTE] nvarchar(50),
  [STOCK] decimal(19,0),
  [DESCRIPCION] nvarchar(50),
  PRIMARY KEY ([COD_PRODUCTO_VARIANTE])
);


CREATE TABLE [gd_esquema].[COMPRA_PRODUCTO] (
  [CANTIDAD] decimal(18,0),
  [PRECIO_UNIT] decimal(18,2),
  [PRECIO_TOTAL] decimal(18,2),
  [COD_COMPRA] decimal(19,0),
  [COD_PRODUCTO_VARIANTE] nvarchar(50),
  PRIMARY KEY ([COD_COMPRA], [COD_PRODUCTO_VARIANTE])
);



CREATE TABLE [gd_esquema].[CODIGO_POSTAL] (
  [CODIGO_POSTAL] decimal(19,0),
  [CODIGO_PROVINCIA] decimal(19,0),
  PRIMARY KEY ([CODIGO_POSTAL])
);


CREATE TABLE [gd_esquema].[DESCUENTO_X_COMPRA] (
  [COD_COMPRA] decimal(19,0),
  [CODIGO_DESC_COMPRA] decimal(19,0),
  PRIMARY KEY ([COD_COMPRA], [CODIGO_DESC_COMPRA])
);

CREATE TABLE [gd_esquema].[DESCUENTO_X_MEDIO_DE_PAGO] (
  [CODIGO_DESC_MP] decimal(19,0),
  [ID_MEDIO_PAGO] decimal(19,0),
  PRIMARY KEY ([CODIGO_DESC_MP], [ID_MEDIO_PAGO])
);


CREATE TABLE [gd_esquema].[MEDIO_ENVIO_X_CODIGO_POSTAL] (
  [ID_MEDIO_ENVIO] decimal(19,0) IDENTITY (1,1),
  [CODIGO_POSTAL] decimal(19,0),
  [TIEMPO_EST] decimal(18,2),
  [PRECIO] decimal(18,2),
  [MEDIO] nvarchar(255),
  --PRIMARY KEY ([ID_MEDIO_ENVIO],[CODIGO_POSTAL])
  PRIMARY KEY ([ID_MEDIO_ENVIO])
);


CREATE TABLE [gd_esquema].[VENTA] (
  [COD_VENTA] decimal(19,0),
  [FECHA_VENTA] date,
  [ID_CLIENTE] decimal(19,0),
  [ID_CANAL_VENTA] decimal(19,0),
  [ID_MEDIO_ENVIO] decimal(19,0),
  [ID_MEDIO_PAGO] decimal(19,0),
  [TOTAL_VENTA] decimal(18,2),
  [PRECIO_ENVIO] decimal(18,2),
  [CANAL_COSTO] decimal(19,0),
  [COSTO_TRANSACCION] decimal(18,2),
  PRIMARY KEY ([COD_VENTA])
);

--Alters

ALTER TABLE [gd_esquema].[COMPRA] ADD CONSTRAINT [FK_COMPRA.ID_MEDIO_PAGO] FOREIGN KEY ([ID_MEDIO_PAGO]) REFERENCES [MEDIO_DE_PAGO]([ID_MEDIO_PAGO])
ALTER TABLE [gd_esquema].[COMPRA] ADD  CONSTRAINT [FK_COMPRA.CUIT_PROV] FOREIGN KEY ([CUIT_PROV]) REFERENCES [PROVEEDOR]([CUIT_PROV])

ALTER TABLE [gd_esquema].VENTA_MEDIANTE_CUPON ADD CONSTRAINT [FK_VENTA_MEDIANTE_CUPON.CODIGO_CUPON] FOREIGN KEY ([CODIGO_CUPON]) REFERENCES [DESCUENTO_CUPON]([CODIGO_CUPON])
ALTER TABLE [gd_esquema].VENTA_MEDIANTE_CUPON ADD CONSTRAINT [FK_VENTA_MEDIANTE_CUPON.COD_VENTA] FOREIGN KEY ([COD_VENTA]) REFERENCES [VENTA]([COD_VENTA])

ALTER TABLE [gd_esquema].PROVEEDOR ADD CONSTRAINT[FK_PROVEEDOR.CODIGO_POSTAL] FOREIGN KEY ([CODIGO_POSTAL]) REFERENCES [CODIGO_POSTAL]([CODIGO_POSTAL])
ALTER TABLE [gd_esquema].PROVEEDOR ADD CONSTRAINT[FK_PROVEEDOR.CODIGO_PROVINCIA] FOREIGN KEY ([CODIGO_PROVINCIA]) REFERENCES [PROVINCIA]([CODIGO_PROVINCIA])

ALTER TABLE [gd_esquema].CLIENTE ADD CONSTRAINT [FK_CLIENTE.CODIGO_POSTAL] FOREIGN KEY ([CODIGO_POSTAL]) REFERENCES [CODIGO_POSTAL]([CODIGO_POSTAL])
ALTER TABLE [gd_esquema].CLIENTE ADD CONSTRAINT [FK_CLIENTE.CODIGO_PROVINCIA] FOREIGN KEY ([CODIGO_PROVINCIA]) REFERENCES [PROVINCIA]([CODIGO_PROVINCIA]) 

ALTER TABLE [gd_esquema].VARIANTE ADD CONSTRAINT [FK_MEDIO_DE_PAGO.CODIGO_TIPO_VAR] FOREIGN KEY ([CODIGO_TIPO_VAR]) REFERENCES [TIPO_VARIANTE]([CODIGO_TIPO_VAR])

ALTER TABLE [gd_esquema].VENTA_MEDIANTE_DESCUENTO_FIJO ADD CONSTRAINT [FK_VENTA_MEDIANTE_DESCUENTO_FIJO.COD_VENTA] FOREIGN KEY ([COD_VENTA]) REFERENCES [VENTA]([COD_VENTA])
ALTER TABLE [gd_esquema].VENTA_MEDIANTE_DESCUENTO_FIJO ADD CONSTRAINT [FK_VENTA_MEDIANTE_DESCUENTO_FIJO.CODIGO_DESCUENTO] FOREIGN KEY ([CODIGO_DESCUENTO]) REFERENCES [DESCUENTO_FIJO]([CODIGO_DESCUENTO])

ALTER TABLE [gd_esquema].DESCUENTO_CUPON ADD CONSTRAINT [COD_VENTA] FOREIGN KEY ([COD_VENTA]) REFERENCES [VENTA_MEDIANTE_CUPON]([COD_VENTA])



ALTER TABLE [gd_esquema].VENTA_PRODUCTO ADD CONSTRAINT [COD_PRODUCTO_VARIANTE] FOREIGN KEY ([COD_PRODUCTO_VARIANTE]) REFERENCES [PRODUCTO_VARIANTE]([COD_PRODUCTO_VARIANTE])
ALTER TABLE [gd_esquema].VENTA_PRODUCTO ADD  CONSTRAINT [FK_VENTA_PRODUCTO.CODIGO_VENTA] FOREIGN KEY ([COD_VENTA]) REFERENCES [VENTA]([COD_VENTA])

ALTER TABLE [gd_esquema].PRODUCTO_VARIANTE ADD CONSTRAINT [FK_PRODUCTO_VARIANTE.CODIGO_VAR] FOREIGN KEY ([CODIGO_VAR]) REFERENCES [VARIANTE]([CODIGO_VAR])
ALTER TABLE [gd_esquema].PRODUCTO_VARIANTE ADD CONSTRAINT [FK_PRODUCTO_VARIANTE.COD_PROD] FOREIGN KEY ([COD_PROD]) REFERENCES [PRODUCTO]([COD_PROD])

ALTER TABLE [gd_esquema].COMPRA_PRODUCTO ADD CONSTRAINT [FK_COMPRA_PRODUCTO.COD_COMPRA] FOREIGN KEY ([COD_COMPRA]) REFERENCES [COMPRA]([COD_COMPRA])
ALTER TABLE [gd_esquema].COMPRA_PRODUCTO ADD CONSTRAINT [FK_COMPRA_PRODUCTO.COD_PRODUCTO_VARIANTE] FOREIGN KEY ([COD_PRODUCTO_VARIANTE]) REFERENCES [PRODUCTO_VARIANTE]([COD_PRODUCTO_VARIANTE])

ALTER TABLE [gd_esquema].CODIGO_POSTAL ADD CONSTRAINT [FK_CODIGO_POSTAL.CODIGO_POSTAL] FOREIGN KEY ([CODIGO_PROVINCIA]) REFERENCES [PROVINCIA]([CODIGO_PROVINCIA])

ALTER TABLE [gd_esquema].DESCUENTO_X_COMPRA ADD CONSTRAINT [FK_DESCUENTO_X_COMPRA.COD_COMPRA] FOREIGN KEY ([COD_COMPRA]) REFERENCES [COMPRA]([COD_COMPRA])
ALTER TABLE [gd_esquema].DESCUENTO_X_COMPRA ADD CONSTRAINT [FK_DESCUENTO_X_COMPRA.CODIGO_DESC_COMPRA] FOREIGN KEY ([CODIGO_DESC_COMPRA]) REFERENCES [DESCUENTO_COMPRA]([CODIGO_DESC_COMPRA])

ALTER TABLE [gd_esquema].DESCUENTO_X_MEDIO_DE_PAGO ADD CONSTRAINT [FK_DESCUENTO_X_MEDIO_DE_PAGO.CODIGO_DESC_MP] FOREIGN KEY ([CODIGO_DESC_MP]) REFERENCES [DESCUENTO_MEDIO_PAGO]([CODIGO_DESC_MP])
ALTER TABLE [gd_esquema].DESCUENTO_X_MEDIO_DE_PAGO ADD CONSTRAINT [FK_DESCUENTO_X_MEDIO_DE_PAGO.ID_MEDIO_PAGO] FOREIGN KEY ([ID_MEDIO_PAGO]) REFERENCES [MEDIO_DE_PAGO]([ID_MEDIO_PAGO])

ALTER TABLE [gd_esquema].MEDIO_ENVIO_X_CODIGO_POSTAL ADD CONSTRAINT [FK_MEDIO_ENVIO_X_CODIGO_POSTAL.CODIGO_POSTAL] FOREIGN KEY ([CODIGO_POSTAL]) REFERENCES [CODIGO_POSTAL]([CODIGO_POSTAL])

ALTER TABLE [gd_esquema].VENTA ADD CONSTRAINT [FK_VENTA.ID_MEDIO_PAGO] FOREIGN KEY ([ID_MEDIO_PAGO]) REFERENCES [MEDIO_DE_PAGO]([ID_MEDIO_PAGO])
------
ALTER TABLE [gd_esquema].VENTA ADD CONSTRAINT [FK_VENTA.ID_MEDIO_ENVIO] FOREIGN KEY ([ID_MEDIO_ENVIO]) REFERENCES [MEDIO_ENVIO_X_CODIGO_POSTAL]([ID_MEDIO_ENVIO])
------
ALTER TABLE [gd_esquema].VENTA ADD CONSTRAINT [FK_VENTA.ID_CANAL_VENTA] FOREIGN KEY ([ID_CANAL_VENTA]) REFERENCES [CANAL_VENTA]([ID_CANAL_VENTA])
ALTER TABLE [gd_esquema].VENTA ADD CONSTRAINT [FK_VENTA.ID_CLIENTE] FOREIGN KEY ([ID_CLIENTE]) REFERENCES [CLIENTE]([ID_CLIENTE])

--CHEQUEAR:
ALTER TABLE [gd_esquema].PRODUCTO ADD CONSTRAINT [FK_PRODUCTO.ID_MARCA] FOREIGN KEY ([ID_MARCA_PROD]) REFERENCES [MARCA]([ID_MARCA])
ALTER TABLE [gd_esquema].PRODUCTO ADD CONSTRAINT [FK_PRODUCTO.ID_CATEGORIA] FOREIGN KEY ([ID_CATEGORIA_PROD]) REFERENCES [CATEGORIA]([ID_CATEGORIA_PROD])
ALTER TABLE [gd_esquema].PRODUCTO ADD CONSTRAINT [FK_PRODUCTO.ID_MATERIAL] FOREIGN KEY ([ID_MATERIAL_PROD]) REFERENCES [MATERIAL]([ID_MATERIAL])

GO


CREATE PROCEDURE insertar_proveedor
AS
BEGIN
	DECLARE @cuit nvarchar(255),@domicilio nvarchar(255),@codPostal decimal(19,0),@razonSocial nvarchar(255),@mail nvarchar(255),@provincia nvarchar(255),@localidad nvarchar(255)
	DECLARE cursorc CURSOR FOR (SELECT DISTINCT PROVEEDOR_CUIT,PROVEEDOR_DOMICILIO,PROVEEDOR_CODIGO_POSTAL,PROVEEDOR_RAZON_SOCIAL,
								PROVEEDOR_MAIL,PROVEEDOR_PROVINCIA, PROVEEDOR_LOCALIDAD
								FROM gd_esquema.Maestra WHERE PROVEEDOR_CUIT IS NOT NULL)
	OPEN cursorc
	FETCH NEXT FROM	cursorc INTO @cuit,@domicilio,@codPostal,@razonSocial,@mail,@provincia,@localidad
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
	DECLARE @codProvincia decimal(19,0)
		IF NOT EXISTS (SELECT 1 FROM provincia WHERE NOMBRE_PROV = @codPostal)
		BEGIN
			INSERT INTO provincia (nombre_prov)
			VALUES (@provincia)
      IF NOT EXISTS (SELECT 1 FROM codigo_postal WHERE CODIGO_POSTAL = @codPostal)
      BEGIN
        INSERT INTO codigo_postal (codigo_provincia)
        SELECT codigo_provincia FROM PROVINCIA WHERE nombre_prov = @provincia
      END
		END	
		SELECT @codProvincia = codigo_provincia FROM provincia WHERE nombre_prov = @provincia 
		INSERT INTO proveedor (cuit_prov,razon_social_prov,domicilio_prov,mail_prov,localidad_prov,codigo_postal,codigo_provincia)
		VALUES (@cuit,@razonSocial,@domicilio,@mail,@localidad,@codPostal,@codProvincia)
		FETCH NEXT FROM	cursorc INTO @cuit,@domicilio,@codPostal,@razonSocial,@mail,@provincia,@localidad
	END
	CLOSE cursorc
	DEALLOCATE cursorc
END

--exec insertar_proveedor 
--DROP  PROCEDURE insertar_proveedor

GO

CREATE PROCEDURE insertar_productos
AS
BEGIN
	INSERT INTO producto (cod_prod,nombre_prod,descripcion_prod,marca_prod,categoria_prod,material_prod)
	SELECT DISTINCT PRODUCTO_CODIGO,PRODUCTO_NOMBRE,PRODUCTO_DESCRIPCION,PRODUCTO_MARCA,PRODUCTO_CATEGORIA,PRODUCTO_MATERIAL 
	FROM gd_esquema.Maestra
	WHERE PRODUCTO_CODIGO IS NOT NULL
END

GO

CREATE PROCEDURE insertar_canales_venta
AS
BEGIN
	INSERT INTO canal_venta (canal_venta,canal_costo)
	SELECT DISTINCT VENTA_CANAL,VENTA_CANAL_COSTO 
	FROM gd_esquema.Maestra
	WHERE VENTA_CANAL IS NOT NULL
END

GO

CREATE PROCEDURE insertar_variantes
AS
BEGIN
	DECLARE @variante nvarchar(50),@tipo nvarchar(50),@codigo nvarchar(50)
	DECLARE cursorc CURSOR FOR SELECT DISTINCT PRODUCTO_VARIANTE,PRODUCTO_TIPO_VARIANTE,PRODUCTO_VARIANTE_CODIGO 
								FROM gd_esquema.Maestra
								WHERE PRODUCTO_VARIANTE_CODIGO IS NOT NULL
	OPEN cursorc
	FETCH NEXT FROM cursorc INTO @variante,@tipo,@codigo
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		INSERT INTO tipo_variante (codigo_tipo_var,descripcion_tipo_var)
		VALUES (@codigo,@tipo)
		INSERT INTO variante (codigo_tipo_var,valor)
		VALUES (@codigo,@variante)
		FETCH NEXT FROM cursorc INTO @variante,@tipo,@codigo
	END
	CLOSE cursorc
	DEALLOCATE cursorcr
END

GO

CREATE PROCEDURE insertar_clientes
AS
BEGIN
	DECLARE @nombre nvarchar(255),@apellido nvarchar(255),@dni decimal(18,0),@direccion nvarchar(255),@telefono decimal(18,0),@mail nvarchar(255),@fechaNacimiento date,@localidad nvarchar(255),@codPostal decimal(19,0),@provincia nvarchar(255)
	DECLARE cursorc CURSOR FOR 
		(SELECT DISTINCT CLIENTE_NOMBRE,CLIENTE_APELLIDO,CLIENTE_DNI,CLIENTE_DIRECCION,CLIENTE_TELEFONO,
		CLIENTE_MAIL, CLIENTE_FECHA_NAC,CLIENTE_LOCALIDAD, CLIENTE_CODIGO_POSTAL, CLIENTE_PROVINCIA  
		FROM gd_esquema.Maestra
		WHERE CLIENTE_DNI IS NOT NULL)
	OPEN cursorc
	FETCH NEXT FROM cursorc INTO @nombre,@apellido,@dni,@direccion,@telefono,@mail,@fechaNacimiento,@localidad,@codPostal,@provincia
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		DECLARE @codProvincia decimal(19,0)
		IF NOT EXISTS (SELECT 1 FROM codigo_postal WHERE CODIGO_POSTAL = @codPostal) --codigo_postal nuestra tabla
		BEGIN
			INSERT INTO provincia (nombre_prov)
			VALUES (@provincia)
			INSERT INTO codigo_postal (codigo_provincia)
			SELECT codigo_provincia FROM provincia WHERE nombre_prov = @provincia --distinct?
		END
		SELECT @codProvincia = codigo_provincia from provincia WHERE nombre_prov = @provincia
		INSERT INTO cliente (nombre_cliente,apellido_cliente,dni_cliente,direccion_cliente,telefono_cliente,mail_cliente,fecha_nac_cliente,localidad_cliente,codigo_postal,codigo_provincia)
		VALUES (@nombre,@apellido,@dni,@direccion,@telefono,@mail,@fechaNacimiento,@localidad,@codPostal,@codProvincia)
		FETCH NEXT FROM cursorc INTO @nombre,@apellido,@dni,@direccion,@telefono,@mail,@fechaNacimiento,@localidad,@codPostal,@provincia
	END
	CLOSE cursorc
	DEALLOCATE cursorc
END

GO

CREATE PROCEDURE insertar_descuentos_compra
AS
BEGIN
	INSERT INTO DESCUENTO_COMPRA (codigo_desc_compra,monto_desc_compra)
	SELECT DISTINCT DESCUENTO_COMPRA_CODIGO,DESCUENTO_COMPRA_VALOR 
	FROM gd_esquema.Maestra WHERE DESCUENTO_COMPRA_CODIGO IS NOT NULL
END

GO

CREATE PROCEDURE insertar_medio_envio_x_codigo_postal
AS
BEGIN
	INSERT INTO MEDIO_ENVIO_X_CODIGO_POSTAL (codigo_postal,tiempo_est,precio,medio)
	SELECT DISTINCT CLIENTE_CODIGO_POSTAL,NULL TIEMPO_EST,VENTA_ENVIO_PRECIO,VENTA_MEDIO_ENVIO
  FROM gd_esquema.Maestra
  WHERE VENTA_MEDIO_ENVIO IS NOT NULL
END

GO

CREATE PROCEDURE insertar_descuentos_cupon
AS
BEGIN
	INSERT INTO DESCUENTO_CUPON (codigo_cupon,valor_desc,fecha_desde,fecha_hasta)
	SELECT DISTINCT VENTA_CUPON_CODIGO,VENTA_CUPON_VALOR,VENTA_CUPON_FECHA_DESDE,VENTA_CUPON_FECHA_HASTA 
	FROM gd_esquema.Maestra WHERE VENTA_CUPON_CODIGO IS NOT NULL
END

GO

CREATE PROCEDURE insertar_descuentos_fijo
AS
BEGIN
  INSERT INTO DESCUENTO_FIJO (tipo_desc,valor_desc)
  SELECT DISTINCT VENTA_DESCUENTO_CONCEPTO,VENTA_DESCUENTO_IMPORTE
  FROM gd_esquema.Maestra
  WHERE VENTA_DESCUENTO_CONCEPTO IS NOT NULL AND VENTA_DESCUENTO_CONCEPTO = 'Otros'
END

GO

CREATE PROCEDURE insertar_compras
AS
BEGIN
	DECLARE @codCompra decimal(19,0),@fecha date,@medioPago nvarchar(255),@total decimal(18,2),@cuit nvarchar(50),@codDescuentoCompra decimal(19,0),@prodVarianteCod nvarchar(50)
	DECLARE cursorc CURSOR FOR 
	SELECT DISTINCT COMPRA_NUMERO,COMPRA_FECHA,COMPRA_MEDIO_PAGO,COMPRA_TOTAL,PROVEEDOR_CUIT,DESCUENTO_COMPRA_CODIGO,PRODUCTO_VARIANTE_CODIGO
	FROM gd_esquema.Maestra WHERE COMPRA_NUMERO IS NOT NULL
	OPEN cursorc
	FETCH cursorc INTO @codCompra,@fecha,@medioPago,@total,@cuit,@codDescuentoCompra,@prodVarianteCod
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		DECLARE @totalCompra decimal(18,2)
		INSERT INTO COMPRA_PRODUCTO
		SELECT COMPRA_PRODUCTO_CANTIDAD,COMPRA_PRODUCTO_PRECIO,  (COMPRA_PRODUCTO_CANTIDAD*COMPRA_PRODUCTO_PRECIO) precio_total, @codCompra,@prodVarianteCod
		FROM gd_esquema.Maestra WHERE COMPRA_NUMERO = @codCompra
		select @totalCompra =  (COMPRA_PRODUCTO_CANTIDAD*COMPRA_PRODUCTO_PRECIO)FROM gd_esquema.Maestra WHERE COMPRA_NUMERO = @codCompra

		INSERT INTO compra (COD_COMPRA,FECHA_COMPRA,ID_MEDIO_PAGO, TOTAL_COMPRA,CUIT_PROV)
		VALUES (@codCompra,@fecha,(SELECT ID_MEDIO_PAGO FROM MEDIO_DE_PAGO WHERE MEDIO_PAGO=@medioPago),@totalCompra,@cuit)

		INSERT INTO DESCUENTO_X_COMPRA (cod_compra,codigo_desc_compra)
		VALUES (@codCompra,@codDescuentoCompra)


		FETCH cursorc INTO @codCompra,@fecha,@medioPago,@total,@cuit,@codDescuentoCompra
	END
	CLOSE cursorc
	DEALLOCATE cursorc
END

GO

CREATE PROCEDURE insertar_medios_de_pago
AS
BEGIN
  DECLARE @medioPago nvarchar(255),@valorDescuento decimal(18,2),@costoTransaccion decimal(18,2),@medioPagoId decimal(19,0),@descuentoConcepto nvarchar(255)

  DECLARE cursorc CURSOR FOR
  SELECT DISTINCT VENTA_MEDIO_PAGO,VENTA_DESCUENTO_IMPORTE,VENTA_MEDIO_PAGO_COSTO,VENTA_DESCUENTO_CONCEPTO
  FROM gd_esquema.Maestra
  WHERE VENTA_MEDIO_PAGO IS NOT NULL
  OPEN cursorc
  FETCH cursorc INTO @medioPago,@valorDescuento,@costoTransaccion,@descuentoConcepto
  WHILE (@@FETCH_STATUS = 0)
  BEGIN
    IF (@descuentoConcepto != 'Otros')
    BEGIN
      INSERT INTO MEDIO_DE_PAGO (medio_pago,valor_desc,costo_transaccion)
      VALUES (@medioPago,@valorDescuento,@costoTransaccion)
    END
    ELSE
    BEGIN
      INSERT INTO MEDIO_DE_PAGO (medio_pago,VALOR_DESC,costo_transaccion)
      VALUES (@medioPago,0,@costoTransaccion)
    END
	FETCH cursorc INTO @medioPago,@valorDescuento,@costoTransaccion,@descuentoConcepto
  END
  CLOSE cursorc
  DEALLOCATE cursorc
END

GO

CREATE PROCEDURE insertar_descuentos_x_medio_de_pago
AS
BEGIN
  DECLARE @medioPagoId decimal(19,0),@porcDescuento decimal(18,2)
  DECLARE cursorc CURSOR FOR
  SELECT DISTINCT VENTA_MEDIO_PAGO, VENTA_DESCUENTO_IMPORTE/VENTA_TOTAL PORCENTAJE_DESCUENTO 
  FROM gd_esquema.Maestra
  WHERE VENTA_MEDIO_PAGO IS NOT NULL AND VENTA_DESCUENTO_IMPORTE IS NOT NULL
  OPEN cursorc
  FETCH cursorc INTO @medioPagoId,@porcDescuento
  WHILE (@@FETCH_STATUS = 0)
  BEGIN
    INSERT INTO DESCUENTO_X_MEDIO_DE_PAGO (id_medio_pago,CODIGO_DESC_MP)
    VALUES (@medioPagoId,(SELECT CODIGO_DESC_MP FROM  DESCUENTO_MEDIO_PAGO WHERE PORCENTAJE_DESCUENTO=@porcDescuento))
    FETCH cursorc INTO @medioPagoId,@porcDescuento
  END
  CLOSE cursorc
  DEALLOCATE cursorc
END

GO

CREATE FUNCTION id_producto_variante(@variante nvarchar(50),@tipoVariante nvarchar(50))
RETURNS nvarchar(50)
AS
BEGIN
  DECLARE @id nvarchar(50)
  SELECT @id=codigo_var FROM VARIANTE
  WHERE valor = @VARIANTE AND (SELECT codigo_tipo_var FROM TIPO_VARIANTE WHERE descripcion_tipo_var = @tipoVariante) = codigo_tipo_var
  RETURN @id
END

GO

CREATE PROCEDURE insertar_producto_variante
AS
BEGIN
  DECLARE @prodVarianteCod nvarchar(50),@prodCod nvarchar(50),@stock decimal(19,0),@descripcion nvarchar(50),@variante nvarchar(50),@tipoVariante nvarchar(50)
  DECLARE cursorc CURSOR FOR SELECT DISTINCT PRODUCTO_VARIANTE_CODIGO,PRODUCTO_CODIGO,PRODUCTO_TIPO_VARIANTE,PRODUCTO_VARIANTE,PRODUCTO_DESCRIPCION
  FROM gd_esquema.Maestra WHERE PRODUCTO_VARIANTE_CODIGO IS NOT NULL
  OPEN cursorc
  FETCH NEXT FROM cursorc INTO @prodVarianteCod,@prodCod,@variante,@tipoVariante,@descripcion
  WHILE(@@FETCH_STATUS = 0)
  BEGIN
    IF NOT EXISTS (SELECT 1 FROM PRODUCTO_VARIANTE WHERE codigo_var = @prodVarianteCod)
    BEGIN
      INSERT INTO PRODUCTO_VARIANTE (codigo_var,cod_prod,cod_producto_variante,stock,descripcion)
      VALUES (dbo.id_producto_variante(@variante,@tipoVariante),@prodCod,@prodVarianteCod,0,@descripcion) 
    END
    ELSE
    BEGIN
      UPDATE PRODUCTO_VARIANTE
      SET stock += @stock
      WHERE codigo_var = @prodVarianteCod
    END
    FETCH NEXT FROM cursorc INTO @prodVarianteCod,@prodCod,@variante,@tipoVariante,@descripcion
  END
  CLOSE cursorc
  DEALLOCATE cursorc
END

GO

CREATE PROCEDURE insertar_compra_producto
AS
BEGIN
	INSERT INTO COMPRA_PRODUCTO (cod_compra,cod_producto_variante,cantidad,precio_unit,precio_total)
	SELECT COMPRA_NUMERO,PRODUCTO_VARIANTE_CODIGO,COMPRA_PRODUCTO_CANTIDAD,COMPRA_PRODUCTO_PRECIO,SUM(COMPRA_PRODUCTO_CANTIDAD*COMPRA_PRODUCTO_PRECIO) PRECIO_TOTAL
	FROM gd_esquema.Maestra
	WHERE COMPRA_NUMERO IS NOT NULL AND PRODUCTO_VARIANTE_CODIGO IS NOT NULL
	GROUP BY COMPRA_NUMERO,COMPRA_PRODUCTO_CANTIDAD,COMPRA_PRODUCTO_PRECIO,PRODUCTO_VARIANTE_CODIGO
END

GO

CREATE PROCEDURE insertar_venta_producto
AS
BEGIN
	INSERT INTO VENTA_PRODUCTO (cod_venta,cod_producto_variante,cantidad,precio_unit,precio_total)
	SELECT VENTA_CODIGO,PRODUCTO_VARIANTE_CODIGO,VENTA_PRODUCTO_CANTIDAD,VENTA_PRODUCTO_PRECIO,SUM(VENTA_PRODUCTO_CANTIDAD*VENTA_PRODUCTO_PRECIO) PRECIO_TOTAL
	FROM gd_esquema.Maestra
	WHERE VENTA_CODIGO IS NOT NULL AND PRODUCTO_VARIANTE_CODIGO IS NOT NULL
	GROUP BY VENTA_CODIGO,PRODUCTO_VARIANTE_CODIGO,VENTA_PRODUCTO_CANTIDAD,VENTA_PRODUCTO_PRECIO
END

GO

CREATE PROCEDURE insertar_ventas
AS
BEGIN
  DECLARE @codVenta decimal(19,0), @fecha date, @clienteDni decimal(19,0), @canalVenta decimal(19,0), @medioEnvio decimal(19,0), 
  @codigoPostal decimal(19,0),@medioPago decimal(19,0), @totalVenta decimal(18,2), @precioEnvio decimal(18,2),@cuponCod nvarchar(255),
  @cuponImporte decimal(18,2),@descuentoConcepto nvarchar(255),@descuentoValor decimal(18,2)
  DECLARE cursorc CURSOR FOR
  SELECT DISTINCT VENTA_CODIGO, VENTA_FECHA, CLIENTE_DNI, VENTA_CANAL, VENTA_MEDIO_ENVIO, VENTA_MEDIO_PAGO, VENTA_TOTAL, 
  VENTA_ENVIO_PRECIO,VENTA_CUPON_CODIGO,VENTA_CUPON_IMPORTE,VENTA_DESCUENTO_CONCEPTO,VENTA_DESCUENTO_IMPORTE
  FROM gd_esquema.Maestra WHERE VENTA_CODIGO IS NOT NULL
  OPEN cursorc
  FETCH cursorc INTO @codVenta, @fecha, @clienteDni, @canalVenta, @medioEnvio, @medioPago, @totalVenta, @precioEnvio,@cuponCod,
  @cuponImporte,@descuentoConcepto,@descuentoValor
  WHILE(@@FETCH_STATUS = 0)
  BEGIN

    INSERT INTO venta (COD_VENTA, FECHA_VENTA, ID_CLIENTE , ID_CANAL_VENTA ,ID_MEDIO_ENVIO, ID_MEDIO_PAGO, TOTAL_VENTA, PRECIO_ENVIO)
    VALUES (@codVenta, @fecha, (SELECT ID_CLIENTE FROM CLIENTE WHERE DNI_CLIENTE=@clienteDni), 
            (SELECT ID_CANAL_VENTA FROM CANAL_VENTA WHERE CANAL_VENTA=@canalVenta), 
            (SELECT ID_MEDIO_ENVIO FROM MEDIO_ENVIO_X_CODIGO_POSTAL WHERE MEDIO=@medioEnvio), (SELECT ID_MEDIO_PAGO FROM MEDIO_DE_PAGO WHERE MEDIO_PAGO=@medioPago), 
            @totalVenta, 
            @precioEnvio)

    IF @cuponCod IS NOT NULL
    BEGIN
      INSERT INTO VENTA_MEDIANTE_CUPON (cod_venta, codigo_cupon, importe)
      VALUES (@codVenta, @cuponCod, @cuponImporte)
    END
    IF @descuentoConcepto = 'Otros'
    BEGIN
      INSERT INTO VENTA_MEDIANTE_DESCUENTO_FIJO (cod_venta, codigo_descuento, importe)
      VALUES (@codVenta, (SELECT CODIGO_DESCUENTO FROM DESCUENTO_FIJO WHERE @descuentoValor=VALOR_DESC), @descuentoValor) 
    END
    FETCH cursorc INTO @codVenta, @fecha, @clienteDni, @canalVenta, @medioEnvio, @medioPago, @totalVenta, @precioEnvio,@cuponCod,
    @cuponImporte,@descuentoConcepto,@descuentoValor
	END
	CLOSE cursorc
	DEALLOCATE cursorc
END

GO

exec insertar_proveedor 
exec insertar_productos
exec insertar_canales_venta
exec insertar_variantes
exec insertar_clientes
exec insertar_descuentos_compra
exec insertar_medio_envio_x_codigo_postal
exec insertar_descuentos_cupon
exec insertar_descuentos_fijo
exec insertar_compras
exec insertar_medios_de_pago
exec insertar_descuentos_x_medio_de_pago
exec insertar_producto_variante
exec insertar_compra_producto
exec insertar_venta_producto
exec insertar_ventas
