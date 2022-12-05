USE [GD2C2022]
GO


CREATE TABLE [gd_esquema].[BI_DIM_TIEMPO](
    [ID_FECHA] decimal(19,0) IDENTITY(1,1),
    [MES] INT,
    [ANIO] INT,
    PRIMARY KEY  ([ID_FECHA])
);

GO

CREATE TABLE [gd_esquema].[BI_DIM_PROVINCIA](
    [CODIGO_PROVINCIA] decimal(19,0),
    [NOMBRE_PROV] nvarchar(255),
    PRIMARY KEY ([CODIGO_PROVINCIA])
);

GO

CREATE TABLE [gd_esquema].[BI_DIM_RANGO_ETARIO](
  [ID_RANGO_ETARIO] decimal(19,0) IDENTITY (1,1),
  [RANGO_ETARIO] nvarchar(255),
  PRIMARY KEY ([ID_RANGO_ETARIO]) 
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
  [ID_CATEGORIA] decimal(19,0),
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
  [ID_TIPO_DESCUENTO] decimal(19,0) IDENTITY(1,1),
  [TIPO_DESCUENTO] char(20),
  PRIMARY KEY ([ID_TIPO_DESCUENTO])
);

GO

CREATE TABLE [gd_esquema].[BI_DIM_TIPO_ENVIO](
  [ID_MEDIO_ENVIO] decimal(19,0),
  [MEDIO] nvarchar(255),
  PRIMARY KEY ([ID_MEDIO_ENVIO])
);
GO

CREATE TABLE [gd_esquema].[BI_DIM_PROVEEDOR](
  [ID_PROVEEDOR] nvarchar(50), --es el cuit
  [RAZON_SOCIAL_PROV] nvarchar(255)
  PRIMARY KEY ([ID_PROVEEDOR])
)
GO

CREATE TABLE [gd_esquema].[BI_HECHOS_COMPRAS](
    [ID_FECHA] decimal(19,0), --fk
    [ID_PROVEEDOR] nvarchar(50), --fk
    [COD_PROD] nvarchar(50), --fk
    [TOTAL_PRODUCTO] decimal(18,2),
    [CANTIDAD_PRODUCTO] decimal(19,0),
    [TOTAL_COMPRA] decimal(18,2), --NETO
    [TOTAL_DESCUENTO] decimal(18,2),
	PRIMARY KEY ([ID_FECHA],[ID_PROVEEDOR],[COD_PROD])
);
GO

CREATE TABLE [gd_esquema].[BI_HECHOS_VENTAS](
    [ID_FECHA] decimal(19,0), --fk
    [CODIGO_PROVINCIA] decimal(19,0), --fk
    [ID_RANGO_ETARIO] decimal(19,0), --fk
    [ID_CANAL_VENTA] decimal(19,0), --fk
    [ID_MEDIO_PAGO] decimal(19,0), --fk
    [ID_CATEGORIA] decimal(19,0), --fk
    [COD_PROD] nvarchar(50), --fk
    [ID_MEDIO_ENVIO] decimal(19,0), --fk
    [DESCUENTO_ID] decimal(19,0), --fk
    [TOTAL_VENTA] decimal(18,2), --NETO
    [TOTAL_DESCUENTOS] decimal(18,2),
    [MEDIO_ENVIO_COSTO] decimal(18,2),
    [MEDIO_PAGO_COSTO] decimal(18,2),
    [CANAL_VENTA_COSTO] decimal(18,2),
    [CANTIDAD_PRODUCTO] decimal(19,0),
    [TOTAL_PRODUCTO] decimal(18,2),
	PRIMARY KEY ([ID_FECHA],[CODIGO_PROVINCIA],[ID_RANGO_ETARIO], [ID_CANAL_VENTA],[ID_MEDIO_PAGO],[ID_CATEGORIA], [COD_PROD],[ID_MEDIO_ENVIO],[DESCUENTO_ID])
);
GO


CREATE TABLE [gd_esquema].[BI_HECHOS_DESCUENTOS]( --de ventas
    [DESCUENTO_ID] DECIMAL(19,0) IDENTITY(1,1), --PK
    [ID_TIPO_DESCUENTO] decimal(19,0), --FK
    [ID_FECHA] DECIMAL(19,0), --fk
    [TOTAL_DESCUENTO] DECIMAL(18,2),
	PRIMARY KEY ([DESCUENTO_ID])
);
GO




