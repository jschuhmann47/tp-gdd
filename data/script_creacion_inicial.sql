--USE [GD2C2022]
--GO

--create schema gd_esquema


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

--delete from [gd_esquema].[PROVINCIA]
--delete from [gd_esquema].[CLIENTE]
--delete from [gd_esquema].[CODIGO_POSTAL]



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

--delete from [gd_esquema].[PROVEEDOR]

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

--delete from [gd_esquema].[CLIENTE]
--delete from [gd_esquema].[CODIGO_POSTAL]


CREATE TABLE [gd_esquema].[DESCUENTO_COMPRA] (
  [CODIGO_DESC_COMPRA] decimal(19,0),
  [MONTO_DESC_COMPRA] decimal(19,0),
  PRIMARY KEY ([CODIGO_DESC_COMPRA])
);
-----------------------------------------------------------------------------------------------------------
--DROP TABLE [gd_esquema].[DESCUENTO_COMPRA]

CREATE TABLE [gd_esquema].[DESCUENTO_MEDIO_PAGO] (
  [CODIGO_DESC_MP] DECIMAL(19,0) IDENTITY (1,1),
  [PORCENTAJE_DESCUENTO] decimal(18,2),
  PRIMARY KEY ([CODIGO_DESC_MP])
);


CREATE TABLE [gd_esquema].[PRODUCTO] (
  [COD_PROD] nvarchar(50),
  [NOMBRE_PROD] nvarchar(50),
  [DESCRIPCION_PROD] nvarchar(50),
  [ID_MARCA_PROD] decimal(19,0),
  [ID_CATEGORIA_PROD] decimal(19,0),
  [ID_MATERIAL_PROD] decimal(19,0),
  PRIMARY KEY ([COD_PROD])
);

CREATE TABLE [gd_esquema].[MARCA] (
  [ID_MARCA] decimal(19,0) IDENTITY (1,1),
  [MARCA] nvarchar(255),
  PRIMARY KEY ([ID_MARCA])
);

CREATE TABLE [gd_esquema].[CATEGORIA] (
  [ID_CATEGORIA] decimal(19,0) IDENTITY (1,1),
  [CATEGORIA] nvarchar(255),
  PRIMARY KEY ([ID_CATEGORIA])
);

CREATE TABLE [gd_esquema].[MATERIAL] (
  [ID_MATERIAL] decimal(19,0) IDENTITY (1,1),
  [MATERIAL] nvarchar(50),
  PRIMARY KEY ([ID_MATERIAL])
);

CREATE TABLE [gd_esquema].[VARIANTE] (
  [CODIGO_VAR] nvarchar(50),
  [CODIGO_TIPO_VAR] nvarchar(50),
  [VALOR] nvarchar(50),
  PRIMARY KEY ([CODIGO_VAR])
);
--delete from [gd_esquema].[VARIANTE]
CREATE TABLE [gd_esquema].[TIPO_VARIANTE] (
  [CODIGO_TIPO_VAR] nvarchar(50),
  [DESCRIPCION_TIPO_VAR] nvarchar(50),
  PRIMARY KEY ([CODIGO_TIPO_VAR])
);

--delete from [gd_esquema].[TIPO_VARIANTE]

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

--delete from [gd_esquema].[CODIGO_POSTAL]


CREATE TABLE [gd_esquema].[DESCUENTO_X_COMPRA] (
  [COD_COMPRA] decimal(19,0),
  [CODIGO_DESC_COMPRA] decimal(19,0),
  PRIMARY KEY ([COD_COMPRA], [CODIGO_DESC_COMPRA])
);

------------------------------------------------------------------------------------------------------------

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

ALTER TABLE [gd_esquema].[COMPRA] ADD CONSTRAINT [FK_COMPRA.ID_MEDIO_PAGO] FOREIGN KEY ([ID_MEDIO_PAGO]) REFERENCES [gd_esquema].[MEDIO_DE_PAGO]([ID_MEDIO_PAGO])
ALTER TABLE [gd_esquema].[COMPRA] ADD  CONSTRAINT [FK_COMPRA.CUIT_PROV] FOREIGN KEY ([CUIT_PROV]) REFERENCES [gd_esquema].[PROVEEDOR]([CUIT_PROV])

ALTER TABLE [gd_esquema].VENTA_MEDIANTE_CUPON ADD CONSTRAINT [FK_VENTA_MEDIANTE_CUPON.CODIGO_CUPON] FOREIGN KEY ([CODIGO_CUPON]) REFERENCES [gd_esquema].[DESCUENTO_CUPON]([CODIGO_CUPON])
ALTER TABLE [gd_esquema].VENTA_MEDIANTE_CUPON ADD CONSTRAINT [FK_VENTA_MEDIANTE_CUPON.COD_VENTA] FOREIGN KEY ([COD_VENTA]) REFERENCES [gd_esquema].[VENTA]([COD_VENTA])

ALTER TABLE [gd_esquema].PROVEEDOR ADD CONSTRAINT[FK_PROVEEDOR.CODIGO_POSTAL] FOREIGN KEY ([CODIGO_POSTAL]) REFERENCES [gd_esquema].[CODIGO_POSTAL]([CODIGO_POSTAL])
ALTER TABLE [gd_esquema].PROVEEDOR ADD CONSTRAINT[FK_PROVEEDOR.CODIGO_PROVINCIA] FOREIGN KEY ([CODIGO_PROVINCIA]) REFERENCES [gd_esquema].[PROVINCIA]([CODIGO_PROVINCIA])

ALTER TABLE [gd_esquema].CLIENTE ADD CONSTRAINT [FK_CLIENTE.CODIGO_POSTAL] FOREIGN KEY ([CODIGO_POSTAL]) REFERENCES [gd_esquema].[CODIGO_POSTAL]([CODIGO_POSTAL])
ALTER TABLE [gd_esquema].CLIENTE ADD CONSTRAINT [FK_CLIENTE.CODIGO_PROVINCIA] FOREIGN KEY ([CODIGO_PROVINCIA]) REFERENCES [gd_esquema].[PROVINCIA]([CODIGO_PROVINCIA]) 

