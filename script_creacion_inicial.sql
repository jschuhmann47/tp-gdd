
CREATE TABLE [COMPRA] (
  [COD_COMPRA] decimal(19,0),
  [FECHA_COMPRA] date,
  [ID_MEDIO_PAGO] decimal(19,0),
  [TOTAL_COMPRA] decimal(18,2),
  [CUIT_PROV] nvarchar(50),
  [CODIGO_DESC_COMPRA] decimal(19,0),
  PRIMARY KEY ([COD_COMPRA]),

  CONSTRAINT [FK_COMPRA.ID_MEDIO_PAGO]
    FOREIGN KEY ([ID_MEDIO_PAGO])
      REFERENCES [MEDIO_DE_PAGO]([ID_MEDIO_PAGO]),

  CONSTRAINT [FK_COMPRA.CUIT_PROV]
    FOREIGN KEY ([CUIT_PROV])
      REFERENCES [PROVEDOR]([CUIT_PROV]),

  CONSTRAINT [FK_COMPRA.CUIT_PROV]
    FOREIGN KEY ([CODIGO_DESC_COMPRA])
      REFERENCES [DESCUENTO_X_COMPRA]([CUIT_PROV])
);



CREATE TABLE [PROVINCIA] (
  [CODIGO_PROVINCIA] decimal(19,0),
  [NOMBRE_PROV] nvarchar(255),
  PRIMARY KEY ([CODIGO_PROVINCIA])
);

CREATE TABLE [VENTA_MEDIANTE_CUPON] (
  [COD_VENTA] nvarchar(255),
  [CODIGO_CUPON] nvarchar(255),
  [IMPORTE] decimal(18,2),
  PRIMARY KEY ([COD_VENTA], [CODIGO_CUPON]),

  CONSTRAINT [FK_VENTA_MEDIANTE_CUPON.CUIT_PROV]
    FOREIGN KEY ([CODIGO_DESC_COMPRA])
      REFERENCES [DESCUENTO_X_COMPRA]([CUIT_PROV]),

  CONSTRAINT [FK_VENTA_MEDIANTE_CUPON.CUIT_PROV]
    FOREIGN KEY ([CODIGO_DESC_COMPRA])
      REFERENCES [DESCUENTO_X_COMPRA]([CUIT_PROV])
);

CREATE TABLE [PROVEEDOR] (
  [CUIT_PROV] nvarchar(50),
  [RAZON_SOCIAL_PROV] nvarchar(50),
  [DOMICILIO_PROV] nvarchar(50),
  [MAIL_PROV] nvarchar(50),
  [LOCALIDAD_PROV] nvarchar(255),
  [CODIGO_POSTAL] decimal(19,0),
  [CODIGO_PROVINCIA] decimal(19,0),
  PRIMARY KEY ([CUIT_PROV]),

  CONSTRAINT [FK_PROVEEDOR.CODIGO_POSTAL]
    FOREIGN KEY ([CODIGO_POSTAL])
      REFERENCES [CODIGO_POSTAL]([CODIGO_POSTAL]),
  
   CONSTRAINT [FK_PROVEEDOR.CODIGO_PROVINCIA]
    FOREIGN KEY ([CODIGO_PROVINCIA])
      REFERENCES [PROVINCIA]([CODIGO_PROVINCIA])
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
  [NOMBRE_PROV] nvarchar(255),
  PRIMARY KEY ([ID_CLIENTE]),
  CONSTRAINT [FK_CLIENTE.CODIGO_POSTAL]
    FOREIGN KEY ([CODIGO_POSTAL])
      REFERENCES [CODIGO_POSTAL]([CODIGO_POSTAL]),
  CONSTRAINT [FK_CLIENTE.CODIGO_PROVINCIA]
    FOREIGN KEY ([CODIGO_PROVINCIA])
      REFERENCES [PROVINCIA]([CODIGO_PROVINCIA])    
);

CREATE TABLE [DESCUENTO_COMPRA] (
  [CODIGO_DESC_COMPRA] decimal(18,2),
  [PORCENTAJE_DESC_COMPRA] decimal(19,0),
  [TIPO_DESC_COMPRA] decimal(19,0),
  PRIMARY KEY ([CODIGO_DESC_COMPRA])
);

CREATE TABLE [DESCUENTO_MEDIO_PAGO] (
  [CODIGO_DESC_MP] DECIMAL(19,0),
  [PORCENTAJE_DESCUENTO] decimal(18,2),
  PRIMARY KEY ([CODIGO_DESC_MP])
);

