CREATE TABLE stores (
    store_id INTEGER PRIMARY KEY,
    type VARCHAR(1),
    size INTEGER
);

select * from stores

CREATE TABLE train (
    Store INTEGER,
    Dept INTEGER,
    Date DATE,
    Weekly_Sales REAL,
    IsHoliday BOOLEAN
);

CREATE TABLE features (
    Store INTEGER,
    Date DATE,
    Temperature REAL,
    Fuel_Price REAL,
    MarkDown1 REAL,
    MarkDown2 REAL,
    MarkDown3 REAL,
    MarkDown4 REAL,
    MarkDown5 REAL,
    CPI REAL,
    Unemployment REAL,
    IsHoliday BOOLEAN
);

select count(*) from train ;

select * from features

SELECT 
    t.Date AS Fecha,
    t.Store AS ID_Tienda,
    s.type AS Tipo_Tienda,
    t.Dept AS Departamento,
    t.Weekly_Sales AS Ventas_Semanales,
    f.CPI AS Inflacion_IPC,
    f.Unemployment AS Tasa_Desempleo,
    CASE 
        WHEN f.Unemployment < 6.5 THEN 'Estabilidad Laboral'
        WHEN f.Unemployment BETWEEN 6.5 AND 8.5 THEN 'Estrés Moderado'
        WHEN f.Unemployment > 8.5 THEN 'Contracción Crítica'
        ELSE 'Sin Registro'
    END AS Diagnostico_Desempleo
FROM train t
INNER JOIN stores s ON t.Store = s.store_id
INNER JOIN features f ON t.Store = f.Store AND t.Date = f.Date
LIMIT 100;


WITH VentasAgregadas AS (
    -- Fase 1: Agregación de ventas totales por tienda y semana
    SELECT 
        t.Date AS Fecha,
        t.Store AS ID_Tienda,
        s.type AS Tipo_Tienda,
        SUM(t.Weekly_Sales) AS Ventas_Totales_Tienda
    FROM train t
    INNER JOIN stores s ON t.Store = s.store_id
    GROUP BY t.Date, t.Store, s.type
)
-- Fase 2: Cruce con variables exógenas y categorización diagnóstica
SELECT 
    v.Fecha,
    v.ID_Tienda,
    v.Tipo_Tienda,
    v.Ventas_Totales_Tienda,
    f.CPI AS Inflacion_IPC,
    f.Unemployment AS Tasa_Desempleo,
    CASE 
        WHEN f.Unemployment < 6.5 THEN 'Estabilidad Laboral'
        WHEN f.Unemployment BETWEEN 6.5 AND 8.5 THEN 'Estrés Moderado'
        WHEN f.Unemployment > 8.5 THEN 'Inestabilidad Laboral'
        ELSE 'Sin Registro'
    END AS Diagnostico_Desempleo,
    CASE
        WHEN f.CPI < 160 THEN 'Inflación Baja'
        WHEN f.CPI BETWEEN 160 AND 200 THEN 'Inflación Media'
        WHEN f.CPI > 200 THEN 'Inflación Alta'
        ELSE 'Sin Registro'
    END AS Diagnostico_Inflacion
FROM VentasAgregadas v
INNER JOIN features f ON v.ID_Tienda = f.Store AND v.Fecha = f.Date;