ALTER TABLE [gd_esquema].VARIANTE ADD CONSTRAINT [FK_MEDIO_DE_PAGO.CODIGO_TIPO_VAR] FOREIGN KEY ([CODIGO_TIPO_VAR]) REFERENCES [gd_esquema].[TIPO_VARIANTE]([CODIGO_TIPO_VAR])

ALTER TABLE [gd_esquema].VENTA_MEDIANTE_DESCUENTO_FIJO ADD CONSTRAINT [FK_VENTA_MEDIANTE_DESCUENTO_FIJO.COD_VENTA] FOREIGN KEY ([COD_VENTA]) REFERENCES [gd_esquema].[VENTA]([COD_VENTA])
ALTER TABLE [gd_esquema].VENTA_MEDIANTE_DESCUENTO_FIJO ADD CONSTRAINT [FK_VENTA_MEDIANTE_DESCUENTO_FIJO.CODIGO_DESCUENTO] FOREIGN KEY ([CODIGO_DESCUENTO]) REFERENCES [gd_esquema].[DESCUENTO_FIJO]([CODIGO_DESCUENTO])

--ALTER TABLE [gd_esquema].DESCUENTO_CUPON ADD CONSTRAINT [COD_VENTA] FOREIGN KEY ([COD_VENTA]) REFERENCES [VENTA_MEDIANTE_CUPON]([COD_VENTA])



ALTER TABLE [gd_esquema].VENTA_PRODUCTO ADD CONSTRAINT [COD_PRODUCTO_VARIANTE] FOREIGN KEY ([COD_PRODUCTO_VARIANTE]) REFERENCES [gd_esquema].[PRODUCTO_VARIANTE]([COD_PRODUCTO_VARIANTE])
ALTER TABLE [gd_esquema].VENTA_PRODUCTO ADD  CONSTRAINT [FK_VENTA_PRODUCTO.CODIGO_VENTA] FOREIGN KEY ([COD_VENTA]) REFERENCES [gd_esquema].[VENTA]([COD_VENTA])

ALTER TABLE [gd_esquema].PRODUCTO_VARIANTE ADD CONSTRAINT [FK_PRODUCTO_VARIANTE.CODIGO_VAR] FOREIGN KEY ([CODIGO_VAR]) REFERENCES [gd_esquema].[VARIANTE]([CODIGO_VAR])
ALTER TABLE [gd_esquema].PRODUCTO_VARIANTE ADD CONSTRAINT [FK_PRODUCTO_VARIANTE.COD_PROD] FOREIGN KEY ([COD_PROD]) REFERENCES [gd_esquema].[PRODUCTO]([COD_PROD])

ALTER TABLE [gd_esquema].COMPRA_PRODUCTO ADD CONSTRAINT [FK_COMPRA_PRODUCTO.COD_COMPRA] FOREIGN KEY ([COD_COMPRA]) REFERENCES [gd_esquema].[COMPRA]([COD_COMPRA])
ALTER TABLE [gd_esquema].COMPRA_PRODUCTO ADD CONSTRAINT [FK_COMPRA_PRODUCTO.COD_PRODUCTO_VARIANTE] FOREIGN KEY ([COD_PRODUCTO_VARIANTE]) REFERENCES [gd_esquema].[PRODUCTO_VARIANTE]([COD_PRODUCTO_VARIANTE])

ALTER TABLE [gd_esquema].CODIGO_POSTAL ADD CONSTRAINT [FK_CODIGO_POSTAL.CODIGO_POSTAL] FOREIGN KEY ([CODIGO_PROVINCIA]) REFERENCES [gd_esquema].[PROVINCIA]([CODIGO_PROVINCIA])

ALTER TABLE [gd_esquema].DESCUENTO_X_COMPRA ADD CONSTRAINT [FK_DESCUENTO_X_COMPRA.COD_COMPRA] FOREIGN KEY ([COD_COMPRA]) REFERENCES [gd_esquema].[COMPRA]([COD_COMPRA])
ALTER TABLE [gd_esquema].DESCUENTO_X_COMPRA ADD CONSTRAINT [FK_DESCUENTO_X_COMPRA.CODIGO_DESC_COMPRA] FOREIGN KEY ([CODIGO_DESC_COMPRA]) REFERENCES [gd_esquema].[DESCUENTO_COMPRA]([CODIGO_DESC_COMPRA])

ALTER TABLE [gd_esquema].DESCUENTO_X_MEDIO_DE_PAGO ADD CONSTRAINT [FK_DESCUENTO_X_MEDIO_DE_PAGO.CODIGO_DESC_MP] FOREIGN KEY ([CODIGO_DESC_MP]) REFERENCES [gd_esquema].[DESCUENTO_MEDIO_PAGO]([CODIGO_DESC_MP])
ALTER TABLE [gd_esquema].DESCUENTO_X_MEDIO_DE_PAGO ADD CONSTRAINT [FK_DESCUENTO_X_MEDIO_DE_PAGO.ID_MEDIO_PAGO] FOREIGN KEY ([ID_MEDIO_PAGO]) REFERENCES [gd_esquema].[MEDIO_DE_PAGO]([ID_MEDIO_PAGO])

ALTER TABLE [gd_esquema].MEDIO_ENVIO_X_CODIGO_POSTAL ADD CONSTRAINT [FK_MEDIO_ENVIO_X_CODIGO_POSTAL.CODIGO_POSTAL] FOREIGN KEY ([CODIGO_POSTAL]) REFERENCES [gd_esquema].[CODIGO_POSTAL]([CODIGO_POSTAL])

