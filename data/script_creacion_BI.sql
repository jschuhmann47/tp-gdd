--USE [GD2C2022]
--GO


CREATE TABLE [gd_esquema].[BI_DIM_TIEMPO](
    [ID_FECHA] decimal(19,0) IDENTITY(1,1),
    [MES] decimal(2,0),
    [ANIO] decimal(4,0),
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
  [ID_TIPO_DESCUENTO] decimal(19,0) IDENTITY(1,1),
  [TIPO_DESCUENTO] char(20), -- COMPRA, VENTA, MEDIO_PAGO, CUPON,etc
  PRIMARY KEY ([ID_TIPO_DESCUENTO])
);

GO

CREATE TABLE [gd_esquema].[BI_DIM_TIPO_ENVIO](
  [ID_MEDIO_ENVIO] decimal(19,0),
  [MEDIO] nvarchar(255),
  PRIMARY KEY ([ID_MEDIO_ENVIO])
);

CREATE TABLE [gd_esquema].[BI_DIM_PROVEEDOR](
  [ID_PROVEEDOR] decimal(19,0), --pk no identity
  [RAZON_SOCIAL_PROV] nvarchar(255)
)

CREATE TABLE [gd_esquema].[BI_HECHOS_COMPRAS](
    [ID_FECHA] decimal(19,0), --fk
    [ID_PROVEEDOR] decimal(19,0), --fk
    [COD_PROD] nvarchar(50), --fk
    [TOTAL_PRODUCTO] decimal(18,2),
    [CANTIDAD_PRODUCTO] decimal(19,0),
    [TOTAL_COMPRA] decimal(18,2), --NETO
    [TOTAL_DESCUENTO] decimal(18,2)
);

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
    [TOTAL_PRODUCTO] decimal(18,2)
);

CREATE TABLE [gd_esquema].[BI_HECHOS_DESCUENTOS]( --de ventas
    [DESCUENTO_ID] DECIMAL(19,0) IDENTITY(1,1) --PK
    [ID_TIPO_DESCUENTO] decimal(19,0), --FK
    [ID_FECHA] DECIMAL(19,0) --fk
    [TOTAL_DESCUENTO] DECIMAL(18,2)
);


GO

ALTER TABLE [gd_esquema].[BI_HECHOS_COMPRAVENTA] ADD CONSTRAINT [ID_FECHA] FOREIGN KEY ([ID_FECHA]) REFERENCES [gd_esquema].[BI_DIM_TIEMPO]([ID_FECHA])
--etc
--TODO


--MIGRACION


CREATE PROCEDURE [gd_esquema].cargar_tiempo AS
    BEGIN
        INSERT INTO [gd_esquema].BI_DIM_TIEMPO (MES, ANIO)
            SELECT DISTINCT YEAR(FECHA_COMPRA), MONTH(FECHA_COMPRA)
                FROM [gd_esquema].COMPRA
            UNION
             SELECT DISTINCT YEAR(FECHA_VENTA), MONTH(FECHA_VENTA)
                FROM [gd_esquema].VENTA
            UNION
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
        INSERT INTO [gd_esquema].BI_DIM_MEDIO_PAGO (ID_MEDIO_PAGO,MEDIO_PAGO) 
        SELECT ID_MEDIO_PAGO,MEDIO_PAGO FROM [gd_esquema].[MEDIO_PAGO]
    END
GO


CREATE PROCEDURE [gd_esquema].cargar_medios_pago AS
    BEGIN
        INSERT INTO [gd_esquema].BI_DIM_MEDIO_PAGO (ID_CATEGORIA,MEDIO_PAGO) 
        SELECT ID_MEDIO_PAGO,MEDIO_PAGO FROM [gd_esquema].[MEDIO_PAGO]
    END
GO


CREATE PROCEDURE [gd_esquema].cargar_categorias_prod AS
    BEGIN
        INSERT INTO [gd_esquema].BI_DIM_CATEGORIA_PRODUCTO (ID_CATEGORIA,CATEGORIA) 
        SELECT ID_CATEGORIA,CATEGORIA FROM [gd_esquema].[CATEGORIA]
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
        VALUES ('FIJO'),('CUPON'),('MEDIO_PAGO') --ver si faltan TODO
    END
GO

