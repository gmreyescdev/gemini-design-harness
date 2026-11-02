# COST.md — Economía de Tokens y Gestión de Caché para Gemini

> **Objetivo:** Optimizar el consumo de tokens y maximizar el rendimiento de Gemini mediante el aprovechamiento de **Prompt Caching**, el uso eficiente de entradas multimodales y la disciplina en la longitud de salidas.

---

## 1. La Dinámica de Costos en Gemini

En la arquitectura de Gemini (Flash y Pro), el balance de costos y velocidad está dominado por tres factores clave:

1. **Lectura de Prefijo Cacheado (Context Caching):**
   * Cuando el contexto base (instrucciones, `AGENTS.md`, especificaciones estables) supera los ~32k tokens y permanece idéntico entre llamadas, se activa el caché de contexto.
   * La lectura de caché ofrece un descuento de hasta un **75% a 85%** respecto al input nuevo y reduce la latencia de respuesta drásticamente.
2. **Input Nuevo (Herramientas, Diffs y Archivos leídos):**
   * Cada archivo volcado entero, salida de log kilométrica o comando sin filtrar consume tokens de entrada no cacheados a tarifa completa.
3. **Tokens de Salida (Output):**
   * La generación de tokens de salida es el componente computacionalmente más costoso (entre 4× y 6× el costo del input nuevo). Reescribir archivos enteros de 500 líneas en cada turno destruye la eficiencia de costos.

---

## 2. Las 5 Palancas de Optimización en Gemini

### 2.1 Disciplina de Caché de Prefijo
* **Estabilidad del Prefijo:** Coloca siempre los elementos inmutables primero (`AGENTS.md`, `HARNESS.md`, especificación aprobada). Lo dinámico (mensajes recientes y comandos) va al final.
* **No edites `AGENTS.md` a mitad de sesión:** Cambiar una palabra en las instrucciones base invalida todo el prefijo cacheado hacia adelante, obligando a re-procesar todo el contexto histórico como input nuevo.

### 2.2 Eficiencia Multimodal (Imágenes vs Texto)
* Una imagen o captura de pantalla de un wireframe consume aproximadamente **258 a 516 tokens** (según resolución y división en mosaicos de 768×768).
* Comparativamente, transcribir con palabras una interfaz con 15 inputs, 3 botones y 4 tablas suele requerir más de **1.500 tokens de texto** y contiene ambigüedades.
* **Regla:** En la Ronda 4 (Diseño), prefiere proporcionar capturas de pantalla o bocetos visuales; es más rápido, más preciso y consume menos tokens que una descripción textual exhaustiva.

### 2.3 Recorte de Entradas de Herramientas
* **Búsqueda dirigida:** Usa `grep`, búsquedas por símbolo y lectura de rangos (`StartLine` / `EndLine`) en lugar de leer archivos de mil líneas.
* **Filtrado de salidas de consola:** Al correr tests o builds, reporta únicamente el resumen final o las líneas con errores (`tail`, mensajes de falla), no los 4.000 renglones de dependencias descargadas.
* **Diffs limpios:** Inspecciona cambios con `git diff --stat` antes de solicitar el diff detallado de un archivo particular.

### 2.4 Recorte de Salidas del Modelo
* **Edición vs Sobrescritura:** Utiliza `edit_file` con bloques delimitados para cambios quirúrgicos. Reserva `write_file` con sobreescritura únicamente para archivos nuevos o reestructuraciones integrales.
* **Respuestas ejecutivas:** Explicaciones en viñetas concisas con evidencia técnica. El valor está en la decisión y el código correcto, no en prosa redundante.

### 2.5 Ruteo de Modelos (Flash vs Pro)
* Mantén las sesiones operativas y de desarrollo continuo en **Gemini Flash (High)**.
* Reserva **Gemini Pro** para momentos de alto apalancamiento:
  * Revisión previa al Gate G5.
  * Análisis de vulnerabilidades o modelos de autenticación complejos.
  * Cuando un problema haya producido dos fallos repetidos en Flash.

---

## 3. Presupuesto Recomendado por Fase

| Fase | Rango de Contexto Típico | Modelo Recomendado | Estrategia |
|---|---|---|---|
| **G0 a G2 (Intake / Alcance / Datos)** | 8k – 25k tokens | Gemini Flash | Diálogo directo, respuestas en 5 bullets, persistencia inmediata. |
| **G3 (Diseño UI / Sistema visual)** | 20k – 45k tokens | Gemini Flash | Ingestión de capturas visuales, tokens de CSS y componentes base. |
| **G4 y G5 (Arquitectura / Pre-código)** | 40k – 80k tokens | Gemini Flash / Pro | Activación de Prompt Caching. Revisión adversarial con `/boost`. |
| **G6 (Construcción por Slices)** | Variable (cacheado) | Gemini Flash | Slices desacoplados, `git diff --stat`, comandos de test acotados. |