ALTER TABLE [gd_esquema].VENTA ADD CONSTRAINT [FK_VENTA.ID_MEDIO_PAGO] FOREIGN KEY ([ID_MEDIO_PAGO]) REFERENCES [gd_esquema].[MEDIO_DE_PAGO]([ID_MEDIO_PAGO])
------
ALTER TABLE [gd_esquema].VENTA ADD CONSTRAINT [FK_VENTA.ID_MEDIO_ENVIO] FOREIGN KEY ([ID_MEDIO_ENVIO]) REFERENCES [gd_esquema].[MEDIO_ENVIO_X_CODIGO_POSTAL]([ID_MEDIO_ENVIO])
------
ALTER TABLE [gd_esquema].VENTA ADD CONSTRAINT [FK_VENTA.ID_CANAL_VENTA] FOREIGN KEY ([ID_CANAL_VENTA]) REFERENCES [gd_esquema].[CANAL_VENTA]([ID_CANAL_VENTA])
ALTER TABLE [gd_esquema].VENTA ADD CONSTRAINT [FK_VENTA.ID_CLIENTE] FOREIGN KEY ([ID_CLIENTE]) REFERENCES [gd_esquema].[CLIENTE]([ID_CLIENTE])

--CHEQUEAR:
ALTER TABLE [gd_esquema].PRODUCTO ADD CONSTRAINT [FK_PRODUCTO.ID_MARCA] FOREIGN KEY ([ID_MARCA_PROD]) REFERENCES [gd_esquema].[MARCA]([ID_MARCA])
ALTER TABLE [gd_esquema].PRODUCTO ADD CONSTRAINT [FK_PRODUCTO.ID_CATEGORIA] FOREIGN KEY ([ID_CATEGORIA_PROD]) REFERENCES [gd_esquema].[CATEGORIA]([ID_CATEGORIA])
ALTER TABLE [gd_esquema].PRODUCTO ADD CONSTRAINT [FK_PRODUCTO.ID_MATERIAL] FOREIGN KEY ([ID_MATERIAL_PROD]) REFERENCES [gd_esquema].[MATERIAL]([ID_MATERIAL])

GO


CREATE PROCEDURE [gd_esquema].insertar_proveedor
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

	 IF NOT EXISTS (SELECT 1 FROM gd_esquema.CODIGO_POSTAL WHERE CODIGO_POSTAL = @codPostal)
					  BEGIN
							  IF NOT EXISTS (SELECT 1 FROM gd_esquema.PROVINCIA WHERE NOMBRE_PROV = @provincia)
								BEGIN
										INSERT INTO gd_esquema.PROVINCIA (NOMBRE_PROV)
										VALUES (@provincia)
								END	
						INSERT INTO gd_esquema.CODIGO_POSTAL  ( CODIGO_POSTAL ,CODIGO_PROVINCIA) values ( @codPostal , ( SELECT CODIGO_PROVINCIA FROM gd_esquema.PROVINCIA WHERE NOMBRE_PROV = @provincia ) )
					  END
		SELECT @codProvincia = CODIGO_PROVINCIA FROM gd_esquema.PROVINCIA WHERE NOMBRE_PROV = @provincia 
		INSERT INTO gd_esquema.PROVEEDOR (CUIT_PROV,RAZON_SOCIAL_PROV,DOMICILIO_PROV,MAIL_PROV,LOCALIDAD_PROV,CODIGO_POSTAL,CODIGO_PROVINCIA)
		VALUES (@cuit,@razonSocial,@domicilio,@mail,@localidad,@codPostal,@codProvincia)
		FETCH NEXT FROM	cursorc INTO @cuit,@domicilio,@codPostal,@razonSocial,@mail,@provincia,@localidad
	END
	CLOSE cursorc
	DEALLOCATE cursorc
END




--exec insertar_proveedor 
--DROP  PROCEDURE insertar_proveedor

GO

CREATE PROCEDURE [gd_esquema].insertar_marca_categoria_y_material
AS
BEGIN
  INSERT INTO gd_esquema.MARCA (MARCA)
  SELECT DISTINCT PRODUCTO_MARCA FROM gd_esquema.Maestra WHERE PRODUCTO_MARCA IS NOT NULL

  INSERT INTO gd_esquema.CATEGORIA (CATEGORIA)
  SELECT DISTINCT PRODUCTO_MARCA FROM gd_esquema.Maestra WHERE PRODUCTO_MARCA IS NOT NULL

  INSERT INTO gd_esquema.MATERIAL (MATERIAL)
  SELECT DISTINCT PRODUCTO_MARCA FROM gd_esquema.Maestra WHERE PRODUCTO_MARCA IS NOT NULL
END

GO

CREATE PROCEDURE [gd_esquema].insertar_productos
AS
BEGIN
  DECLARE @prodCodigo nvarchar(50),@prodNombre nvarchar(50), @prodDesc nvarchar(50), @marca nvarchar(255),@categoria nvarchar(255), @material nvarchar(50)
  DECLARE cursord CURSOR FOR SELECT DISTINCT PRODUCTO_CODIGO,PRODUCTO_NOMBRE,PRODUCTO_DESCRIPCION,PRODUCTO_MARCA,PRODUCTO_CATEGORIA,PRODUCTO_MATERIAL 
      FROM gd_esquema.Maestra
      WHERE PRODUCTO_CODIGO IS NOT NULL
  OPEN cursord
	FETCH NEXT FROM cursord INTO @prodCodigo,@prodNombre,@prodDesc,@marca,@categoria,@material
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
    INSERT INTO gd_esquema.PRODUCTO (COD_PROD,NOMBRE_PROD,DESCRIPCION_PROD,ID_MARCA_PROD,ID_CATEGORIA_PROD,ID_MATERIAL_PROD)
    VALUES (@prodCodigo,@prodNombre,@prodDesc,(SELECT ID_MARCA FROM gd_esquema.MARCA WHERE MARCA=@marca),(SELECT ID_CATEGORIA FROM gd_esquema.CATEGORIA WHERE CATEGORIA=@categoria),(SELECT ID_MATERIAL FROM gd_esquema.MATERIAL WHERE MATERIAL=@material))
    FETCH NEXT FROM cursord INTO @prodCodigo,@prodNombre,@prodDesc,@marca,@categoria,@material
  END
  CLOSE cursord
  DEALLOCATE cursord