CREATE PROCEDURE [gd_esquema].cargar_tipos_envio AS
    BEGIN
        INSERT INTO [gd_esquema].BI_DIM_TIPO_ENVIO (ID_MEDIO_ENVIO,MEDIO) 
        SELECT DISTINCT ID_MEDIO_ENVIO,MEDIO FROM [gd_esquema].[MEDIO_ENVIO_X_CODIGO_POSTAL]
    END
GO


CREATE PROCEDURE [gd_esquema].cargar_proveedores AS
    BEGIN
        INSERT INTO [gd_esquema].BI_DIM_PROVEEDOR (ID_PROVEEDOR,RAZON_SOCIAL_PROV) 
        SELECT DISTINCT CUIT_PROV,RAZON_SOCIAL_PROV FROM [gd_esquema].[MEDIO_ENVIO_X_CODIGO_POSTAL]
    END
GO


CREATE PROCEDURE [gd_esquema].cargar_compras AS
    BEGIN
      DECLARE @fechaCompra DATE, @medioPagoId decimal(19,0),@totalCompra decimal(18,2),@cuit nvarchar(50)
      DECLARE comc CURSOR FOR SELECT FECHA_COMPRA,ID_MEDIO_PAGO,TOTAL_COMPRA,CUIT_PROV FROM [gd_esquema].COMPRA
      OPEN comc
      FETCH NEXT FROM comc INTO @fechaCompra, @medioPagoId,@totalCompra,@cuit
      WHILE(@@FETCH_STATUS = 0)
      BEGIN
        DECLARE @descuentos decimal(18,2)
        SET @descuentos = SELECT SUM(MONTO_DESC_COMPRA) FROM [gd_esquema].COMPRA c
        JOIN [gd_esquema].DESCUENTO_X_COMPRA dc ON c.COD_COMPRA=dc.COD_COMPRA
        JOIN [gd_esquema].DESCUENTO_COMPRA d ON d.CODIGO_DESC_COMPRA=dc.CODIGO_DESC_COMPRA
        WHERE c.COD_COMPRA=@codCompra

        DECLARE @cantidad decimal(19,0),@precioUnit decimal(18,2),@precioTotalProd decimal(18,2),@codigoProductoVar nvarchar(50)
        DECLARE comcp CURSOR FOR SELECT CANTIDAD,PRECIO_UNIT,PRECIO_TOTAL,COD_PRODUCTO_VARIANTE FROM [gd_esquema].COMPRA_PRODUCTO WHERE COD_COMPRA=@codCompra
        FETCH NEXT FROM comcp INTO @cantidad,@precioUnit,@precioTotalProd,@codigoProductoVar
        WHILE(@@FETCH_STATUS = 0)
        BEGIN
          INSERT INTO [gd_esquema].BI_HECHOS_COMPRAS (ID_FECHA,ID_PROVEEDOR,COD_PROD,TOTAL_PRODUCTO,CANTIDAD_PRODUCTO,TOTAL_COMPRA,TOTAL_DESCUENTO)
          VALUES (obtener_id_tiempo(@fechaCompra),@cuit,@codigoProductoVar,@precioTotalProd,@cantidad,@totalCompra,@descuento)
          FETCH NEXT FROM comcp INTO @cantidad,@precioUnit,@precioTotalProd,@codigoProductoVar
        END
        CLOSE comcp
        DEALLOCATE comcp
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
        SELECT(obtener_id_tipo_descuento('MEDIO_PAGO'),obtener_id_tiempo(@fecha),VALOR_DESC) FROM MEDIO_DE_PAGO WHERE ID_MEDIO_PAGO=@idMedioPago
        UNION
        SELECT(obtener_id_tipo_descuento('CUPON'),obtener_id_tiempo(@fecha),IMPORTE) FROM VENTA_MEDIANTE_CUPON WHERE COD_VENTA=@codVenta
        UNION
        SELECT(obtener_id_tipo_descuento('FIJO'),obtener_id_tiempo(@fecha),IMPORTE) FROM VENTA_MEDIANTE_DESCUENTO_FIJO WHERE COD_VENTA=@codVenta
        OPEN cccc
        FETCH NEXT FROM cccc INTO @idDesc,@idTiempo,@valor
        WHILE(@@FETCH_STATUS=0)
        BEGIN
          INSERT INTO [gd_esquema].BI_HECHOS_DESCUENTOS (ID_TIPO_DESCUENTO,ID_FECHA,TOTAL_DESCUENTO)
          VALUES (@idDesc,@idTiempo,@valor)
          SET @totalDescuento+=@valor
        END
        INSERT INTO [gd_esquema].BI_DIM_CANAL_VENTA 
        (ID_FECHA,CODIGO_PROVINCIA,ID_RANGO_ETARIO,ID_CANAL_VENTA,ID_MEDIO_PAGO,ID_CATEGORIA
        ,COD_PROD,ID_DESC,ID_MEDIO_ENVIO,DESCUENTO_ID,TOTAL_VENTA,TOTAL_DESCUENTOS,
        MEDIO_ENVIO_COSTO,MEDIO_PAGO_COSTO,CANAL_VENTA_COSTO,CANTIDAD_PRODUCTO,TOTAL_PRODUCTO)
        VALUES(obtener_id_tiempo(@fecha),@codProvincia,obtener_id_rango_etario((SELECT FECHA_NAC_CLIENTE FROM CLIENTE WHERE ID_CLIENTE=@idCliente)),
        @idCanalVenta,@idMedioPago,NULL,NULL,@idDesc,@totalVenta,
        @totalDescuento,@precioEnvio,@costoTransaccion,@canalCosto,@cantidad,@totalProd)
        CLOSE cccc
        DEALLOCATE cccc

        DECLARE @cantidad decimal(19,0),@precioUnit decimal(18,2),@precioTotalProd decimal(18,2),@codProdVar nvarchar(50)
        DECLARE cvenp CURSOR FOR
        SELECT CANTIDAD,PRECIO_UNIT,PRECIO_TOTAL,COD_PRODUCTO_VARIANTE FROM [gd_esquema].VENTA_PRODUCTO WHERE COD_VENTA=@codVenta
        OPEN cvenp
        FETCH NEXT FROM cvenp INTO @cantidad,@precioUnit,@precioTotalProd,@codProdVar
        WHILE(@@FETCH_STATUS = 0)
        BEGIN
          INSERT INTO [gd_esquema].BI_DIM_CANAL_VENTA 
          (ID_FECHA,CODIGO_PROVINCIA,ID_RANGO_ETARIO,ID_CANAL_VENTA,ID_MEDIO_PAGO,ID_CATEGORIA
          ,COD_PROD,ID_MEDIO_ENVIO,DESCUENTO_ID,TOTAL_VENTA,TOTAL_DESCUENTOS,
          MEDIO_ENVIO_COSTO,MEDIO_PAGO_COSTO,CANAL_VENTA_COSTO,CANTIDAD_PRODUCTO,TOTAL_PRODUCTO)
          VALUES(obtener_id_tiempo(@fecha),@codProvincia,obtener_id_rango_etario((SELECT FECHA_NAC_CLIENTE FROM CLIENTE WHERE ID_CLIENTE=@idCliente)),
          @idCanalVenta,@idMedioPago,(SELECT ID_CATEGORIA FROM CATEGORIA WHERE CATEGORIA=@categoria),@codProdVar,@idMedioEnvio,NULL,@totalVenta,
          @totalDescuento,@precioEnvio,@costoTransaccion,@canalCosto,@cantidad,@totalProd)
          FETCH NEXT FROM cvenp INTO VARIABLES2
        END
        CLOSE cvenp
        DEALLOCATE cvenp

        
      END 
      CLOSE cven
      DEALLOCATE cven
    END