ALTER TABLE [gd_esquema].[BI_HECHOS_VENTAS] ADD CONSTRAINT [ID_FECHA] FOREIGN KEY ([ID_FECHA]) REFERENCES [gd_esquema].[BI_DIM_TIEMPO]([ID_FECHA])
ALTER TABLE [gd_esquema].[BI_HECHOS_VENTAS] ADD CONSTRAINT [CODIGO_PROVINCIA] FOREIGN KEY ([CODIGO_PROVINCIA]) REFERENCES [gd_esquema].[BI_DIM_PROVINCIA]([CODIGO_PROVINCIA])
ALTER TABLE [gd_esquema].[BI_HECHOS_VENTAS] ADD CONSTRAINT [ID_RANGO_ETARIO] FOREIGN KEY ([ID_RANGO_ETARIO]) REFERENCES [gd_esquema].[BI_DIM_RANGO_ETARIO]([ID_RANGO_ETARIO])
ALTER TABLE [gd_esquema].[BI_HECHOS_VENTAS] ADD CONSTRAINT [ID_CANAL_VENTA] FOREIGN KEY ([ID_CANAL_VENTA]) REFERENCES [gd_esquema].[BI_DIM_CANAL_VENTA]([ID_CANAL_VENTA])
ALTER TABLE [gd_esquema].[BI_HECHOS_VENTAS] ADD CONSTRAINT [ID_MEDIO_PAGO] FOREIGN KEY ([ID_MEDIO_PAGO]) REFERENCES [gd_esquema].[BI_DIM_MEDIO_PAGO]([ID_MEDIO_PAGO])  
ALTER TABLE [gd_esquema].[BI_HECHOS_VENTAS] ADD CONSTRAINT [ID_CATEGORIA] FOREIGN KEY ([ID_CATEGORIA]) REFERENCES [gd_esquema].[BI_DIM_CATEGORIA_PRODUCTO]([ID_CATEGORIA])
ALTER TABLE [gd_esquema].[BI_HECHOS_VENTAS] ADD CONSTRAINT [COD_PROD] FOREIGN KEY ([COD_PROD]) REFERENCES [gd_esquema].[BI_DIM_PRODUCTO]([COD_PROD])
ALTER TABLE [gd_esquema].[BI_HECHOS_VENTAS] ADD CONSTRAINT [ID_MEDIO_ENVIO] FOREIGN KEY ([ID_MEDIO_ENVIO]) REFERENCES [gd_esquema].[BI_DIM_TIPO_ENVIO]([ID_MEDIO_ENVIO])
ALTER TABLE [gd_esquema].[BI_HECHOS_VENTAS] ADD CONSTRAINT [DESCUENTO_ID] FOREIGN KEY ([DESCUENTO_ID]) REFERENCES [gd_esquema].[BI_HECHOS_DESCUENTOS]([DESCUENTO_ID])


ALTER TABLE [gd_esquema].[BI_HECHOS_COMPRAS] ADD CONSTRAINT [FK_COMPRA_ID_FECHA] FOREIGN KEY ([ID_FECHA]) REFERENCES [gd_esquema].[BI_DIM_TIEMPO]([ID_FECHA])
ALTER TABLE [gd_esquema].[BI_HECHOS_COMPRAS] ADD CONSTRAINT [FK_ID_PROVEEDOR] FOREIGN KEY ([ID_PROVEEDOR]) REFERENCES [gd_esquema].[BI_DIM_PROVEEDOR]([ID_PROVEEDOR])
ALTER TABLE [gd_esquema].[BI_HECHOS_COMPRAS] ADD CONSTRAINT [FK_COD_PROD] FOREIGN KEY ([COD_PROD]) REFERENCES [gd_esquema].[BI_DIM_PRODUCTO]([COD_PROD])


ALTER TABLE [gd_esquema].[BI_HECHOS_DESCUENTOS] ADD CONSTRAINT [FK_DESCUENTO.ID_FECHA] FOREIGN KEY ([ID_FECHA]) REFERENCES [gd_esquema].[BI_DIM_TIEMPO]([ID_FECHA])
ALTER TABLE [gd_esquema].[BI_HECHOS_DESCUENTOS] ADD CONSTRAINT [ID_TIPO_DESCUENTO] FOREIGN KEY ([ID_TIPO_DESCUENTO]) REFERENCES [gd_esquema].[BI_DIM_TIPO_DESCUENTO]([ID_TIPO_DESCUENTO])
--ALTER TABLE [gd_esquema].[BI_HECHOS_DESCUENTOS] ADD CONSTRAINT [FK_DESCUENTO.DESCUENTO_ID] FOREIGN KEY ([DESCUENTO_ID]) REFERENCES [gd_esquema].[BI_HECHOS_VENTAS]([DESCUENTO_ID])




--MIGRACION
GO

CREATE PROCEDURE [gd_esquema].cargar_tiempo AS
    BEGIN
        INSERT INTO [gd_esquema].BI_DIM_TIEMPO (ANIO, MES)
            SELECT DISTINCT YEAR(FECHA_COMPRA), MONTH(FECHA_COMPRA)
                FROM [gd_esquema].COMPRA
            UNION
             SELECT DISTINCT YEAR(FECHA_VENTA), MONTH(FECHA_VENTA)
                FROM [gd_esquema].VENTA
    END
GO

CREATE PROCEDURE [gd_esquema].cargar_rangos_etarios AS
    BEGIN
        INSERT INTO [gd_esquema].BI_DIM_RANGO_ETARIO (RANGO_ETARIO) VALUES ('<25'), ('[25-35)'), ('[35-55]'), ('>55')
    END
GO

CREATE PROCEDURE [gd_esquema].cargar_provincias AS
    BEGIN
        INSERT INTO [gd_esquema].BI_DIM_PROVINCIA (CODIGO_PROVINCIA,NOMBRE_PROV) 
        SELECT CODIGO_PROVINCIA,NOMBRE_PROV FROM [gd_esquema].[PROVINCIA]
    END
GO

CREATE PROCEDURE [gd_esquema].cargar_canales_venta AS
    BEGIN
        INSERT INTO [gd_esquema].BI_DIM_CANAL_VENTA (ID_CANAL_VENTA,CANAL_VENTA) 
        SELECT ID_CANAL_VENTA,CANAL_VENTA FROM [gd_esquema].[CANAL_VENTA]
    END
GO


CREATE PROCEDURE [gd_esquema].cargar_medios_pago AS
    BEGIN
        INSERT INTO [gd_esquema].BI_DIM_MEDIO_PAGO (MEDIO_PAGO) 
        SELECT DISTINCT MEDIO_PAGO FROM [gd_esquema].[MEDIO_DE_PAGO] --distinct?
    END
GO