CREATE TABLE [MEDIO_DE_PAGO] (
  [ID_MEDIO_PAGO] decimal(19,0),
  [MEDIO_PAGO] nvarchar(255),
  [VALOR_DESC] decimal(18,2),
  [COSTO_TRANSACCION] decimal(18,2),
  [CODIGO_DESC_MP] decimal(19,0),
  PRIMARY KEY ([ID_MEDIO_PAGO]),
   CONSTRAINT [FK_MEDIO_DE_PAGO.CODIGO_DESC_MP]
    FOREIGN KEY ([CODIGO_DESC_MP])
      REFERENCES [DESCUENTO_X_MEDIO_DE_PAGO]([CODIGO_DESC_MP])

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
  PRIMARY KEY ([CODIGO_VAR]),
  CONSTRAINT [FK_MEDIO_DE_PAGO.CODIGO_TIPO_VAR]
    FOREIGN KEY ([CODIGO_TIPO_VAR])
      REFERENCES [TIPO_VARIANTE]([CODIGO_TIPO_VAR])
);

CREATE TABLE [TIPO_VARIANTE] (
  [CODIGO_TIPO_VAR] nvarchar(50),
  [DESCRIPCION_TIPO_VAR] nvarchar(50),
  PRIMARY KEY ([CODIGO_TIPO_VAR])
);

CREATE TABLE [VENTA_MEDIANTE_DESCUENTO_FIJO] (
  [COD_VENTA] nvarchar(255),
  [CODIGO_DESCUENTO] nvarchar(255),
  [IMPORTE] decimal(18,2),
  PRIMARY KEY ([COD_VENTA], [CODIGO_DESCUENTO]),

  CONSTRAINT [FK_VENTA_MEDIANTE_DESCUENTO_FIJO.COD_VENTA]
    FOREIGN KEY ([COD_VENTA])
      REFERENCES [VENTA]([COD_VENTA]),

  CONSTRAINT [FK_VENTA_MEDIANTE_DESCUENTO_FIJO.CODIGO_DESCUENTO]
    FOREIGN KEY ([CODIGO_DESCUENTO])
      REFERENCES [DESCUENTO_FIJO]([CODIGO_DESCUENTO])
  
);

CREATE TABLE [CANAL_VENTA] (
  [ID_CANAL_VENTA] decimal(19,0),
  [CANAL_VENTA] nvarchar(255),
  PRIMARY KEY ([ID_CANAL_VENTA])
);



CREATE TABLE [DESCUENTO_CUPON] (
  [CODIGO_CUPON] nvarchar(255),
  [COD_VENTA] decimal(18,2),
  [VALOR_DESC] decimal(18,2),
  [FECHA_DESDE] date,
  [FECHA_HASTA] date,
  PRIMARY KEY ([CODIGO_CUPON]),
  CONSTRAINT [FK_DESCUENTO_CUPON.COD_VENTA]
    FOREIGN KEY ([COD_VENTA])
      REFERENCES [VENTA_MEDIANTE_CUPON]([COD_VENTA])
);

CREATE TABLE [VENTA_PRODUCTO] (
  [CANTIDAD] decimal(18,0),
  [PRECIO_UNIT] decimal(18,2),
  [PRECIO_TOTAL] decimal(18,2),
  [COD_PRODUCTO_VARIANTE] nvarchar(50),
  [COD_VENTA] decimal(19,0),
  PRIMARY KEY ([COD_PROD], [COD_VENTA]),

    CONSTRAINT [FK_VENTA_PRODUCTO.COD_PRODUCTO_VARIANTE]
    FOREIGN KEY ([COD_VENTA])
      REFERENCES [PRODUCTO_VARIANTE]([COD_PRODUCTO_VARIANTE]),

    CONSTRAINT [FK_VENTA_PRODUCTO.COD_VENTA]
    FOREIGN KEY ([COD_VENTA]) 
      REFERENCES [VENTA]([COD_VENTA])
);

CREATE TABLE [DESCUENTO_FIJO] (
  [CODIGO_DESCUENTO] decimal(18,2),
  [COD_VENTA] decimal(18,2),
  [TIPO_DESC] nvarchar(255),
  [VALOR_DESC] decimal(18,2),
  PRIMARY KEY ([CODIGO_DESCUENTO])
);