END

GO

CREATE PROCEDURE [gd_esquema].insertar_canales_venta
AS
BEGIN
	INSERT INTO gd_esquema.CANAL_VENTA (CANAL_VENTA,CANAL_COSTO)
	SELECT DISTINCT VENTA_CANAL,VENTA_CANAL_COSTO 
	FROM gd_esquema.Maestra
	WHERE VENTA_CANAL IS NOT NULL
END


GO

CREATE PROCEDURE [gd_esquema].insertar_variantes
AS
BEGIN
	DECLARE @variante nvarchar(50),@tipo nvarchar(50),@codigo nvarchar(50)
	DECLARE cursorce CURSOR FOR SELECT DISTINCT PRODUCTO_VARIANTE,PRODUCTO_TIPO_VARIANTE,PRODUCTO_VARIANTE_CODIGO 
								FROM gd_esquema.Maestra
								WHERE PRODUCTO_VARIANTE_CODIGO IS NOT NULL
	OPEN cursorce
	FETCH NEXT FROM cursorce INTO @variante,@tipo,@codigo
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		INSERT INTO gd_esquema.TIPO_VARIANTE (CODIGO_TIPO_VAR,DESCRIPCION_TIPO_VAR)
		VALUES (@codigo,@tipo)
		INSERT INTO gd_esquema.VARIANTE (CODIGO_VAR,CODIGO_TIPO_VAR,VALOR) VALUES (@codigo,
		(SELECT TOP 1 CODIGO_TIPO_VAR FROM gd_esquema.TIPO_VARIANTE WHERE DESCRIPCION_TIPO_VAR = @tipo) ,@variante)
		FETCH NEXT FROM cursorce INTO @variante,@tipo,@codigo
	END
	CLOSE cursorce
	DEALLOCATE cursorce
END

--DROP  PROCEDURE insertar_variantes


GO

CREATE PROCEDURE [gd_esquema].insertar_clientes
AS
BEGIN
	DECLARE @nombre nvarchar(255),@apellido nvarchar(255),@dni decimal(18,0),@direccion nvarchar(255),@telefono decimal(18,0),@mail nvarchar(255),@fechaNacimiento date,@localidad nvarchar(255),@codPostal decimal(19,0),@provincia nvarchar(255)
	DECLARE cursorx CURSOR FOR 
		(SELECT DISTINCT CLIENTE_NOMBRE,CLIENTE_APELLIDO,CLIENTE_DNI,CLIENTE_DIRECCION,CLIENTE_TELEFONO,
		CLIENTE_MAIL, CLIENTE_FECHA_NAC,CLIENTE_LOCALIDAD, CLIENTE_CODIGO_POSTAL, CLIENTE_PROVINCIA  
		FROM gd_esquema.Maestra
		WHERE CLIENTE_DNI IS NOT NULL)
	OPEN cursorx
	FETCH NEXT FROM cursorx INTO @nombre,@apellido,@dni,@direccion,@telefono,@mail,@fechaNacimiento,@localidad,@codPostal,@provincia
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		DECLARE @codProvincia decimal(19,0)
		IF NOT EXISTS (SELECT 1 FROM gd_esquema.CODIGO_POSTAL WHERE CODIGO_POSTAL = @codPostal) --codigo_postal nuestra tabla
		BEGIN

		IF NOT EXISTS (SELECT 1 FROM gd_esquema.PROVINCIA WHERE NOMBRE_PROV = @provincia)
								BEGIN
										INSERT INTO gd_esquema.PROVINCIA (NOMBRE_PROV)
										VALUES (@provincia)
								END	

			INSERT INTO gd_esquema.CODIGO_POSTAL (CODIGO_POSTAL, CODIGO_PROVINCIA)
			values (@codPostal,(SELECT DISTINCT CODIGO_PROVINCIA FROM gd_esquema.PROVINCIA WHERE NOMBRE_PROV = @provincia)) --distinct?
		END
		SELECT @codProvincia = CODIGO_PROVINCIA from gd_esquema.PROVINCIA WHERE NOMBRE_PROV = @provincia
		INSERT INTO gd_esquema.CLIENTE (NOMBRE_CLIENTE,APELLIDO_CLIENTE,DNI_CLIENTE,DIRECCION_CLIENTE,TELEFONO_CLIENTE,MAIL_CLIENTE,FECHA_NAC_CLIENTE,LOCALIDAD_CLIENTE,CODIGO_POSTAL,CODIGO_PROVINCIA)
		VALUES (@nombre,@apellido,@dni,@direccion,@telefono,@mail,@fechaNacimiento,@localidad,@codPostal,@codProvincia)
		FETCH NEXT FROM cursorx INTO @nombre,@apellido,@dni,@direccion,@telefono,@mail,@fechaNacimiento,@localidad,@codPostal,@provincia
	END
	CLOSE cursorx
	DEALLOCATE cursorx
END

--DROP  PROCEDURE insertar_clientes

--SELECT * FROM gd_esquema.PROVINCIA

GO

CREATE PROCEDURE [gd_esquema].insertar_descuentos_compra
AS
BEGIN
	INSERT INTO gd_esquema.DESCUENTO_COMPRA (CODIGO_DESC_COMPRA,MONTO_DESC_COMPRA)
	SELECT DISTINCT DESCUENTO_COMPRA_CODIGO,DESCUENTO_COMPRA_VALOR 
	FROM gd_esquema.Maestra WHERE DESCUENTO_COMPRA_CODIGO IS NOT NULL
END

GO