GO

/*
    [ID_FECHA] decimal(19,0), --fk
    [CODIGO_PROVINCIA] decimal(19,0), --fk
    [ID_RANGO_ETARIO] decimal(19,0), --fk
    [ID_CANAL_VENTA] decimal(19,0), --fk
    [ID_MEDIO_PAGO] decimal(19,0), --fk
    [ID_CATEGORIA] decimal(19,0), --fk
    [COD_PROD] nvarchar(50), --fk
    [ID_DESC] decimal(19,0), --fk
    [ID_MEDIO_ENVIO] decimal(19,0), --fk
    [DESCUENTO_ID] decimal(19,0), --fk
    [TOTAL_VENTA] decimal(18,2), --NETO
    [TOTAL_DESCUENTOS] decimal(18,2),
    [MEDIO_ENVIO_COSTO] decimal(18,2),
    [MEDIO_PAGO_COSTO] decimal(18,2),
    [CANAL_VENTA_COSTO] decimal(18,2),
    [CANTIDAD_PRODUCTO] decimal(19,0),
    [TOTAL_PRODUCTO] decimal(18,2)
*/



--VISTAS

/*
Las ganancias mensuales de cada canal de venta.
Se entiende por ganancias al total de las ventas, menos el total de las
compras, menos los costos de transacción totales aplicados asociados los
medios de pagos utilizados en las mismas.
*/

