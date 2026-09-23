# Retail Analytics: Resiliencia Operativa ante la Presión Macroeconómica

## 🎯 Objetivo de Negocio
Evaluación de la elasticidad y resiliencia de tres modelos de superficie comercial (Tipos A, B y C) frente a variables de estrés macroeconómico. El análisis cruza el volumen histórico transaccional de 45 tiendas durante 143 semanas con la evolución del Índice de Precios al Consumidor (IPC) y la tasa de desempleo, aislando el comportamiento del consumidor ante la inestabilidad laboral.

## 📊 Insights Clínicos y Conclusiones
El cruce de variables demuestra una migración forzosa del consumo durante los picos de crisis económica:

* **Vulnerabilidad del Modelo A (Supercenters):** Concentran el mayor volumen de facturación absoluta, pero presentan una elasticidad negativa severa. Durante escenarios de "Inestabilidad Laboral", sufren contracciones transaccionales críticas.
* **Antifragilidad del Modelo C (Formato Descuento):** Actúa como activo refugio. Es el único modelo estrictamente anticíclico, disparando su facturación promedio semanal de $345.268 a $514.457 cuando el desempleo supera los umbrales de riesgo, evidenciando la priorización de bienes de primera necesidad.

> **Nota visual:** La siguiente matriz aísla matemáticamente el comportamiento anticíclico del modelo C mediante un mapa de calor.

<img width="600" height="180" alt="image" src="https://github.com/user-attachments/assets/624f54bc-e91a-4701-8b28-ba499e0f6e66" />


## 🛠 Arquitectura de Datos y Stack Tecnológico
* **Herramienta:** Power BI Desktop
* **Procesamiento ETL (Power Query):**
  * Estructuración del modelo tabular y limpieza de formatos regionales.
  * Transformación de variables macroeconómicas estáticas (IPC, Tasas de Desempleo) para su correcta distribución sin agregaciones aditivas que destruyan la granularidad temporal.
* **Modelado Analítico (DAX):**
  * Desarrollo de medidas paramétricas para promedios de ventas continuos e indexación de factores de riesgo.
* **Diseño UI/UX y Data-Ink Ratio:**
  * Eliminación de ejes redundantes y ruido visual.
  * Implementación de colorimetría estratégica para dirigir la atención hacia el formato C.
  * Parametrización estricta del filtrado cruzado para el aislamiento de series temporales.

## ⚙️ Estructura del Repositorio
* `📁 database/`: Dataset original anonimizado.
* `📁 Scripts/`: Código ejecutado en SQL para la creación del Datamart
* `📁 dashboard/`: Archivo fuente del cuadro de mando y en formato PDF.