--------------------------------------------------------------------------------------------------------------------

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
      REFERENCES [VARIANTE]([CODIGO_VAR]),
  CONSTRAINT [FK_PRODUCTO_VARIANTE.COD_PROD]
    FOREIGN KEY ([COD_PROD])
      REFERENCES [PRODUCTO]([COD_PROD])
);

CREATE TABLE [COMPRA_PRODUCTO] (
  [CANTIDAD] decimal(18,0),
  [PRECIO_UNIT] decimal(18,2),
  [PRECIO_TOTAL] decimal(18,2),
  [COD_COMPRA] decimal(19,0),
  [COD_PRODUCTO_VARIANTE] nvarchar(50),
  PRIMARY KEY ([COD_COMPRA], [COD_PRODUCTO_VARIANTE]),
  CONSTRAINT [FK_COMPRA_PRODUCTO.COD_COMPRA]
    FOREIGN KEY ([COD_COMPRA])
      REFERENCES [COMPRA]([COD_COMPRA]),
  CONSTRAINT [FK_COMPRA_PRODUCTO.COD_PRODUCTO_VARIANTE]
    FOREIGN KEY ([COD_PRODUCTO_VARIANTE])
      REFERENCES [PRODUCTO_VARIANTE]([COD_PRODUCTO_VARIANTE])
);



CREATE TABLE [CODIGO_POSTAL] (
  [CODIGO_POSTAL] decimal(19,0),
  [CODIGO_PROVINCIA] decimal(19,0),
  PRIMARY KEY ([CODIGO_POSTAL]),
  CONSTRAINT [FK_CODIGO_POSTAL.CODIGO_POSTAL]
    FOREIGN KEY ([CODIGO_PROVINCIA])
      REFERENCES [PROVINCIA]([CODIGO_PROVINCIA])
);



CREATE TABLE [DESCUENTO_X_COMPRA] (
  [COD_COMPRA] decimal(19,0),
  [CODIGO_DESC_COMPRA] decimal(18,2),
  PRIMARY KEY ([COD_COMPRA], [CODIGO_DESC_COMPRA]),
  CONSTRAINT [FK_DESCUENTO_X_COMPRA.COD_COMPRA]
    FOREIGN KEY ([COD_COMPRA])
      REFERENCES [COMPRA]([COD_COMPRA]),
  CONSTRAINT [FK_DESCUENTO_X_COMPRA.CODIGO_DESC_COMPRA]
    FOREIGN KEY ([CODIGO_DESC_COMPRA])
      REFERENCES [DESCUENTO_COMPRA]([CODIGO_DESC_COMPRA])
);



CREATE TABLE [DESCUENTO_X_MEDIO_DE_PAGO] (
  [CODIGO_DESC_MP] decimal(19,0),
  [ID_MEDIO_PAGO] decimal(19,0),
  PRIMARY KEY ([CODIGO_DESC_MP], [ID_MEDIO_PAGO]),
  CONSTRAINT [FK_DESCUENTO_X_MEDIO_DE_PAGO.CODIGO_DESC_MP]
    FOREIGN KEY ([CODIGO_DESC_MP])
      REFERENCES [DESCUENTO_MEDIO_PAGO]([CODIGO_DESC_MP]),

  CONSTRAINT [FK_DESCUENTO_X_MEDIO_DE_PAGO.CODIGO_DESC_MP]
    FOREIGN KEY ([ID_MEDIO_PAGO])
      REFERENCES [MEDIO_DE_PAGO]([ID_MEDIO_PAGO])
);