CREATE VIEW ganancias_mensuales_x_canal_venta (CANAL_VENTA, MES, ANIO, TOTAL_VENTAS,TOTAL_COMPRAS, TOTAL_NETO)
AS
  BEGIN
    SELECT cv.CANAL_VENTA,t.MES,t.ANIO,SUM(v.TOTAL_VENTA) TOTAL_VENTA, 
    SUM(c.TOTAL_COMPRA) TOTAL_COMPRA, 
    SUM(v.TOTAL_VENTA)-SUM(c.TOTAL_COMPRA)-v.MEDIO_ENVIO_COSTO-v.CANAL_VENTA_COSTO TOTAL_NETO
    FROM [gd_esquema].BI_HECHOS_VENTAS v
    JOIN [gd_esquema].BI_DIM_TIEMPO t ON t.ID_FECHA = v.ID_FECHA
    JOIN [gd_esquema].BI_HECHOS_COMPRAS c ON c.ID_FECHA = t.ID_FECHA
    JOIN [gd_esquema].BI_DIM_CANAL_VENTA cv ON v.ID_CANAL_VENTA = cv.ID_CANAL_VENTA
    GROUP BY CANAL_VENTA,MES,ANIO
  END
GO
-- Los 5 productos con mayor rentabilidad anual, con sus respectivos %
-- Se entiende por rentabilidad a los ingresos generados por el producto
-- (ventas) durante el periodo menos la inversión realizada en el producto
-- (compras) durante el periodo, todo esto sobre dichos ingresos.
-- Valor expresado en porcentaje.
-- Para simplificar, no es necesario tener en cuenta los descuentos aplicados.

CREATE VIEW top_5_productos_x_rentabilidad (NOMBRE_PRODUCTO,RENTABILIDAD)
AS
  BEGIN
  SELECT TOP 5 NOMBRE_PROD,obtener_rentabilidad_producto(COD_PROD) RENTABILIDAD
  ORDER BY obtener_rentabilidad_producto(COD_PROD)
  END
GO


-- Las 5 categorías de productos más vendidos por rango etario de clientes
-- por mes.
--VER NOMBRE WHERE  join tiempo
CREATE VIEW top_5_categorias_x_rango_etario_x_mes (RANGO_ETARIO,CANTIDAD_PRODUCTO,RANKING)
AS
  BEGIN
    SELECT 
    (SELECT RANGO_ETARIO FROM [gd_esquema].BI_DIM_RANGO_ETARIO WHERE ID_RANGO_ETARIO=obtener_id_rango_etario(fecha_nac)), --de donde sale la fecha
    CATEGORIA,
    MES,
    ANIO,
    COUNT(CANTIDAD_PRODUCTO),
    ROW_NUMBER() OVER (PARTITION BY CATEGORIA Order by COUNT(CANTIDAD_PRODUCTO) DESC) AS Ranking
    FROM [gd_esquema].BI_HECHOS_VENTAS v
    JOIN [gd_esquema].BI_DIM_TIEMPO t ON t.ID_FECHA = v.ID_FECHA
    WHERE Ranking <=5
    GROUP BY RANGO_ETARIO,CATEGORIA,MES,ANIO
  END
GO


-- Total de Ingresos por cada medio de pago por mes, descontando los costos
-- por medio de pago (en caso que aplique) y descuentos por medio de pago
-- (en caso que aplique)
--VER NOMBRE WHERE
--VER FUNCION SUM
CREATE VIEW total_ingresos_medio_pago_x_mes (...)
AS
  BEGIN
    SELECT (SELECT MEDIO FROM [gd_esquema].BI_DIM_MEDIO_PAGO m WHERE ID_MEDIO_PAGO=m.ID_MEDIO_PAGO),
    MES,
    ANIO,
    SUM(TOTAL_PRODUCTO) - SUM(MEDIO_PAGO_COSTO (asi no deberia sumarse, sumar uno por cada venta)) - SUM(DESCUENTOS TODO)
    FROM [gd_esquema].BI_HECHOS_VENTAS v
    JOIN [gd_esquema].BI_DIM_TIEMPO t ON t.ID_FECHA = v.ID_FECHA
    GROUP BY MEDIO_PAGO,MES,ANIO
  END
GO