CREATE PROCEDURE [gd_esquema].insertar_medio_envio_x_codigo_postal
AS
BEGIN
	INSERT INTO gd_esquema.MEDIO_ENVIO_X_CODIGO_POSTAL (CODIGO_POSTAL,TIEMPO_EST,PRECIO,MEDIO)
	SELECT DISTINCT CLIENTE_CODIGO_POSTAL,NULL,VENTA_ENVIO_PRECIO,VENTA_MEDIO_ENVIO
	FROM gd_esquema.Maestra
	WHERE VENTA_MEDIO_ENVIO IS NOT NULL
END

GO

CREATE PROCEDURE [gd_esquema].insertar_descuentos_cupon
AS
BEGIN
	INSERT INTO gd_esquema.DESCUENTO_CUPON (CODIGO_CUPON,VALOR_DESC,FECHA_DESDE,FECHA_HASTA)
	SELECT DISTINCT VENTA_CUPON_CODIGO,VENTA_CUPON_VALOR,VENTA_CUPON_FECHA_DESDE,VENTA_CUPON_FECHA_HASTA 
	FROM gd_esquema.Maestra WHERE VENTA_CUPON_CODIGO IS NOT NULL
END

GO

CREATE PROCEDURE [gd_esquema].insertar_descuentos_fijo
AS
BEGIN
  INSERT INTO gd_esquema.DESCUENTO_FIJO (TIPO_DESC,VALOR_DESC)
  SELECT DISTINCT VENTA_DESCUENTO_CONCEPTO,VENTA_DESCUENTO_IMPORTE
  FROM gd_esquema.Maestra
  WHERE VENTA_DESCUENTO_CONCEPTO IS NOT NULL AND VENTA_DESCUENTO_CONCEPTO = 'Otros'
END

GO

CREATE PROCEDURE [gd_esquema].insertar_compras
AS
BEGIN
	DECLARE @codCompra decimal(19,0),@fecha date,@medioPago nvarchar(255),@totalCompra decimal(18,2),@cuit nvarchar(50)--,@codDescuentoCompra decimal(19,0),@prodVarianteCod nvarchar(50)
	DECLARE cursorw CURSOR FOR 
	SELECT DISTINCT COMPRA_NUMERO,COMPRA_FECHA,COMPRA_MEDIO_PAGO,COMPRA_TOTAL,PROVEEDOR_CUIT
	FROM gd_esquema.Maestra WHERE COMPRA_NUMERO IS NOT NULL
	OPEN cursorw
	FETCH cursorw INTO @codCompra,@fecha,@medioPago,@totalCompra,@cuit--,@codDescuentoCompra,@prodVarianteCod
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
			
		INSERT INTO gd_esquema.COMPRA (COD_COMPRA,FECHA_COMPRA,ID_MEDIO_PAGO, TOTAL_COMPRA,CUIT_PROV)
		VALUES (@codCompra,@fecha,(SELECT ID_MEDIO_PAGO FROM gd_esquema.MEDIO_DE_PAGO WHERE MEDIO_PAGO=@medioPago AND VALOR_DESC=0),@totalCompra,@cuit)
		/*
		IF  @codDescuentoCompra IS NOT NULL
			begin
				INSERT INTO gd_esquema.DESCUENTO_X_COMPRA (COD_COMPRA,CODIGO_DESC_COMPRA)
				VALUES (@codCompra,@codDescuentoCompra)
			end
		*/
		FETCH cursorw INTO @codCompra,@fecha,@medioPago,@totalCompra,@cuit--,@codDescuentoCompra,@prodVarianteCod
	END
	CLOSE cursorw
	DEALLOCATE cursorw
END
--DROP  PROCEDURE insertar_compras

go

CREATE PROCEDURE [gd_esquema].insertar_medios_de_pago
AS
BEGIN
	INSERT INTO gd_esquema.MEDIO_DE_PAGO (MEDIO_PAGO,VALOR_DESC,COSTO_TRANSACCION)
	SELECT DISTINCT VENTA_MEDIO_PAGO,VENTA_DESCUENTO_IMPORTE,VENTA_MEDIO_PAGO_COSTO
	FROM gd_esquema.Maestra
	WHERE VENTA_MEDIO_PAGO IS NOT NULL AND VENTA_DESCUENTO_CONCEPTO!='Otros'

	INSERT INTO gd_esquema.MEDIO_DE_PAGO (MEDIO_PAGO,VALOR_DESC,COSTO_TRANSACCION)
	SELECT DISTINCT VENTA_MEDIO_PAGO,0,VENTA_MEDIO_PAGO_COSTO
	FROM gd_esquema.Maestra
	WHERE VENTA_MEDIO_PAGO IS NOT NULL AND VENTA_DESCUENTO_CONCEPTO!='Otros'

END

GO

CREATE PROCEDURE [gd_esquema].insertar_descuentos_x_medio_de_pago
AS
BEGIN
  DECLARE @medioPago nvarchar(255),@porcDescuento decimal(18,2),@importe decimal(18,2),@concepto nvarchar(255)
  DECLARE cursorm CURSOR FOR
  SELECT DISTINCT VENTA_MEDIO_PAGO, VENTA_DESCUENTO_IMPORTE/VENTA_TOTAL PORCENTAJE_DESCUENTO,VENTA_DESCUENTO_IMPORTE,VENTA_DESCUENTO_CONCEPTO
  FROM gd_esquema.Maestra
  WHERE VENTA_MEDIO_PAGO IS NOT NULL AND VENTA_DESCUENTO_IMPORTE IS NOT NULL AND VENTA_DESCUENTO_CONCEPTO!='Otros'
  UNION
  SELECT 'Tarjeta',0,0,'Tarjeta'
  OPEN cursorm
  FETCH cursorm INTO @medioPago,@porcDescuento,@importe,@concepto
  WHILE (@@FETCH_STATUS = 0)
  BEGIN
		IF NOT EXISTS (SELECT 1 FROM gd_esquema.DESCUENTO_MEDIO_PAGO WHERE PORCENTAJE_DESCUENTO=@porcDescuento)
		BEGIN
			INSERT INTO gd_esquema.DESCUENTO_MEDIO_PAGO (PORCENTAJE_DESCUENTO)
			VALUES (@porcDescuento)
		END
		INSERT INTO gd_esquema.DESCUENTO_X_MEDIO_DE_PAGO (ID_MEDIO_PAGO,CODIGO_DESC_MP)
		VALUES (
			(SELECT DISTINCT ID_MEDIO_PAGO FROM gd_esquema.MEDIO_DE_PAGO WHERE MEDIO_PAGO=@medioPago AND VALOR_DESC=@importe),
			(SELECT DISTINCT CODIGO_DESC_MP FROM gd_esquema.DESCUENTO_MEDIO_PAGO WHERE PORCENTAJE_DESCUENTO=@porcDescuento)
		)
	
	FETCH cursorm INTO @medioPago,@porcDescuento,@importe,@concepto
  END
  CLOSE cursorm
  DEALLOCATE cursorm