CREATE TABLE [VENTA] (
  [COD_VENTA] decimal(19,0),
  [FECHA_VENTA] date,
  [ID_CLIENTE] decimal(19,0),
  [ID_CANAL_VENTA] decimal(19,0),
  [ID_MEDIO_ENVIO] decimal(19,0),
  [ID_MEDIO_PAGO] decimal(19,0),
  [CODIGO_POSTAL] decimal(19,0),
  [CODIGO_CUPON] nvarchar(255),
  [TOTAL_VENTA] decimal(18,2),
  [PRECIO_ENVIO] decimal(18,2),
  [CODIGO_DESCUENTO] nvarchar(255),
  PRIMARY KEY ([COD_VENTA]),

  CONSTRAINT [FK_VENTA.ID_MEDIO_PAGO]
    FOREIGN KEY ([ID_MEDIO_PAGO])
      REFERENCES [MEDIO_DE_PAGO]([ID_MEDIO_PAGO]),

	    CONSTRAINT [FK_VENTA.ID_MEDIO_ENVIO]
    FOREIGN KEY ([ID_MEDIO_ENVIO])
      REFERENCES [MEDIO_ENVIO_X_CODIGO_POSTAL]([ID_MEDIO_ENVIO]),

  CONSTRAINT [FK_VENTA.ID_CANAL_VENTA]
    FOREIGN KEY ([ID_CANAL_VENTA])
      REFERENCES [CANAL_VENTA]([CANAL_VENTA]),

  CONSTRAINT [FK_VENTA.CODIGO_POSTAL]
    FOREIGN KEY ([CODIGO_POSTAL])
      REFERENCES [MEDIO_ENVIO_X_CODIGO_POSTAL]([CODIGO_POSTAL]),

  CONSTRAINT [FK_VENTA.ID_CLIENTE]
    FOREIGN KEY ([ID_CLIENTE])
      REFERENCES [CLIENTE]([ID_CLIENTE])
);

CREATE TABLE [MEDIO_ENVIO_X_CODIGO_POSTAL] (
  [ID_MEDIO_ENVIO] decimal(19,0),
  [CODIGO_POSTAL] decimal(19,0),
  [TIEMPO_EST] decimal(18,2),
  [PRECIO] decimal(18,2),
  [MEDIO] nvarchar(255),
  PRIMARY KEY ([ID_MEDIO_ENVIO]),
  CONSTRAINT [FK_MEDIO_ENVIO_X_CODIGO_POSTAL.CODIGO_POSTAL]
    FOREIGN KEY ([CODIGO_POSTAL])
      REFERENCES [CODIGO_POSTAL]([CODIGO_POSTAL])
);

CREATE PROCEDURE insertar_proveedor
AS
BEGIN
	DECLARE @cuit nvarchar(255),@domicilio nvarchar(255),@codPostal decimal(19,0),@razonSocial nvarchar(255),@mail nvarchar(255),@provincia nvarchar(255),@localidad nvarchar(255)
	DECLARE @cursor CURSOR FOR SELECT DISTINCT PROVEEDOR_CUIT,PROVEEDOR_DOMICILIO,PROVEEDOR_CODIGO_POSTAL,PROVEEDOR_RAZON_SOCIAL,
								PROVEEDOR_MAIL,PROVEEDOR_PROVINCIA, PROVEEDOR_LOCALIDAD
								FROM gd_esquema.Maestra WHERE PROVEEDOR_CUIT IS NOT NULL
	OPEN @cursor
	FETCH NEXT FROM	@cursor INTO @cuit,@domicilio,@codPostal,@razonSocial,@mail,@provincia,@localidad
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		DECLARE @codProvincia decimal(19,0)
		IF NOT EXISTS (SELECT 1 FROM codigo_postal WHERE CODIGO_POSTAL = @codPostal) --codigo_postal nuestra tabla
		BEGIN
			INSERT INTO provincia (nombre_prov)
			VALUES (@provincia)
			INSERT INTO codigo_postal (codigo_provincia)
			SELECT @codProvincia = codigo_provincia WHERE nombre_prov = @provincia
		END
		SELECT @codProvincia = codigo_provincia WHERE nombre_prov = @provincia
		INSERT INTO proveedor (cuit_prov,razon_social_prov,domicilio_prov,mail_prov,localidad_prov,codigo_postal,codigo_provincia)
		VALUES (@cuit,@razonSocial,@domicilio,@mail,@localidad,@codPostal,@codProvincia)
		FETCH NEXT FROM	@cursor INTO @cuit,@razonSocial,@domicilio,@mail,@localidad,@codPostal,@provincia
	END
	CLOSE @cursor
	DEALLOCATE @cursor
END


CREATE PROCEDURE insertar_productos
AS
BEGIN
	INSERT INTO producto (cod_prod,nombre_prod,descripcion_prod,marca_prod,categoria_prod,material_prod)
	SELECT DISTINCT PRODUCTO_CODIGO,PRODUCTO_NOMBRE,PRODUCTO_DESCRIPCION,PRODUCTO_MARCA,PRODUCTO_CATEGORIA,PRODUCTO_MATERIAL 
	FROM gd_esquema.Maestra
	WHERE PRODUCTO_CODIGO IS NOT NULL