CREATE PROCEDURE [gd_esquema].cargar_categorias_prod AS
    BEGIN
        INSERT INTO [gd_esquema].BI_DIM_CATEGORIA_PRODUCTO (ID_CATEGORIA,CATEGORIA) 
        SELECT ID_CATEGORIA,CATEGORIA FROM [gd_esquema].[CATEGORIA] --mal, estan las marcas guardadas ahi (corregido en datos pero no en la base actual)
    END
GO

CREATE PROCEDURE [gd_esquema].cargar_productos AS
    BEGIN
        INSERT INTO [gd_esquema].BI_DIM_PRODUCTO (COD_PROD,NOMBRE_PROD,DESCRIPCION_PROD) 
        SELECT COD_PROD,NOMBRE_PROD,DESCRIPCION_PROD FROM [gd_esquema].[PRODUCTO]
    END
GO


CREATE PROCEDURE [gd_esquema].cargar_tipos_descuento AS
    BEGIN
        INSERT INTO [gd_esquema].BI_DIM_TIPO_DESCUENTO (TIPO_DESCUENTO) 
        VALUES ('FIJO'),('CUPON'),('MEDIO_PAGO')
    END
GO

CREATE PROCEDURE [gd_esquema].cargar_tipos_envio AS
    BEGIN
        INSERT INTO [gd_esquema].BI_DIM_TIPO_ENVIO (ID_MEDIO_ENVIO,MEDIO) 
        SELECT DISTINCT ID_MEDIO_ENVIO,MEDIO FROM [gd_esquema].[MEDIO_ENVIO_X_CODIGO_POSTAL] --hay q agregar cod postal? sino se repiten
    END
GO


CREATE PROCEDURE [gd_esquema].cargar_proveedores AS
    BEGIN
        INSERT INTO [gd_esquema].BI_DIM_PROVEEDOR (ID_PROVEEDOR,RAZON_SOCIAL_PROV) 
        SELECT DISTINCT CUIT_PROV,RAZON_SOCIAL_PROV FROM [gd_esquema].[PROVEEDOR]
    END
GO


CREATE PROCEDURE [gd_esquema].cargar_compras AS
    BEGIN
      DECLARE @fechaCompra DATE, @medioPagoId decimal(19,0),@totalCompra decimal(18,2),@cuit nvarchar(50), @codCompra decimal(19,0)
      DECLARE comc CURSOR FOR 
	  SELECT FECHA_COMPRA,ID_MEDIO_PAGO,TOTAL_COMPRA,CUIT_PROV,COD_COMPRA FROM [gd_esquema].COMPRA
      OPEN comc
      FETCH NEXT FROM comc INTO @fechaCompra, @medioPagoId,@totalCompra,@cuit,@codCompra
      WHILE(@@FETCH_STATUS = 0)
      BEGIN
        DECLARE @descuentos decimal(18,2)
        SET @descuentos = (SELECT SUM(MONTO_DESC_COMPRA) FROM [gd_esquema].COMPRA c
        JOIN [gd_esquema].DESCUENTO_X_COMPRA dc ON c.COD_COMPRA=dc.COD_COMPRA
        JOIN [gd_esquema].DESCUENTO_COMPRA d ON d.CODIGO_DESC_COMPRA=dc.CODIGO_DESC_COMPRA
        WHERE c.COD_COMPRA=@codCompra)

        DECLARE @cantidad decimal(19,0),@precioUnit decimal(18,2),@precioTotalProd decimal(18,2),@codigoProductoVar nvarchar(50)
        DECLARE comcp CURSOR FOR SELECT CANTIDAD,PRECIO_UNIT,PRECIO_TOTAL,COD_PRODUCTO_VARIANTE FROM [gd_esquema].COMPRA_PRODUCTO WHERE COD_COMPRA=@codCompra
        OPEN comcp
		FETCH NEXT FROM comcp INTO @cantidad,@precioUnit,@precioTotalProd,@codigoProductoVar
        WHILE(@@FETCH_STATUS = 0)
        BEGIN --si no existe el producto ponerlo y sino sumarle al total prod
          IF NOT EXISTS (SELECT 1 FROM [gd_esquema].BI_HECHOS_COMPRAS WHERE ID_FECHA = [gd_esquema].obtener_id_tiempo(@fechaCompra) 
          AND ID_PROVEEDOR = @cuit AND COD_PROD = [gd_esquema].obtener_codigo_producto(@codigoProductoVar))
          BEGIN
            INSERT INTO [gd_esquema].BI_HECHOS_COMPRAS (ID_FECHA,ID_PROVEEDOR,COD_PROD,TOTAL_PRODUCTO,CANTIDAD_PRODUCTO,TOTAL_COMPRA,TOTAL_DESCUENTO)
            VALUES ([gd_esquema].obtener_id_tiempo(@fechaCompra),@cuit,[gd_esquema].obtener_codigo_producto(@codigoProductoVar),@precioTotalProd,@cantidad,@totalCompra,@descuentos) --@codigoProductoVar no es codigo de producto, modelar variables?
          END
          ELSE
          BEGIN
            UPDATE [gd_esquema].BI_HECHOS_COMPRAS 
            SET CANTIDAD_PRODUCTO+=@cantidad,TOTAL_PRODUCTO+=@precioTotalProd,TOTAL_COMPRA+=@precioTotalProd
            WHERE ID_FECHA = [gd_esquema].obtener_id_tiempo(@fechaCompra) 
            AND ID_PROVEEDOR = @cuit AND COD_PROD = [gd_esquema].obtener_codigo_producto(@codigoProductoVar)
          END
          FETCH NEXT FROM comcp INTO @cantidad,@precioUnit,@precioTotalProd,@codigoProductoVar
        END
        CLOSE comcp
        DEALLOCATE comcp
        FETCH NEXT FROM comc INTO @fechaCompra, @medioPagoId,@totalCompra,@cuit,@codCompra
      END
      CLOSE comc
      DEALLOCATE comc
    END