-- Importe total en descuentos aplicados según su tipo de descuento, por
-- canal de venta, por mes. Se entiende por tipo de descuento como los
-- correspondientes a envío, medio de pago, cupones, etc)

CREATE VIEW importe_total_segun_descuento (IMPORTE_TOTAL, TIPO_DE_DESCUENTO, CANAL_DE_VENTA, MES)
AS
  BEGIN

        SELECT descuento.TOTAL_DESCUENTO, tipo.TIPO_DESCUENTO, canal_venta.CANAL_VENTA, fecha.MES 
        FROM [gd_esquema].[BI_HECHOS_DESCUENTOS] descuento
        JOIN [gd_esquema].[BI_DIM_TIPO_DESCUENTO] tipo ON (descuento.ID_TIPO_DESCUENTO = tipo.ID_TIPO_DESCUENTO)
        JOIN [gd_esquema].[BI_HECHOS_VENTAS] venta ON (venta.ID_DESC = descuento.DESCUENTO_ID)
        JOIN [gd_esquema].[BI_DIM_CANAL_VENTA] canal_venta ON (venta.ID_CANAL_VENTA = canal_venta.ID_CANAL_VENTA)
        JOIN [gd_esquema].[BI_DIM_TIEMPO] fecha ON (fecha.ID_FECHA = descuento.ID_FECHA)

  END
GO  



-- Porcentaje de envíos realizados a cada Provincia por mes. El porcentaje
-- debe representar la cantidad de envíos realizados a cada provincia sobre
-- total de envío mensuales.
CREATE VIEW porcentaje_envio_realizado_provincia_x_mes(PROVINCIA, PORCENTAJE, MES, ANIO)
AS
  BEGIN

    SELECT provincia.NOMBRE_PROV,

    ( 
      SELECT ( [gd_esquema].obtener_cant_ventas_x_provincia(provincia.CODIGO_PROVINCIA)  / [gd_esquema].obtener_cant_ventas_x_mes_y_anio(fecha.MES, fecha.ANIO) )

    ) PORCENTAJE,

    fecha.MES,
    fecha.ANIO

    FROM [gd_esquema].BI_DIM_PROVINCIA provincia
    JOIN  [gd_esquema].BI_HECHOS_VENTAS venta ON ( venta.CODIGO_PROVINCIA = provincia.CODIGO_PROVINCIA )
    JOIN [gd_esquema].[BI_DIM_TIEMPO] fecha ON ( venta.ID_FECHA = fecha.ID_FECHA )

  END
GO  


-- Valor promedio de envío por Provincia por Medio De Envío anual.

CREATE VIEW valor_promedio_envio_por_medio_por_provincia_anual
(ANIO, MEDIO_DE_ENVIO, VALOR_PROMEDIO)
AS
  BEGIN
    SELECT t.ANIO, e.MEDIO, p.NOMBRE_PROV, 
    (SELECT SUM(MEDIO_ENVIO_COSTO)/COUNT(ID_MEDIO_ENVIO) FROM [gd_esquema].[BI_HECHOS_VENTAS])
    FROM [gd_esquema].[BI_HECHOS_VENTAS] v 
    JOIN [gd_esquema].[BI_DIM_TIEMPO] t ON v.ID_FECHA = t.ID_FECHA
    JOIN [gd_esquema].[BI_DIM_TIPO_ENVIO] e ON v.ID_MEDIO_ENVIO = e.ID_MEDIO_ENVIO
    GROUP BY t.ANIO, e.MEDIO, p.NOMBRE_PROV

  END
GO



-- Aumento promedio de precios de cada proveedor anual. Para calcular este
-- indicador se debe tomar como referencia el máximo precio por año menos
-- el mínimo todo esto divido el mínimo precio del año. Teniendo en cuenta
-- que los precios siempre van en aumento.

CREATE VIEW aumento_promedio_precios_x_proveedor_anual ( PROVEEDOR, AUMENTO_PROMEDIO, ANIO)
AS
  BEGIN

       SELECT proveedor.RAZON_SOCIAL_PROV,
      ( 
      SELECT ( ( max(compra.TOTAL_PRODUCTO) - min(compra.TOTAL_PRODUCTO) ) / ( min(compra.TOTAL_PRODUCTO)  ) )
      FROM [gd_esquema].[BI_DIM_PROVEEDOR] proveedor_dos WHERE ( proveedor_dos.ID_PROVEEDOR = proveedor.ID_PROVEEDOR )  
      JOIN [gd_esquema].[BI_HECHOS_COMPRAS] compra ON (proveedor.ID_PROVEEDOR = compra.ID_PROVEEDOR AND compra.ID_FECHA = fecha.ID_FECHA)
       )
      FROM [gd_esquema].[BI_DIM_PROVEEDOR] proveedor, [gd_esquema].[BI_DIM_TIEMPO] fecha
      GROUP BY proveedor, fecha.ANIO
       
  END
