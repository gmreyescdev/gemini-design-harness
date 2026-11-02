# MODEL-NOTES.md — Calibración Operativa para Modelos Gemini

Este documento contiene las reglas de adaptación y calibración para maximizar el desempeño de los modelos **Gemini** (Gemini 3.8 Flash y Pro) dentro del marco de este arnés.

---

## 1. Fortalezas Clave de Gemini y Cómo Explotarlas

| Capacidad Distintiva | Aplicación en el Harness |
|---|---|
| **Ventana de Contexto Masiva (1M+ tokens)** | Permite mantener en memoria todo el historial arquitectónico, decisiones y especificaciones sin truncamientos forzados. |
| **Multimodalidad Nativa de Alta Precisión** | En la Ronda 4 (Diseño G3), Gemini puede inspeccionar directamente capturas de interfaces, diagramas Figma exportados o bocetos en papel y transformarlos en tokens y componentes. |
| **Generación de Artefactos Estructurados** | Renderizado nativo de diagramas Mermaid (`flowchart`, `sequenceDiagram`, `erDiagram`), tablas GFM y expresiones matemáticas KaTeX. |
| **Velocidad y Agilidad en Flash (High)** | Ideal para el desarrollo rápido de slices verticales, scaffolding de componentes, refactorizaciones guiadas y ejecución de tests. |
| **Profundidad de Razonamiento en Pro** | Disponible para resolución de conflictos arquitectónicos complejos, validación matemática de algoritmos y auditorías de seguridad en autenticación/autorización. |

---

## 2. Vulnerabilidades Típicas y Mitigaciones Obligatorias

Aunque Gemini es uno de los modelos más avanzados de la industria, presenta patrones de comportamiento que este arnés neutraliza de forma sistemática:

### 2.1 Dilución de Atención por Contexto Extenso ("Lost in the Middle")
* **Riesgo:** Confiar en que el modelo retendrá todos los detalles si se le vuelcan docenas de archivos enteros sin orden.
* **Mitigación:** 
  1. Uso del Single Source of Truth (`state/PROJECT-STATE.md`).
  2. Al retomar sesiones o iniciar slices, leer únicamente el estado y los 2–3 archivos estrictamente involucrados.
  3. Búsqueda dirigida por símbolos y lectura por rangos de líneas en lugar de volcar carpetas completas.

### 2.2 Sobre-generosidad / Generación Excesiva de Código
* **Riesgo:** Tendencia a reescribir componentes completos de 400 líneas cuando solo se solicitaba modificar un manejador de eventos de 3 líneas.
* **Mitigación:**
  1. Uso prioritario de herramientas de edición puntual (`edit_file`) en lugar de sobrescribir archivos enteros.
  2. Reportar siempre `git diff --stat` y un resumen conciso del cambio en viñetas.

### 2.3 Alucinación de APIs y Versiones de Paquetes
* **Riesgo:** Asumir la existencia de una función o prop introducida en una versión distinta de una librería.
* **Mitigación:**
  1. Ante cualquier duda en la firma de una función de terceros, etiquetar `[VERIFICAR]`.
  2. Leer las definiciones de tipos (`d.ts`), la documentación oficial o el `package.json` real del repositorio antes de invocar métodos no triviales.

### 2.4 Optimismo en el Reporte de Verificación
* **Riesgo:** Asumir que el código funciona porque la lógica parece correcta en el texto, sin correr el compilador.
* **Mitigación:**
  1. Es obligatorio ejecutar los comandos reales de verificación (`npm run typecheck`, `npm test`, `cargo check`, `pytest`, etc.).
  2. El modelo debe reportar la evidencia textual del comando y su código de salida (0 = éxito).

---

## 3. Protocolo de Enrutamiento de Modelos (Flash vs Pro)

* **Gemini Flash (Por defecto para el 85% de las tareas):**
  - Entrevistas y rondas de preguntas (G0 a G3).
  - Creación de borradores de especificación y arquitectura.
  - Implementación iterativa de slices en G6 (UI, hooks, componentes, endpoints, migraciones).
  - Ejecución y corrección de pruebas unitarias y linters.

* **Escalada a Gemini Pro (Para el 15% crítico):**
  - Auditoría del Gate Pre-código (G5).
  - Revisión de seguridad en flujos de autenticación, criptografía y control de acceso (RLS / ACL).
  - Modelado de concurrencia compleja, transacciones distribuidas o algoritmos matemáticos no estándar.
  - Diagnóstico de bugs esquivos cuando Flash ha fallado dos veces consecutivas en resolver un error.

---

## 4. Checklist Interno de Auto-Revisión antes de Entregar un Turno

Antes de responder al usuario, el agente debe verificar mentalmente:

- [ ] ¿Modifiqué estrictamente los archivos acordados en el plan (sin cambios no solicitados)?
- [ ] ¿Implementé los 4 estados visuales indispensables (`loading`, `error`, `empty`, `success`)?
- [ ] ¿Mantuve tipado estricto (cero `any` o `@ts-ignore` injustificados)?
- [ ] ¿Ejecuté las herramientas de verificación en la terminal y leí el código de retorno real?
- [ ] ¿Actualicé el archivo `state/PROJECT-STATE.md` reflejando el progreso del proyecto?
- [ ] ¿Dejé algún elemento con la etiqueta `[VERIFICAR]` sin avisar al usuario?