GO


CREATE PROCEDURE [gd_esquema].cargar_ventas AS
    BEGIN
      DECLARE @codVenta decimal(19,0),@fecha DATE,@idCliente decimal(19,0),@idCanalVenta decimal(19,0),@idMedioEnvio decimal(19,0),
      @idMedioPago decimal(19,0),@totalVenta decimal(18,2),@precioEnvio decimal(18,2),@canalCosto decimal(18,2),@costoTransaccion decimal(18,2)
      DECLARE cven CURSOR FOR
      SELECT COD_VENTA,FECHA_VENTA,ID_CLIENTE,ID_CANAL_VENTA,ID_MEDIO_ENVIO,ID_MEDIO_PAGO,TOTAL_VENTA,PRECIO_ENVIO,CANAL_COSTO,COSTO_TRANSACCION
      FROM [gd_esquema].VENTA
      OPEN cven
      FETCH NEXT FROM cven INTO @codVenta,@fecha,@idCliente,@idCanalVenta,@idMedioEnvio,
      @idMedioPago ,@totalVenta ,@precioEnvio ,@canalCosto ,@costoTransaccion 
      WHILE(@@FETCH_STATUS = 0)
      BEGIN
        DECLARE @idDesc decimal(19,0),@idTiempo decimal(19,0),@valor decimal(18,2),@totalDescuento decimal(18,2)
        SET @totalDescuento=0
        DECLARE cccc CURSOR FOR 
        SELECT [gd_esquema].obtener_id_tipo_descuento('MEDIO_PAGO'),[gd_esquema].obtener_id_tiempo(@fecha),VALOR_DESC FROM MEDIO_DE_PAGO WHERE ID_MEDIO_PAGO=@idMedioPago
        UNION
        SELECT [gd_esquema].obtener_id_tipo_descuento('CUPON'),[gd_esquema].obtener_id_tiempo(@fecha),IMPORTE FROM VENTA_MEDIANTE_CUPON WHERE COD_VENTA=@codVenta
        UNION
        SELECT [gd_esquema].obtener_id_tipo_descuento('FIJO'),[gd_esquema].obtener_id_tiempo(@fecha),IMPORTE FROM VENTA_MEDIANTE_DESCUENTO_FIJO WHERE COD_VENTA=@codVenta
        OPEN cccc
        FETCH NEXT FROM cccc INTO @idDesc,@idTiempo,@valor
        WHILE(@@FETCH_STATUS=0)
        BEGIN
          INSERT INTO [gd_esquema].BI_HECHOS_DESCUENTOS (ID_TIPO_DESCUENTO,ID_FECHA,TOTAL_DESCUENTO)
          VALUES (@idDesc,@idTiempo,@valor) --guardarse ref a que venta pertenece, para mi van todas las fk de venta en esta tabla
          SET @totalDescuento+=@valor
        END
        --INSERT INTO [gd_esquema].BI_DIM_CANAL_VENTA 
        --(ID_FECHA,CODIGO_PROVINCIA,ID_RANGO_ETARIO,ID_CANAL_VENTA,ID_MEDIO_PAGO,ID_CATEGORIA
        --,COD_PROD,ID_DESC,ID_MEDIO_ENVIO,DESCUENTO_ID,TOTAL_VENTA,TOTAL_DESCUENTOS,
        --MEDIO_ENVIO_COSTO,MEDIO_PAGO_COSTO,CANAL_VENTA_COSTO,CANTIDAD_PRODUCTO,TOTAL_PRODUCTO)
        --VALUES([gd_esquema].obtener_id_tiempo(@fecha),[gd_esquema].obtener_id_provincia(@codVenta),[gd_esquema].obtener_id_rango_etario((SELECT FECHA_NAC_CLIENTE FROM CLIENTE WHERE ID_CLIENTE=@idCliente)),
        --@idCanalVenta,@idMedioPago,NULL,NULL,@idDesc,@totalVenta,
        --@totalDescuento,@precioEnvio,@costoTransaccion,@canalCosto,@cantidad,@totalProd)
        CLOSE cccc
        DEALLOCATE cccc

        DECLARE @cantidad decimal(19,0),@precioUnit decimal(18,2),@precioTotalProd decimal(18,2),@codProdVar nvarchar(50)
        DECLARE cvenp CURSOR FOR
        SELECT CANTIDAD,PRECIO_UNIT,PRECIO_TOTAL,COD_PRODUCTO_VARIANTE FROM [gd_esquema].VENTA_PRODUCTO WHERE COD_VENTA=@codVenta
        OPEN cvenp
        FETCH NEXT FROM cvenp INTO @cantidad,@precioUnit,@precioTotalProd,@codProdVar
        WHILE(@@FETCH_STATUS = 0)
        BEGIN
          IF NOT EXISTS (SELECT 1 FROM [gd_esquema].BI_HECHOS_VENTAS 
          WHERE ID_FECHA= [gd_esquema].obtener_id_tiempo(@fecha) AND CODIGO_PROVINCIA=[gd_esquema].obtener_id_provincia(@idMedioEnvio) 
          AND ID_RANGO_ETARIO=[gd_esquema].obtener_id_rango_etario((SELECT FECHA_NAC_CLIENTE FROM CLIENTE WHERE ID_CLIENTE=@idCliente))
          AND ID_CANAL_VENTA=@idCanalVenta AND ID_MEDIO_PAGO=@idMedioPago AND ID_CATEGORIA=[gd_esquema].obtener_id_categoria(@codProdVar)
          AND COD_PROD=[gd_esquema].obtener_codigo_producto(@codProdVar)
          AND ID_MEDIO_ENVIO=@idMedioEnvio)
          BEGIN
          INSERT INTO [gd_esquema].BI_HECHOS_VENTAS 
          (ID_FECHA,CODIGO_PROVINCIA,ID_RANGO_ETARIO,ID_CANAL_VENTA,ID_MEDIO_PAGO,ID_CATEGORIA
          ,COD_PROD,ID_MEDIO_ENVIO,DESCUENTO_ID,TOTAL_VENTA,TOTAL_DESCUENTOS,
          MEDIO_ENVIO_COSTO,MEDIO_PAGO_COSTO,CANAL_VENTA_COSTO,CANTIDAD_PRODUCTO,TOTAL_PRODUCTO)
          VALUES ([gd_esquema].obtener_id_tiempo(@fecha),[gd_esquema].obtener_id_provincia(@idMedioEnvio),[gd_esquema].obtener_id_rango_etario((SELECT FECHA_NAC_CLIENTE FROM CLIENTE WHERE ID_CLIENTE=@idCliente)),
          @idCanalVenta,@idMedioPago,[gd_esquema].obtener_id_categoria(@codProdVar),[gd_esquema].obtener_codigo_producto(@codProdVar),@idMedioEnvio,NULL,@totalVenta,
          @totalDescuento,@precioEnvio,@costoTransaccion,@canalCosto,@cantidad,@precioTotalProd)
          END --descuento TODO leer arriba
          ELSE
          BEGIN
            UPDATE [gd_esquema].BI_HECHOS_VENTAS
            SET TOTAL_VENTA+=@precioTotalProd, CANTIDAD_PRODUCTO+=@cantidad, TOTAL_PRODUCTO+=@precioTotalProd
            WHERE ID_FECHA= [gd_esquema].obtener_id_tiempo(@fecha) AND CODIGO_PROVINCIA=[gd_esquema].obtener_id_provincia(@idMedioEnvio) 
            AND ID_RANGO_ETARIO=[gd_esquema].obtener_id_rango_etario((SELECT FECHA_NAC_CLIENTE FROM CLIENTE WHERE ID_CLIENTE=@idCliente))
            AND ID_CANAL_VENTA=@idCanalVenta AND ID_MEDIO_PAGO=@idMedioPago AND ID_CATEGORIA=[gd_esquema].obtener_id_categoria(@codProdVar)
            AND COD_PROD=[gd_esquema].obtener_codigo_producto(@codProdVar)
            AND ID_MEDIO_ENVIO=@idMedioEnvio
          END
          FETCH NEXT FROM cvenp INTO @cantidad,@precioUnit,@precioTotalProd,@codProdVar

        END
        CLOSE cvenp
        DEALLOCATE cvenp
        
      END 
      CLOSE cven
      DEALLOCATE cven
    END