END

GO

CREATE FUNCTION id_producto_variante(@variante nvarchar(50),@tipoVariante nvarchar(50))
RETURNS nvarchar(50)
AS
BEGIN
  DECLARE @id nvarchar(50)
  SELECT @id=CODIGO_VAR FROM gd_esquema.VARIANTE
  WHERE VALOR = @VARIANTE AND (SELECT CODIGO_TIPO_VAR FROM gd_esquema.TIPO_VARIANTE WHERE DESCRIPCION_TIPO_VAR = @tipoVariante) = CODIGO_TIPO_VAR
  RETURN @id
END

GO

CREATE PROCEDURE [gd_esquema].insertar_producto_variante
AS
BEGIN
  DECLARE @prodVarianteCod nvarchar(50),@prodCod nvarchar(50),@stock decimal(19,0),@descripcion nvarchar(50),@variante nvarchar(50),@tipoVariante nvarchar(50)
  DECLARE cursorv CURSOR FOR SELECT DISTINCT PRODUCTO_VARIANTE_CODIGO,PRODUCTO_CODIGO,PRODUCTO_TIPO_VARIANTE,PRODUCTO_VARIANTE,PRODUCTO_DESCRIPCION
  FROM gd_esquema.Maestra WHERE PRODUCTO_VARIANTE_CODIGO IS NOT NULL
  OPEN cursorv
  FETCH NEXT FROM cursorv INTO @prodVarianteCod,@prodCod,@variante,@tipoVariante,@descripcion
  WHILE(@@FETCH_STATUS = 0)
  BEGIN
    IF NOT EXISTS (SELECT 1 FROM gd_esquema.PRODUCTO_VARIANTE WHERE CODIGO_VAR = @prodVarianteCod)
    BEGIN
      INSERT INTO gd_esquema.PRODUCTO_VARIANTE (CODIGO_VAR,COD_PROD,COD_PRODUCTO_VARIANTE,STOCK,DESCRIPCION)
      VALUES (dbo.id_producto_variante(@variante,@tipoVariante),@prodCod,@prodVarianteCod,0,@descripcion)
    END
    ELSE
    BEGIN
      UPDATE gd_esquema.PRODUCTO_VARIANTE
      SET STOCK += @stock
      WHERE CODIGO_VAR = @prodVarianteCod
    END
    FETCH NEXT FROM cursorv INTO @prodVarianteCod,@prodCod,@variante,@tipoVariante,@descripcion
  END
  CLOSE cursorv
  DEALLOCATE cursorv
END

GO



CREATE PROCEDURE [gd_esquema].insertar_compra_producto
AS
BEGIN
	
	--Violation of PRIMARY KEY constraint 'PK__COMPRA_P__E31C4D8D94175AED'. Cannot insert duplicate key in object 'gd_esquema.COMPRA_PRODUCTO'. The duplicate key value is (131232, 015HPH1YB6HEBMWAG).
	DECLARE @compraNum decimal(19,0),@prodVarCod nvarchar(50),@cant decimal(18,0),@precio decimal(18,2),@totalProd decimal (18,2)
	DECLARE csd CURSOR FOR
	SELECT COMPRA_NUMERO,PRODUCTO_VARIANTE_CODIGO,COMPRA_PRODUCTO_CANTIDAD,COMPRA_PRODUCTO_PRECIO,SUM(COMPRA_PRODUCTO_CANTIDAD*COMPRA_PRODUCTO_PRECIO) PRECIO_TOTAL_PRODUCTO
	FROM gd_esquema.Maestra
	WHERE COMPRA_NUMERO IS NOT NULL AND PRODUCTO_VARIANTE_CODIGO IS NOT NULL
	GROUP BY COMPRA_NUMERO,COMPRA_PRODUCTO_CANTIDAD,COMPRA_PRODUCTO_PRECIO,PRODUCTO_VARIANTE_CODIGO
	OPEN csd
	FETCH NEXT FROM csd INTO  @compraNum ,@prodVarCod ,@cant,@precio ,@totalProd
	WHILE (@@FETCH_STATUS = 0)
	BEGIN

		IF NOT EXISTS (SELECT 1 FROM gd_esquema.COMPRA_PRODUCTO WHERE COD_COMPRA=@compraNum AND COD_PRODUCTO_VARIANTE=@prodVarCod)
		BEGIN
		INSERT INTO gd_esquema.COMPRA_PRODUCTO (COD_COMPRA,COD_PRODUCTO_VARIANTE,CANTIDAD,PRECIO_UNIT,PRECIO_TOTAL)
		VALUES (@compraNum,@prodVarCod,@cant,@precio,@totalProd)
		END
		ELSE
		BEGIN
			UPDATE gd_esquema.COMPRA_PRODUCTO
			SET CANTIDAD+=@cant --Arithmetic overflow error converting numeric to data type numeric.
			WHERE COD_COMPRA=@compraNum AND COD_PRODUCTO_VARIANTE=@prodVarCod
			UPDATE gd_esquema.COMPRA_PRODUCTO
			SET PRECIO_TOTAL=PRECIO_UNIT*CANTIDAD
			WHERE COD_COMPRA=@compraNum AND COD_PRODUCTO_VARIANTE=@prodVarCod
		END
		FETCH NEXT FROM csd INTO  @compraNum ,@prodVarCod ,@cant,@precio ,@totalProd
	END
	CLOSE csd
	DEALLOCATE csd