END

CREATE PROCEDURE insertar_canales_venta
AS
BEGIN
	INSERT INTO canal_venta (canal_venta,canal_costo)
	SELECT DISTINCT VENTA_CANAL,VENTA_CANAL_COSTO 
	FROM gd_esquema.Maestra
	WHERE VENTA_CANAL IS NOT NULL --generar la tabla de nuevo, nos falto el costo
END

CREATE PROCEDURE insertar_variantes
AS
BEGIN
	DECLARE @variante nvarchar(50),@tipo nvarchar(50),@codigo nvarchar(50)
	DECLARE @cursor CURSOR FOR SELECT DISTINCT PRODUCTO_VARIANTE,PRODUCTO_TIPO_VARIANTE,PRODUCTO_VARIANTE_CODIGO 
								FROM gd_esquema.Maestra
								WHERE PRODUCTO_VARIANTE_CODIGO IS NOT NULL
	OPEN @cursor
	FETCH NEXT FROM @cursor INTO @variante,@tipo,@codigo
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		INSERT INTO tipo_variante (codigo_tipo_var,descripcion_tipo_var)
		VALUES (@codigo,@tipo)
		INSERT INTO variante (codigo_tipo_var,valor)
		VALUES (@codigo,@variante)
		FETCH NEXT FROM @cursor INTO @variante,@tipo,@codigo
	END
	CLOSE @cursor
	DEALLOCATE @cursor
END

CREATE PROCEDURE insertar_clientes
AS
BEGIN
	DECLARE @nombre nvarchar(255),@apellido nvarchar(255),@dni decimal(18,0),@direccion nvarchar(255),@telefono decimal(18,0),@mail nvarchar(255),@fechaNacimiento date,@localidad nvarchar(255),@codPostal decimal(19,0),@provincia nvarchar(255)
	DECLARE @cursor CURSOR FOR 
		(SELECT DISTINCT CLIENTE_NOMBRE,CLIENTE_APELLIDO,CLIENTE_DNI,CLIENTE_DIRECCION,CLIENTE_TELEFONO,
		CLIENTE_MAIL, CLIENTE_FECHA_NAC,CLIENTE_LOCALIDAD, CLIENTE_CODIGO_POSTAL, CLIENTE_PROVINCIA  
		FROM gd_esquema.Maestra
		WHERE CLIENTE_DNI IS NOT NULL)
	OPEN @cursor
	FETCH NEXT FROM @cursor INTO @nombre,@apellido,@dni,@direccion,@telefono,@mail,@fechaNacimiento,@localidad,@codPostal,@provincia
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		DECLARE @codProvincia decimal(19,0)
		IF NOT EXISTS (SELECT 1 FROM codigo_postal WHERE CODIGO_POSTAL = @codPostal) --codigo_postal nuestra tabla
		BEGIN
			INSERT INTO provincia (nombre_prov)
			VALUES (@provincia)
			INSERT INTO codigo_postal (codigo_provincia)
			SELECT codigo_provincia WHERE nombre_prov = @provincia --distinct?
		END
		SELECT @codProvincia = codigo_provincia WHERE nombre_prov = @provincia
		INSERT INTO cliente (nombre_cliente,apellido_cliente,dni_cliente,direccion_cliente,telefono_cliente,mail_cliente,fecha_nac_cliente,localidad_cliente,codigo_postal,codigo_provincia)
		VALUES (@nombre,@apellido,@dni,@direccion,@telefono,@mail,@fechaNacimiento,@localidad,@codPostal,@codProvincia)
		FETCH NEXT FROM @cursor INTO @nombre,@apellido,@dni,@direccion,@telefono,@mail,@fechaNacimiento,@localidad,@codPostal,@provincia
	END
	CLOSE @cursor
	DEALLOCATE @cursor
END

CREATE PROCEDURE insertar_descuentos_compra
AS
BEGIN
	INSERT INTO DESCUENTO_COMPRA (codigo_desc_compra,monto_desc_compra)
	SELECT DISTINCT DESCUENTO_COMPRA_CODIGO,DESCUENTO_COMPRA_VALOR 
	FROM gd_esquema.Maestra WHERE DESCUENTO_COMPRA_CODIGO IS NOT NULL
END