GO



--FUNCIONES

CREATE FUNCTION [gd_esquema].obtener_id_rango_etario(@fecha DATE) RETURNS DECIMAL(19,0) AS
	BEGIN
		DECLARE @edad_id DECIMAL(19,0), @edad INT, @fecha_actual DATE
		SELECT @edad = (DATEDIFF(DAY, @fecha, GETDATE()) / 365)

		SELECT @edad_id =
			CASE 
				WHEN @edad BETWEEN 0 AND 24 THEN (SELECT ID_RANGO_ETARIO FROM [gd_esquema].BI_DIM_RANGO_ETARIO WHERE RANGO_ETARIO = '<25')
				WHEN @edad BETWEEN 25 AND 34 THEN (SELECT ID_RANGO_ETARIO FROM [gd_esquema].BI_DIM_RANGO_ETARIO WHERE RANGO_ETARIO = '[25-35)')
        WHEN @edad BETWEEN 35 AND 55 THEN (SELECT ID_RANGO_ETARIO FROM [gd_esquema].BI_DIM_RANGO_ETARIO WHERE RANGO_ETARIO = '[35-55]')
				ELSE (SELECT ID_RANGO_ETARIO FROM [gd_esquema].BI_DIM_RANGO_ETARIO WHERE RANGO_ETARIO = '>55')
			END

		RETURN @edad_id
	END
GO

CREATE FUNCTION [gd_esquema].obtener_id_tiempo(@fecha DATE) RETURNS DECIMAL(19,0) AS
	BEGIN
    DECLARE @anioFecha INT, @mesFecha INT, @idTiempo INT

    SET @anioFecha = DATEPART(YEAR, @fecha)
    SET @mesFecha = DATEPART(MONTH, @fecha)

    SELECT @idTiempo = ID_FECHA
    FROM [gd_esquema].BI_DIM_TIEMPO
    WHERE ANIO = @anioFecha AND MES = @mesFecha

    RETURN @idTiempo
  END
GO

CREATE FUNCTION [gd_esquema].obtener_rentabilidad_producto(@idProd decimal(19,0)) RETURNS DECIMAL(18,2) AS
  BEGIN
    DECLARE @rentabilidad decimal(19,0)
    SET @rentabilidad = (SELECT (SUM(v.TOTAL_PRODUCTO)-SUM(c.TOTAL_COMPRA))/SUM(v.TOTAL_PRODUCTO)
    FROM [gd_esquema].BI_HECHOS_VENTAS v 
    JOIN [gd_esquema].BI_HECHOS_COMPRAS c ON v.COD_PROD=c.COD_PROD
    JOIN [gd_esquema].BI_DIM_TIEMPO t ON v.ID_FECHA=t.ID_FECHA
    WHERE t.ANIO = YEAR(GETDATE()))

    RETURN @rentabilidad
  END