GO  

-- Los 3 productos con mayor cantidad de reposición por mes.
CREATE VIEW top_3_prod_mayor_reposicion_x_mes (PRODUCTO,MES,ANIO,CANTIDAD_COMPRADA,RANKING)
AS
  BEGIN
    SELECT NOMBRE_PROD,MES,ANIO,
    SUM(CANTIDAD_PRODUCTO) CANTIDAD_COMPRADA,
    ROW_NUMBER() OVER (PARTITION BY MES,ANIO Order by SUM(CANTIDAD_PRODUCTO) DESC) AS Ranking
    FROM [gd_esquema].BI_HECHOS_COMPRAS c
    JOIN [gd_esquema].BI_DIM_PRODUCTO p ON p.COD_PROD=c.COD_PROD
    GROUP BY NOMBRE_PROD,MES,ANIO 
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

    SELECT @idTiempo = tiempo_id
    FROM [gd_esquema].BI_DIM_TIEMPO
    WHERE ANIO = @anioFecha AND MES = @mesFecha

    RETURN @idTiempo
  END
GO

CREATE FUNCTION [gd_esquema].obtener_rentabilidad_producto(@idProd decimal(19,0)) RETURNS DECIMAL(18,2) AS
  BEGIN
    DECLARE @rentabilidad decimal(19,0)
    SET @rentabilidad = SELECT (SUM(v.TOTAL_PRODUCTO)-SUM(c.TOTAL_COMPRA))/SUM(v.TOTAL_PRODUCTO)
    FROM [gd_esquema].BI_HECHOS_VENTAS v 
    JOIN [gd_esquema].BI_HECHOS_COMPRAS c ON v.COD_PROD=c.COD_PROD
    JOIN [gd_esquema].BI_DIM_TIEMPO t ON v.ID_FECHA=t.ID_FECHA
    WHERE t.ANIO = YEAR(GETDATE())

    RETURN @rentabilidad
  END
GO

CREATE FUNCTION [gd_esquema].obtener_id_tipo_descuento(@tipoDesc char(20)) RETURNS DECIMAL(19,0) AS
  BEGIN
    DECLARE @id DECIMAL(19,0)
    SET @id = SELECT ID_TIPO_DESCUENTO FROM [gd_esquema].BI_DIM_TIPO_DESCUENTO WHERE TIPO_DESCUENTO=@tipoDesc
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


CREATE FUNCTION [gd_esquema].obtener_cant_ventas_x_provincia(CODIGO_PROVINCIA) RETURNS DECIMAL(19,0) AS
  BEGIN
    DECLARE @cant DECIMAL(19,0)
    SELECT @cant=COUNT(*) FROM (SELECT DISTINCT ID_FECHA,CODIGO_PROVINCIA,ID_RANGO_ETARIO,ID_CANAL_VENTA,ID_MEDIO_PAGO,ID_MEDIO_ENVIO FROM [gd_esquema].BI_HECHOS_VENTAS ventas WHERE ventas.CODIGO_PROVINCIA = CODIGO_PROVINCIA ) Tabla
    RETURN @cant
  END
GO

CREATE FUNCTION [gd_esquema].obtener_cant_ventas_x_mes_y_anio(MES, ANIO) RETURNS DECIMAL(19,0) AS
  BEGIN
    DECLARE @cant DECIMAL(19,0)
    SELECT @cant=COUNT(*) FROM (SELECT DISTINCT ID_FECHA,CODIGO_PROVINCIA,ID_RANGO_ETARIO,ID_CANAL_VENTA,ID_MEDIO_PAGO,ID_MEDIO_ENVIO FROM [gd_esquema].BI_HECHOS_VENTAS venta WHERE fecha.MES = MES AND fecha.ANIO  = ANIO
                                                                                                                                      JOIN [gd_esquema].[BI_DIM_TIEMPO] fecha ON ( venta.ID_FECHA = fecha.ID_FECHA ) ) Tabla
    RETURN @cant
  END
GO
