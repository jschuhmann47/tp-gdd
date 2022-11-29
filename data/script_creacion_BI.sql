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
  [ID_DESC] decimal(19,0) IDENTITY(1,1), --averiguar tema id
  [TIPO_DESCUENTO] char(10), --COMPRA, VENTA, MEDIO_PAGO, etc
  --[VALOR_DESCUENTO] decimal(18,2), --ver donde va el valor ya que una venta/compra tiene varios descuentos
  PRIMARY KEY ([ID_DESC])
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
    [CODIGO_PROVINCIA] decimal(19,0), --fk
    [ID_PROVEEDOR] decimal(19,0), --fk
    [COD_PROD] nvarchar(50), --fk
    [TOTAL_COMPRA] decimal(18,2),
);

CREATE TABLE [gd_esquema].[BI_HECHOS_VENTAS](
    [ID_FECHA] decimal(19,0), --fk
    [CODIGO_PROVINCIA] decimal(19,0), --fk
    [ID_CLIENTE] decimal(19,0), --fk
    [ID_CANAL_VENTA] decimal(19,0), --fk
    [ID_MEDIO_PAGO] decimal(19,0), --fk
    [ID_CATEGORIA] decimal(19,0), --fk
    [COD_PROD] nvarchar(50), --fk
    [ID_DESC] decimal(19,0), --fk
    [ID_MEDIO_ENVIO] decimal(19,0), --fk
    [TOTAL_COMPRAVENTA] decimal(18,2),
    [TOTAL_DESCUENTOS] decimal(18,2),
    [MEDIO_ENVIO_COSTO] decimal(18,2),
    [CANAL_VENTA_COSTO] decimal(18,2)
);

CREATE TABLE [gd_esquema].[BI_HECHOS_DESCUENTOS]( --los desc de compras no importa discriminarlos, van directo en el total
    [DESCUENTO_ID] DECIMAL(19,0) --fk
    [ID_CANAL_VENTA] DECIMAL(18,0) --fk
    [ID_FECHA] DECIMAL(19,0) --fk
    [TOTAL_DESCUENTO] DECIMAL(18,2)
);


GO

ALTER TABLE [gd_esquema].[BI_HECHOS_COMPRAVENTA] ADD CONSTRAINT [ID_FECHA] FOREIGN KEY ([ID_FECHA]) REFERENCES [gd_esquema].[BI_DIM_TIEMPO]([ID_FECHA])
--etc



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
        VALUES ('COMPRA'),('FIJO'),('CUPON'),('MEDIO_PAGO') --ver si faltan
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
      //TODO
    END
GO

CREATE PROCEDURE [gd_esquema].cargar_ventas AS
    BEGIN
      //TODO
    END
GO


--VISTAS

/*
Las ganancias mensuales de cada canal de venta.
Se entiende por ganancias al total de las ventas, menos el total de las
compras, menos los costos de transacción totales aplicados asociados los
medios de pagos utilizados en las mismas.
*/

CREATE VIEW ganancias_mensuales_x_canal_venta (CANAL_VENTA, MES, ANIO, GANANCIAS)
AS
  BEGIN
    
  END
GO
-- Los 5 productos con mayor rentabilidad anual, con sus respectivos %
-- Se entiende por rentabilidad a los ingresos generados por el producto
-- (ventas) durante el periodo menos la inversión realizada en el producto
-- (compras) durante el periodo, todo esto sobre dichos ingresos.
-- Valor expresado en porcentaje.
-- Para simplificar, no es necesario tener en cuenta los descuentos aplicados.


-- Las 5 categorías de productos más vendidos por rango etario de clientes
-- por mes.



-- Total de Ingresos por cada medio de pago por mes, descontando los costos
-- por medio de pago (en caso que aplique) y descuentos por medio de pago
-- (en caso que aplique)


-- Importe total en descuentos aplicados según su tipo de descuento, por
-- canal de venta, por mes. Se entiende por tipo de descuento como los
-- correspondientes a envío, medio de pago, cupones, etc)


-- Porcentaje de envíos realizados a cada Provincia por mes. El porcentaje
-- debe representar la cantidad de envíos realizados a cada provincia sobre
-- total de envío mensuales.


-- Valor promedio de envío por Provincia por Medio De Envío anual.


-- Aumento promedio de precios de cada proveedor anual. Para calcular este
-- indicador se debe tomar como referencia el máximo precio por año menos
-- el mínimo todo esto divido el mínimo precio del año. Teniendo en cuenta
-- que los precios siempre van en aumento.


-- Los 3 productos con mayor cantidad de reposición por mes.


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
				ELSE (SELECT edad_id FROM [gd_esquema].bi_edad WHERE rango_edad = '>55')
			END

		RETURN @edad_id
	END
GO

CREATE FUNCTION [gd_esquema].obtener_id_tiempo(@fecha DATE) RETURNS DECIMAL(19,0) AS
	BEGIN
    DECLARE @anioFecha INT, @mesFecha INT, @idTiempo INT

    SET @anio_de_fecha = DATEPART(YEAR, @fecha)
    SET @cuatrimestre_de_fecha = DATEPART(QUARTER, @fecha)

    SELECT @id_tiempo = tiempo_id
    FROM [gd_esquema].bi_Tiempo
    WHERE anio = @anio_de_fecha AND cuatrimestre = @cuatrimestre_de_fecha

    RETURN @id_tiempo
END