GO

CREATE FUNCTION [gd_esquema].obtener_id_tipo_descuento(@tipoDesc char(20)) RETURNS DECIMAL(19,0) AS
  BEGIN
    DECLARE @id DECIMAL(19,0)
    SET @id = (SELECT ID_TIPO_DESCUENTO FROM [gd_esquema].BI_DIM_TIPO_DESCUENTO WHERE TIPO_DESCUENTO=@tipoDesc)
    RETURN @id
  END
GO


CREATE FUNCTION [gd_esquema].obtener_cant_ventas() RETURNS DECIMAL(19,0) AS
  BEGIN
    DECLARE @cant DECIMAL(19,0)
    SELECT @cant=COUNT(*) FROM (SELECT DISTINCT ID_FECHA,CODIGO_PROVINCIA,ID_RANGO_ETARIO,ID_CANAL_VENTA,ID_MEDIO_PAGO,ID_MEDIO_ENVIO FROM [gd_esquema].BI_HECHOS_VENTAS) Tabla
    RETURN @cant
  END
GO


CREATE FUNCTION [gd_esquema].obtener_cant_ventas_x_provincia(@codProd decimal(19,0)) RETURNS DECIMAL(19,0) AS
  BEGIN
    DECLARE @cant DECIMAL(19,0)
    SET @cant = (SELECT COUNT(*) FROM (SELECT DISTINCT ID_FECHA,CODIGO_PROVINCIA,ID_RANGO_ETARIO,ID_CANAL_VENTA,ID_MEDIO_PAGO,ID_MEDIO_ENVIO 
	FROM [gd_esquema].BI_HECHOS_VENTAS ventas 
	WHERE ventas.CODIGO_PROVINCIA = @codProd) AS s)
    RETURN @cant
  END
GO

CREATE FUNCTION [gd_esquema].obtener_cant_ventas_x_mes_y_anio(@mes decimal(2,0), @anio decimal(4,0)) RETURNS DECIMAL(19,0) AS
  BEGIN
    DECLARE @cant DECIMAL(19,0)
    SET @cant= (SELECT COUNT(*) FROM 
    (
    SELECT DISTINCT venta.ID_FECHA,CODIGO_PROVINCIA,ID_RANGO_ETARIO,ID_CANAL_VENTA,ID_MEDIO_PAGO,ID_MEDIO_ENVIO 
	FROM [gd_esquema].BI_HECHOS_VENTAS venta 
	JOIN [gd_esquema].[BI_DIM_TIEMPO] fecha ON ( venta.ID_FECHA = fecha.ID_FECHA ) 
	WHERE fecha.MES = @mes AND fecha.ANIO = @anio
    ) Tabla )
    RETURN @cant
  END
GO

CREATE FUNCTION [gd_esquema].obtener_id_provincia(@idMedioEnvio decimal(19,0)) RETURNS DECIMAL(19,0) AS
  BEGIN
  DECLARE @codProd DECIMAL(19,0)
  SET @codProd = (SELECT cp.CODIGO_PROVINCIA FROM [gd_esquema].MEDIO_ENVIO_X_CODIGO_POSTAL m
  JOIN [gd_esquema].CODIGO_POSTAL cp ON m.CODIGO_POSTAL=cp.CODIGO_POSTAL
  WHERE m.ID_MEDIO_ENVIO=@idMedioEnvio)
  RETURN @codProd
  END
GO

CREATE FUNCTION [gd_esquema].obtener_id_categoria(@codProdVar nvarchar(50))  RETURNS DECIMAL(19,0) AS
  BEGIN
  DECLARE @idCat decimal(19,0)
  SET @idCat = (SELECT ID_CATEGORIA_PROD FROM [gd_esquema].PRODUCTO_VARIANTE pv
  JOIN [gd_esquema].PRODUCTO p ON pv.COD_PROD=p.COD_PROD
  WHERE pv.COD_PRODUCTO_VARIANTE=@codProdVar)
  RETURN @idCat
  END
GO

CREATE FUNCTION [gd_esquema].obtener_codigo_producto(@codProdVar nvarchar(50)) RETURNS nvarchar(50) AS
  BEGIN
  DECLARE @codProd nvarchar(50)
  SET @codProd = (SELECT COD_PROD FROM [gd_esquema].PRODUCTO_VARIANTE pv
  WHERE pv.COD_PRODUCTO_VARIANTE=@codProdVar)
  RETURN @codProd
  END
GO


CREATE PROCEDURE [gd_esquema].insertar_todo_bi
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION
		exec [gd_esquema].cargar_tiempo
		exec [gd_esquema].cargar_rangos_etarios
    exec [gd_esquema].cargar_provincias
    exec [gd_esquema].cargar_canales_venta
    exec [gd_esquema].cargar_medios_pago
    exec [gd_esquema].cargar_categorias_prod
    exec [gd_esquema].cargar_productos
    exec [gd_esquema].cargar_tipos_descuento
    exec [gd_esquema].cargar_tipos_envio
    exec [gd_esquema].cargar_proveedores
    exec [gd_esquema].cargar_compras
    exec [gd_esquema].cargar_ventas
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

EXEC [gd_esquema].insertar_todo_bi

GO


--VISTAS

/*
Las ganancias mensuales de cada canal de venta.
Se entiende por ganancias al total de las ventas, menos el total de las
compras, menos los costos de transacción totales aplicados asociados los
medios de pagos utilizados en las mismas.
*/