END



GO

CREATE PROCEDURE [gd_esquema].insertar_venta_producto
AS
BEGIN
	DECLARE @ventaCod decimal(19,0),@prodVarCod nvarchar(50),@cant decimal(18,0),@precio decimal(18,2),@totalProd decimal(18,2)
	DECLARE xd CURSOR FOR
	SELECT VENTA_CODIGO,PRODUCTO_VARIANTE_CODIGO,VENTA_PRODUCTO_CANTIDAD,VENTA_PRODUCTO_PRECIO,SUM(VENTA_PRODUCTO_CANTIDAD*VENTA_PRODUCTO_PRECIO) PRECIO_TOTAL
	FROM gd_esquema.Maestra
	WHERE VENTA_CODIGO IS NOT NULL AND PRODUCTO_VARIANTE_CODIGO IS NOT NULL
	GROUP BY VENTA_CODIGO,PRODUCTO_VARIANTE_CODIGO,VENTA_PRODUCTO_CANTIDAD,VENTA_PRODUCTO_PRECIO
	OPEN xd
	FETCH NEXT FROM xd INTO  @ventaCod ,@prodVarCod ,@cant ,@precio ,@totalProd
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
	IF NOT EXISTS (SELECT 1 FROM gd_esquema.VENTA_PRODUCTO WHERE COD_VENTA=@ventaCod AND COD_PRODUCTO_VARIANTE=@prodVarCod)
		BEGIN
		INSERT INTO gd_esquema.VENTA_PRODUCTO (COD_VENTA,COD_PRODUCTO_VARIANTE,CANTIDAD,PRECIO_UNIT,PRECIO_TOTAL)
		VALUES (@ventaCod,@prodVarCod,@cant,@precio,@totalProd)
		END
		ELSE
		BEGIN
			UPDATE gd_esquema.VENTA_PRODUCTO
			SET CANTIDAD+=@cant 
			WHERE COD_VENTA=@ventaCod AND COD_PRODUCTO_VARIANTE=@prodVarCod
			UPDATE gd_esquema.VENTA_PRODUCTO
			SET PRECIO_TOTAL=PRECIO_UNIT*CANTIDAD
			WHERE COD_VENTA=@ventaCod AND COD_PRODUCTO_VARIANTE=@prodVarCod
		END
		FETCH NEXT FROM xd INTO  @ventaCod ,@prodVarCod ,@cant ,@precio ,@totalProd
	END
	CLOSE xd
	DEALLOCATE xd
END

GO