CREATE PROCEDURE insertar_medio_envio
AS
BEGIN
	INSERT INTO MEDIO_ENVIO (codigo_postal,tiempo_est,precio,medio)
	SELECT DISTINCT CLIENTE_CODIGO_POSTAL,NULL TIEMPO_EST,VENTA_ENVIO_PRECIO,VENTA_MEDIO_ENVIO
  FROM gd_esquema.Maestra
  WHERE VENTA_MEDIO_ENVIO IS NOT NULL
END

--averiguar como obtener el medio envio y precio desde la venta. como saber el precio del envio desde venta

CREATE PROCEDURE insertar_descuentos_cupon
AS
BEGIN
	INSERT INTO DESCUENTO_CUPON (codigo_cupon,valor_desc,fecha_desde,fecha_hasta)
	SELECT DISTINCT VENTA_CUPON_CODIGO,VENTA_CUPON_VALOR,VENTA_CUPON_FECHA_DESDE,VENTA_CUPON_FECHA_HASTA 
	FROM gd_esquema.Maestra WHERE VENTA_CUPON_CODIGO IS NOT NULL
END

CREATE PROCEDURE insertar_descuentos_fijo
AS
BEGIN
  INSERT INTO DESCUENTO_FIJO (tipo_desc,valor_desc)
  SELECT DISTINCT VENTA_DESCUENTO_CONCEPTO,VENTA_DESCUENTO_IMPORTE
  FROM gd_esquema.Maestra
  WHERE VENTA_DESCUENTO_CONCEPTO IS NOT NULL AND VENTA_DESCUENTO_CONCEPTO = 'Otros'
END

CREATE PROCEDURE insertar_compras
AS
BEGIN
	DECLARE @codCompra decimal(19,0),@fecha date,@medioPago nvarchar(255),@total decimal(18,2),@cuit nvarchar(50),@codDescuentoCompra decimal(19,0),@prodVarianteCod nvarchar(50)
	DECLARE @cursor CURSOR FOR 
	SELECT DISTINCT COMPRA_NUMERO,COMPRA_FECHA,COMPRA_MEDIO_PAGO,COMPRA_TOTAL,PROVEEDOR_CUIT,DESCUENTO_COMPRA_CODIGO,PRODUCTO_VARIANTE_CODIGO
	FROM gd_esquema.Maestra WHERE COMPRA_NUMERO IS NOT NULL
	OPEN @cursor
	FETCH @cursor INTO @codCompra,@fecha,@medioPago,@total,@cuit,@codDescuentoCompra,@prodVarianteCod
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		DECLARE @totalCompra decimal(18,2)
		INSERT INTO COMPRA_PRODUCTO
		SELECT COMPRA_PRODUCTO_CANTIDAD,COMPRA_PRODUCTO_PRECIO, @totalCompra = (COMPRA_PRODUCTO_CANTIDAD*COMPRA_PRODUCTO_PRECIO) precio_total, @codCompra,@prodVarianteCod
		FROM gd_esquema.Maestra
		WHERE COMPRA_NUMERO = @codCompra

		INSERT INTO compra
		VALUES (@codCompra,@fecha,(SELECT ID_MEDIO_PAGO FROM MEDIO_DE_PAGO WHERE MEDIO_PAGO=@medioPago),@totalCompra,@cuit)

		INSERT INTO DESCUENTO_X_COMPRA (cod_compra,codigo_desc_compra)
		VALUES (@codCompra,@codDescuentoCompra)


		FETCH @cursor INTO @codCompra,@fecha,@medioPago,@total,@cuit,@codDescuentoCompra
	END
	CLOSE @cursor
	DEALLOCATE @cursor
END