CREATE VIEW [gd_esquema].ganancias_mensuales_x_canal_venta (CANAL_VENTA, MES, ANIO, TOTAL_VENTAS,TOTAL_COMPRAS, TOTAL_NETO)
AS
    SELECT cv.CANAL_VENTA,t.MES,t.ANIO,SUM(v.TOTAL_VENTA) TOTAL_VENTA, 
    SUM(c.TOTAL_COMPRA) TOTAL_COMPRA, 
    (SUM(v.TOTAL_VENTA)-SUM(c.TOTAL_COMPRA)-v.MEDIO_ENVIO_COSTO-v.CANAL_VENTA_COSTO) TOTAL_NETO
    FROM [gd_esquema].BI_HECHOS_VENTAS v
    JOIN [gd_esquema].BI_DIM_TIEMPO t ON t.ID_FECHA = v.ID_FECHA
    JOIN [gd_esquema].BI_HECHOS_COMPRAS c ON c.ID_FECHA = t.ID_FECHA
    JOIN [gd_esquema].BI_DIM_CANAL_VENTA cv ON v.ID_CANAL_VENTA = cv.ID_CANAL_VENTA
    GROUP BY CANAL_VENTA,MES,ANIO,v.MEDIO_ENVIO_COSTO,v.CANAL_VENTA_COSTO
GO
-- Los 5 productos con mayor rentabilidad anual, con sus respectivos %
-- Se entiende por rentabilidad a los ingresos generados por el producto
-- (ventas) durante el periodo menos la inversión realizada en el producto
-- (compras) durante el periodo, todo esto sobre dichos ingresos.
-- Valor expresado en porcentaje.
-- Para simplificar, no es necesario tener en cuenta los descuentos aplicados.

CREATE VIEW [gd_esquema].top_5_productos_x_rentabilidad (NOMBRE_PRODUCTO,RENTABILIDAD)
AS
  
  SELECT TOP 5 NOMBRE_PROD,[gd_esquema].obtener_rentabilidad_producto(COD_PROD) RENTABILIDAD
  FROM [gd_esquema].BI_DIM_PRODUCTO
  ORDER BY [gd_esquema].obtener_rentabilidad_producto(COD_PROD)
  
GO


-- Las 5 categorías de productos más vendidos por rango etario de clientes
-- por mes.

CREATE VIEW [gd_esquema].top_5_categorias_x_rango_etario_x_mes (RANGO_ETARIO,CATEGORIA,MES,ANIO,CANTIDAD_PRODUCTO,RANKING) --cuando se haga el select de la vista poner where ranking <= 5
AS
    SELECT 
    r.RANGO_ETARIO,
    c.CATEGORIA,
    MES,
    ANIO,
    COUNT(CANTIDAD_PRODUCTO),
    ROW_NUMBER() OVER (PARTITION BY 3 Order by COUNT(CANTIDAD_PRODUCTO) DESC) AS RANKING
    FROM [gd_esquema].BI_HECHOS_VENTAS v
    JOIN [gd_esquema].BI_DIM_TIEMPO t ON t.ID_FECHA = v.ID_FECHA
	JOIN [gd_esquema].BI_DIM_RANGO_ETARIO r ON v.ID_RANGO_ETARIO=r.ID_RANGO_ETARIO
	JOIN [gd_esquema].BI_DIM_CATEGORIA_PRODUCTO c ON c.ID_CATEGORIA=v.ID_CATEGORIA
	GROUP BY r.RANGO_ETARIO,c.CATEGORIA,MES,ANIO
GO


-- Total de Ingresos por cada medio de pago por mes, descontando los costos
-- por medio de pago (en caso que aplique) y descuentos por medio de pago
-- (en caso que aplique)

CREATE VIEW [gd_esquema].total_ingresos_medio_pago_x_mes (MEDIO_PAGO,MES,ANIO,TOTAL_INGRESOS)
AS
  
    SELECT 
	  mp.MEDIO_PAGO,
    MES,
    ANIO,
    SUM(TOTAL_PRODUCTO) - SUM(MEDIO_PAGO_COSTO) - SUM(TOTAL_DESCUENTOS) --ventas repetidas no se si afectan o no
    FROM [gd_esquema].BI_HECHOS_VENTAS v
    JOIN [gd_esquema].BI_DIM_TIEMPO t ON t.ID_FECHA = v.ID_FECHA
	  JOIN [gd_esquema].BI_DIM_MEDIO_PAGO mp ON mp.ID_MEDIO_PAGO=v.ID_MEDIO_PAGO
    GROUP BY MEDIO_PAGO,MES,ANIO
  
GO


-- Importe total en descuentos aplicados según su tipo de descuento, por
-- canal de venta, por mes. Se entiende por tipo de descuento como los
-- correspondientes a envío, medio de pago, cupones, etc)

CREATE VIEW [gd_esquema].importe_total_segun_descuento (IMPORTE_TOTAL, TIPO_DE_DESCUENTO, CANAL_DE_VENTA, MES)
AS
  
    SELECT SUM(descuento.TOTAL_DESCUENTO), tipo.TIPO_DESCUENTO, canal_venta.CANAL_VENTA, fecha.MES 
    FROM [gd_esquema].[BI_HECHOS_DESCUENTOS] descuento
    JOIN [gd_esquema].[BI_DIM_TIPO_DESCUENTO] tipo ON (descuento.ID_TIPO_DESCUENTO = tipo.ID_TIPO_DESCUENTO)
    JOIN [gd_esquema].[BI_HECHOS_VENTAS] venta ON (venta.DESCUENTO_ID = descuento.DESCUENTO_ID)
    JOIN [gd_esquema].[BI_DIM_CANAL_VENTA] canal_venta ON (venta.ID_CANAL_VENTA = canal_venta.ID_CANAL_VENTA)
    JOIN [gd_esquema].[BI_DIM_TIEMPO] fecha ON (fecha.ID_FECHA = descuento.ID_FECHA)
    GROUP BY tipo.TIPO_DESCUENTO, canal_venta.CANAL_VENTA, fecha.MES