CREATE PROCEDURE [gd_esquema].insertar_ventas
AS
BEGIN
  DECLARE @codVenta decimal(19,0), @fecha date, @clienteDni decimal(19,0), @canalVenta nvarchar(255), @medioEnvio nvarchar(255)
  ,@medioPago nvarchar(255), @totalVenta decimal(18,2), @precioEnvio decimal(18,2),@cuponCod nvarchar(255),
  @cuponImporte decimal(18,2),@descuentoConcepto nvarchar(255),@descuentoValor decimal(18,2),@codPostal decimal (19,0), 
  @envioPrecio decimal(18,2),@nombre nvarchar(255),@apellido nvarchar(255),@canalCosto decimal(18,2)
  DECLARE cursorvs CURSOR FOR
  SELECT DISTINCT VENTA_CODIGO, VENTA_FECHA, CLIENTE_DNI, VENTA_CANAL, VENTA_MEDIO_ENVIO, VENTA_MEDIO_PAGO, VENTA_TOTAL, 
  VENTA_ENVIO_PRECIO,VENTA_CUPON_CODIGO,VENTA_CUPON_IMPORTE,VENTA_DESCUENTO_CONCEPTO,VENTA_DESCUENTO_IMPORTE,CLIENTE_CODIGO_POSTAL, VENTA_ENVIO_PRECIO,CLIENTE_NOMBRE,CLIENTE_APELLIDO,VENTA_CANAL_COSTO
  FROM gd_esquema.Maestra WHERE VENTA_CODIGO IS NOT NULL
  OPEN cursorvs
  FETCH cursorvs INTO @codVenta, @fecha, @clienteDni, @canalVenta, @medioEnvio, @medioPago, @totalVenta, @precioEnvio,@cuponCod, --tarjeta no tiene desc
  @cuponImporte,@descuentoConcepto,@descuentoValor,@codPostal,@envioPrecio,@nombre,@apellido,@canalCosto
  WHILE(@@FETCH_STATUS = 0)
  BEGIN
	--hacer ciclo por cada renglon de la misma venta, ver si tiene descuento y/o cupon. lo mismo en compra
	IF NOT EXISTS (SELECT 1 FROM gd_esquema.VENTA WHERE @codVenta=COD_VENTA)
	BEGIN
		IF @descuentoConcepto!='Otros' AND @descuentoConcepto IS NOT NULL AND @descuentoValor IS NOT NULL
		BEGIN
			INSERT INTO gd_esquema.VENTA (COD_VENTA, FECHA_VENTA, ID_CLIENTE , ID_CANAL_VENTA ,ID_MEDIO_ENVIO, ID_MEDIO_PAGO, TOTAL_VENTA, PRECIO_ENVIO, CANAL_COSTO, COSTO_TRANSACCION)
			VALUES (@codVenta, @fecha, (SELECT ID_CLIENTE FROM gd_esquema.CLIENTE WHERE DNI_CLIENTE=@clienteDni AND NOMBRE_CLIENTE=@nombre AND APELLIDO_CLIENTE=@apellido), 
				(SELECT ID_CANAL_VENTA FROM gd_esquema.CANAL_VENTA WHERE CANAL_VENTA=@canalVenta),
				(SELECT ID_MEDIO_ENVIO FROM gd_esquema.MEDIO_ENVIO_X_CODIGO_POSTAL WHERE MEDIO=@medioEnvio AND CODIGO_POSTAL=@codPostal AND PRECIO=@envioPrecio), 
				(SELECT ID_MEDIO_PAGO FROM gd_esquema.MEDIO_DE_PAGO WHERE MEDIO_PAGO=@medioPago AND VALOR_DESC=@descuentoValor), --no lo encuentra
				@totalVenta, 
				@precioEnvio,
				@canalCosto,
				(SELECT COSTO_TRANSACCION FROM gd_esquema.MEDIO_DE_PAGO WHERE MEDIO_PAGO=@medioPago AND VALOR_DESC=@descuentoValor))
		END
		IF @descuentoConcepto='Otros' AND @descuentoConcepto IS NULL OR @descuentoValor IS NULL
		BEGIN
			INSERT INTO gd_esquema.VENTA (COD_VENTA, FECHA_VENTA, ID_CLIENTE , ID_CANAL_VENTA ,ID_MEDIO_ENVIO, ID_MEDIO_PAGO, TOTAL_VENTA, PRECIO_ENVIO, CANAL_COSTO, COSTO_TRANSACCION)
			VALUES (@codVenta, @fecha, (SELECT ID_CLIENTE FROM gd_esquema.CLIENTE WHERE DNI_CLIENTE=@clienteDni AND NOMBRE_CLIENTE=@nombre AND APELLIDO_CLIENTE=@apellido), 
				(SELECT ID_CANAL_VENTA FROM gd_esquema.CANAL_VENTA WHERE CANAL_VENTA=@canalVenta), 
				(SELECT ID_MEDIO_ENVIO FROM gd_esquema.MEDIO_ENVIO_X_CODIGO_POSTAL WHERE MEDIO=@medioEnvio AND CODIGO_POSTAL=@codPostal AND PRECIO=@envioPrecio), 
				(SELECT ID_MEDIO_PAGO FROM gd_esquema.MEDIO_DE_PAGO WHERE MEDIO_PAGO=@medioPago AND VALOR_DESC=0), 
				@totalVenta, 
				@precioEnvio,
				@canalCosto,
				(SELECT COSTO_TRANSACCION FROM gd_esquema.MEDIO_DE_PAGO WHERE MEDIO_PAGO=@medioPago AND VALOR_DESC=@descuentoValor))
			IF @descuentoConcepto IS NOT NULL
			INSERT INTO gd_esquema.VENTA_MEDIANTE_DESCUENTO_FIJO (COD_VENTA, CODIGO_DESCUENTO, IMPORTE)
			VALUES (@codVenta, (SELECT CODIGO_DESCUENTO FROM gd_esquema.DESCUENTO_FIJO WHERE @descuentoValor=VALOR_DESC), @descuentoValor) 
		END
	END

	IF @cuponCod IS NOT NULL
	BEGIN
		INSERT INTO gd_esquema.VENTA_MEDIANTE_CUPON (COD_VENTA, CODIGO_CUPON, IMPORTE)
		VALUES (@codVenta, @cuponCod, @cuponImporte)
	END
	FETCH cursorvs INTO @codVenta, @fecha, @clienteDni, @canalVenta, @medioEnvio, @medioPago, @totalVenta, @precioEnvio,@cuponCod,
	@cuponImporte,@descuentoConcepto,@descuentoValor,@codPostal,@envioPrecio,@nombre,@apellido,@canalCosto
  END
  CLOSE cursorvs
  DEALLOCATE cursorvs
END

GO

CREATE PROCEDURE [gd_esquema].insertar_todo
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION
		exec [gd_esquema].insertar_proveedor
		exec [gd_esquema].insertar_marca_categoria_y_material
		exec [gd_esquema].insertar_productos
		exec [gd_esquema].insertar_canales_venta
		exec [gd_esquema].insertar_variantes
		exec [gd_esquema].insertar_clientes
		
		exec [gd_esquema].insertar_medio_envio_x_codigo_postal
		exec [gd_esquema].insertar_descuentos_cupon
		exec [gd_esquema].insertar_descuentos_fijo
		exec [gd_esquema].insertar_medios_de_pago 
		exec [gd_esquema].insertar_descuentos_compra
		exec [gd_esquema].insertar_descuentos_x_medio_de_pago 
		exec [gd_esquema].insertar_producto_variante
		
		exec [gd_esquema].insertar_compras 
		exec [gd_esquema].insertar_compra_producto
		
		exec [gd_esquema].insertar_ventas 
		exec [gd_esquema].insertar_venta_producto
		
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH 
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage

            ROLLBACK TRANSACTION
    END CATCH
	
END

GO

--drop procedure insertar_todo

exec [gd_esquema].insertar_todo




--DROP PROCEDURE insertar_proveedor 
--DROP PROCEDURE insertar_productos
--DROP PROCEDURE insertar_canales_venta
--DROP PROCEDURE insertar_variantes
--DROP PROCEDURE insertar_clientes
--DROP PROCEDURE insertar_descuentos_compra
--DROP PROCEDURE insertar_medio_envio_x_codigo_postal
--DROP PROCEDURE insertar_descuentos_cupon
--DROP PROCEDURE insertar_descuentos_fijo

--DROP PROCEDURE insertar_compras 

--DROP PROCEDURE insertar_medios_de_pago 
--DROP PROCEDURE insertar_descuentos_x_medio_de_pago
--DROP PROCEDURE insertar_producto_variante 
--DROP PROCEDURE insertar_compra_producto
--DROP PROCEDURE insertar_venta_producto 
--DROP PROCEDURE insertar_ventas 
--DROP PROCEDURE insertar_marca_categoria_y_material
--DROP PROCEDURE insertar_todo 