CREATE PROCEDURE insertar_medios_de_pago
AS
BEGIN
  
  INSERT INTO DESCUENTO_MEDIO_PAGO (PORCENTAJE_DESCUENTO)
  SELECT DISTINCT (VENTA_DESCUENTO_IMPORTE/VENTA_TOTAL) PORCENTAJE_DESCUENTO
  FROM gd_esquema.Maestra
  WHERE VENTA_DESCUENTO_CONCEPTO IS NOT NULL AND VENTA_DESCUENTO_CONCEPTO != 'Otros'

  DECLARE @medioPago nvarchar(255),@valorDescuento decimal(18,2),@costoTransaccion decimal(18,2),@codigoDescuento decimal(19,0),@medioPagoId decimal(19,0)
  DECLARE @cursor CURSOR FOR
  SELECT DISTINCT VENTA_MEDIO_PAGO,VENTA_DESCUENTO_IMPORTE,VENTA_MEDIO_PAGO_COSTO,(SELECT CODIGO_DESC_MP FROM DESCUENTO_MEDIO_PAGO WHERE PORCENTAJE_DESCUENTO=VENTA_DESCUENTO_IMPORTE/VENTA_TOTAL)
  FROM gd_esquema.Maestra
  WHERE VENTA_MEDIO_PAGO IS NOT NULL
  OPEN @cursor
  FETCH @cursor INTO @medioPago,@valorDescuento,@costoTransaccion,@codigoDescuento
  WHILE (@@FETCH_STATUS = 0)
  BEGIN
    INSERT INTO MEDIO_DE_PAGO (medio_pago,valor_desc,costo_transaccion,codigo_desc_mp)
    VALUES (@medioPago,@valorDescuento,@costoTransaccion,@codigoDescuento)
  END
  CLOSE @cursor
  DEALLOCATE @cursor
END

CREATE PROCEDURE insertar_descuentos_x_medio_de_pago
AS
BEGIN
  DECLARE @medioPagoId decimal(19,0),@codigoDescuento decimal(19,0)
  DECLARE @cursor CURSOR FOR
  SELECT id_medio_pago,codigo_desc_mp
  FROM MEDIO_DE_PAGO
  OPEN @cursor
  FETCH @cursor INTO @medioPagoId,@codigoDescuento
  WHILE (@@FETCH_STATUS = 0)
  BEGIN
    INSERT INTO DESCUENTO_X_MEDIO_DE_PAGO (id_medio_pago,codigo_desc_compra)
    VALUES (@medioPagoId,@codigoDescuento)
    FETCH @cursor INTO @medioPagoId,@codigoDescuento
  END
  CLOSE @cursor
  DEALLOCATE @cursor
END

CREATE PROCEDURE insertar_producto_variante
AS
BEGIN
  DECLARE @prodVarianteCod nvarchar(50),@prodCod nvarchar(50),@stock decimal(19,0),@descripcion nvarchar(50),@variante nvarchar(50),@tipoVariante nvarchar(50),@precioVenta decimal(18,2)
  DECLARE @cursor CURSOR FOR SELECT DISTINCT PRODUCTO_VARIANTE_CODIGO,PRODUCTO_CODIGO,PRODUCTO_TIPO_VARIANTE,PRODUCTO_VARIANTE,PRODUCTO_DESCRIPCION,VENTA_PRODUCTO_PRECIO
  FROM gd_esquema.Maestra WHERE PRODUCTO_VARIANTE_CODIGO IS NOT NULL
  OPEN @cursor
  FETCH NEXT FROM @cursor INTO @prodVarianteCod,@prodCod,@variante,@tipoVariante,@descripcion,@precioVenta
  WHILE (@@FETCH_STATUS = 0)
  BEGIN
    IF NOT EXISTS (SELECT 1 FROM PRODUCTO_VARIANTE WHERE codigo_var = @prodVarianteCod)
    BEGIN
      INSERT INTO PRODUCTO_VARIANTE (codigo_var,cod_prod,cod_producto_variante,stock,descripcion,precio_unitario_prod)
      VALUES (id_producto_variante(@variante,@tipoVariante),@prodCod,@prodVarianteCod,0,@descripcion,@precioVenta) 
      FETCH NEXT FROM @cursor INTO @prodVarianteCod,@prodCod,@variante,@tipoVariante,@descripcion,@precioVenta
    END
    ELSE
    BEGIN
      UPDATE PRODUCTO_VARIANTE
      SET stock += @stock
      WHERE codigo_var = @prodVarianteCod
    END
  CLOSE @cursor
  DEALLOCATE @cursor
END

CREATE FUNCTION id_producto_variante(@variante nvarchar(50),@tipoVariante nvarchar(50))
RETURNS nvarchar(50)
AS
BEGIN
  DECLARE @id nvarchar(50)
  SELECT @id=codigo_var FROM VARIANTE
  WHERE valor = @valor AND (SELECT codigo_tipo_var FROM TIPO_VARIANTE WHERE descripcion_tipo_var = @tipo) = codigo_tipo_var
  RETURN @id
END