GO  



-- Porcentaje de envíos realizados a cada Provincia por mes. El porcentaje
-- debe representar la cantidad de envíos realizados a cada provincia sobre
-- total de envío mensuales.

CREATE VIEW [gd_esquema].porcentaje_envio_realizado_provincia_x_mes(PROVINCIA, PORCENTAJE, MES, ANIO)
AS
  

    SELECT p.NOMBRE_PROV,

    [gd_esquema].obtener_cant_ventas_x_provincia(p.CODIGO_PROVINCIA) / [gd_esquema].obtener_cant_ventas_x_mes_y_anio(f.MES, f.ANIO)

    PORCENTAJE,

    f.MES,
    f.ANIO
    FROM [gd_esquema].BI_DIM_PROVINCIA p
    JOIN [gd_esquema].BI_HECHOS_VENTAS v ON ( v.CODIGO_PROVINCIA = p.CODIGO_PROVINCIA )
    JOIN [gd_esquema].[BI_DIM_TIEMPO] f ON ( v.ID_FECHA = f.ID_FECHA)
GO  


-- Valor promedio de envío por Provincia por Medio De Envío anual.

CREATE VIEW [gd_esquema].valor_promedio_envio_por_medio_por_provincia_anual (ANIO, MEDIO_DE_ENVIO,PROVINCIA, VALOR_PROMEDIO)
AS
  
    SELECT t.ANIO, e.MEDIO, p.NOMBRE_PROV, 
    (SELECT SUM(MEDIO_ENVIO_COSTO)/COUNT(ID_MEDIO_ENVIO) FROM [gd_esquema].[BI_HECHOS_VENTAS])
    FROM [gd_esquema].[BI_HECHOS_VENTAS] v 
    JOIN [gd_esquema].[BI_DIM_TIEMPO] t ON v.ID_FECHA = t.ID_FECHA
    JOIN [gd_esquema].[BI_DIM_TIPO_ENVIO] e ON v.ID_MEDIO_ENVIO = e.ID_MEDIO_ENVIO
	JOIN [gd_esquema].BI_DIM_PROVINCIA p ON p.CODIGO_PROVINCIA=v.CODIGO_PROVINCIA
    GROUP BY t.ANIO, e.MEDIO, p.NOMBRE_PROV
GO



-- Aumento promedio de precios de cada proveedor anual. Para calcular este
-- indicador se debe tomar como referencia el máximo precio por año menos
-- el mínimo todo esto divido el mínimo precio del año. Teniendo en cuenta
-- que los precios siempre van en aumento.

CREATE VIEW [gd_esquema].aumento_promedio_precios_x_proveedor_anual ( RAZON_SOCIAL, AUMENTO_PROMEDIO, ANIO)
AS
    SELECT p.RAZON_SOCIAL_PROV,
    (max(c.TOTAL_PRODUCTO) - min(c.TOTAL_PRODUCTO)) / (min(c.TOTAL_PRODUCTO)),
    f.ANIO
    FROM [gd_esquema].[BI_HECHOS_COMPRAS] c
    JOIN [gd_esquema].[BI_DIM_TIEMPO] f ON c.ID_FECHA=f.ID_FECHA
    JOIN [gd_esquema].[BI_DIM_PROVEEDOR] p ON (p.ID_PROVEEDOR = c.ID_PROVEEDOR)
    GROUP BY p.RAZON_SOCIAL_PROV, f.ANIO
GO  

-- Los 3 productos con mayor cantidad de reposición por mes.
CREATE VIEW [gd_esquema].top_3_prod_mayor_reposicion_x_mes (PRODUCTO,MES,ANIO,CANTIDAD_COMPRADA,RANKING) 
AS
  
	SELECT NOMBRE_PROD,
	MES,
	ANIO,
	SUM(CANTIDAD_PRODUCTO) CANTIDAD_COMPRADA,
	ROW_NUMBER() OVER (PARTITION BY MES,ANIO Order by SUM(CANTIDAD_PRODUCTO) DESC) AS Ranking --TOP 3 EN EL SELECT
	FROM [gd_esquema].BI_HECHOS_COMPRAS c
	JOIN [gd_esquema].BI_DIM_PRODUCTO p ON p.COD_PROD=c.COD_PROD
	JOIN [gd_esquema].BI_DIM_TIEMPO t ON c.ID_FECHA=t.ID_FECHA
	GROUP BY NOMBRE_PROD,MES,ANIO 
  
GO

-- SELECT DE LAS VISTAS

SELECT * FROM [gd_esquema].ganancias_mensuales_x_canal_venta

SELECT * FROM [gd_esquema].top_5_productos_x_rentabilidad

SELECT * FROM [gd_esquema].top_5_categorias_x_rango_etario_x_mes WHERE RANKING <= 5

SELECT * FROM [gd_esquema].total_ingresos_medio_pago_x_mes

SELECT * FROM [gd_esquema].importe_total_segun_descuento

SELECT * FROM [gd_esquema].valor_promedio_envio_por_medio_por_provincia_anual 

SELECT * FROM [gd_esquema].aumento_promedio_precios_x_proveedor_anual

SELECT * FROM [gd_esquema].top_3_prod_mayor_reposicion_x_mes WHERE RANKING <= 3