CREATE PROCEDURE insertar_compra_producto
AS
BEGIN
	INSERT INTO COMPRA_PRODUCTO (cod_compra,cod_producto_variante,cantidad,precio_unit,precio_total)
	SELECT COMPRA_NUMERO,PRODUCTO_VARIANTE_CODIGO,COMPRA_PRODUCTO_CANTIDAD,COMPRA_PRODUCTO_PRECIO,SUM(COMPRA_PRODUCTO_CANTIDAD*COMPRA_PRODUCTO_PRECIO) PRECIO_TOTAL
	FROM gd_esquema.Maestra
	WHERE COMPRA_NUMERO IS NOT NULL AND PRODUCTO_VARIANTE_CODIGO IS NOT NULL
	GROUP BY COMPRA_NUMERO,COMPRA_PRODUCTO_CANTIDAD,COMPRA_PRODUCTO_PRECIO,PRODUCTO_VARIANTE_CODIGO
END

CREATE PROCEDURE insertar_venta_producto
AS
BEGIN
	INSERT INTO VENTA_PRODUCTO (cod_venta,cod_producto_variante,cantidad,precio_unit,precio_total)
	SELECT VENTA_CODIGO,PRODUCTO_VARIANTE_CODIGO,VENTA_PRODUCTO_CANTIDAD,VENTA_PRODUCTO_PRECIO,SUM(VENTA_PRODUCTO_CANTIDAD*VENTA_PRODUCTO_PRECIO) PRECIO_TOTAL
	FROM gd_esquema.Maestra
	WHERE VENTA_CODIGO IS NOT NULL AND PRODUCTO_VARIANTE_CODIGO IS NOT NULL
	GROUP BY VENTA_CODIGO,PRODUCTO_VARIANTE_CODIGO,VENTA_PRODUCTO_CANTIDAD,VENTA_PRODUCTO_PRECIO
END

CREATE PROCEDURE insertar_ventas
AS
BEGIN
  DECLARE @codVenta decimal(19,0), @fecha date, @clienteDni decimal(19,0), @canalVenta decimal(19,0), @medioEnvio decimal(19,0), 
  @codigoPostal decimal(19,0),@medioPago decimal(19,0), @totalVenta decimal(18,2), @precioEnvio decimal(18,2),@cuponCod nvarchar(255),
  @cuponImporte decimal(18,2),@descuentoConcepto nvarchar(255),@descuentoValor decimal(18,2)
  DECLARE @cursor CURSOR FOR
  SELECT DISTINCT VENTA_CODIGO, VENTA_FECHA, CLIENTE_DNI, VENTA_CANAL, VENTA_MEDIO_ENVIO, VENTA_MEDIO_PAGO, VENTA_TOTAL, 
  VENTA_ENVIO_PRECIO,VENTA_CUPON_CODIGO,VENTA_CUPON_IMPORTE,VENTA_DESCUENTO_CONCEPTO,VENTA_DESCUENTO_IMPORTE
  FROM gd_esquema.Maestra WHERE VENTA_CODIGO IS NOT NULL
  OPEN @cursor
  FETCH @cursor INTO @codVenta, @fecha, @clienteDni, @canalVenta, @medioEnvio, @medioPago, @totalVenta, @precioEnvio,@cuponCod,
  @cuponImporte,@descuentoConcepto,@descuentoValor
  WHILE(@@FETCH_STATUS = 0)
  BEGIN

    INSERT INTO venta
    VALUES (@codVenta, @fecha, (SELECT ID_CLIENTE FROM CLIENTE WHERE CLIENTE_DNI=@clienteDni), 
            (SELECT ID_CANAL_VENTA FROM CANAL_VENTA WHERE CANAL_VENTA=@canalVenta), 
            (SELECT ID_MEDIO_ENVIO FROM MEDIO_ENVIO WHERE MEDIO_ENVIO=@medioEnvio), (SELECT ID_MEDIO_PAGO FROM MEDIO_DE_PAGO WHERE MEDIO_PAGO=@medioPago), 
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
      VALUES ((SELECT CODIGO_DESCUENTO FROM DESCUENTO_FIJO WHERE @descuentoValor=VALOR_DESC), @descuentoValor) 
    END
    FETCH @cursor INTO @codVenta, @fecha, @clienteDni, @canalVenta, @medioEnvio, @medioPago, @totalVenta, @precioEnvio,@cuponCod,
    @cuponImporte,@descuentoConcepto,@descuentoValor
	END
	CLOSE @cursor
	DEALLOCATE @cursor
END

