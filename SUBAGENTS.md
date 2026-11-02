# SUBAGENTS.md — Protocolo de Delegación y Subagentes para Gemini

> **Principio Fundamental:** Los subagentes se emplean para **ejecutar en paralelo lo que ya está formalmente especificado**, nunca para **decidir lo que aún no está consensuado**.

El diseño y las decisiones estructurales (G0 a G5) permanecen en el hilo principal con el orquestador y el usuario. La delegación comienza únicamente a partir de **G6 (Construcción)**.

---

## 1. Tipos de Subagentes en el Ecosistema

En Antigravity y entornos de Gemini disponemos de tipos de subagentes especializados:

1. **`research` (Solo Lectura):** Explora repositorios existentes, lee librerías de tipos o investiga documentación técnica externa sin modificar el árbol de archivos ni contaminar el contexto del orquestador.
2. **`self` (Ejecución Aislada):** Hereda la configuración del modelo y herramientas de escritura para implementar un slice vertical completo en un espacio de trabajo propio o controlado.
3. **`image-generator`:** Genera o edita recursos visuales, iconos o assets gráficos a partir de un brief descriptivo.
4. **Subagentes definidos ad-hoc (`define_subagent`):** Para tareas especializadas (ej. revisor adversarial o generador de pruebas unitarias masivas).

---

## 2. Matriz de Delegación por Gate

| Fase | ¿Se permite delegar? | Tareas Autorizadas |
|---|---|---|
| **G0 Intake** | No | Solo `research` si se analiza un repositorio preexistente. |
| **G1 Alcance** | No | Ninguna. |
| **G2 Datos** | No | Ninguna (las decisiones de modelo y RLS son críticas). |
| **G3 Diseño** | No | Ninguna (solo `image-generator` para assets decorativos). |
| **G4 Técnico** | No | Solo `research` para validar compatibilidad de dependencias. |
| **G5 Pre-código** | No | Ninguna (el cierre de gate es estrictamente humano + orquestador). |
| **G6 Construcción** | **Sí** | Slices independientes, suites de tests, revisión adversarial y migraciones mecánicas. |

> **Prohibición absoluta:** Las decisiones de arquitectura, esquema de base de datos, flujo de autenticación/autorización y el cierre de compuertas nunca se delegan a un subagente.

---

## 3. Cuándo Sí y Cuándo No Delegar

### Cuándo Sí Delegar (G6):
* **Slices verticales independientes:** Features con conjuntos de archivos disjuntos y contratos de interfaz previamente congelados por el orquestador.
* **Revisión adversarial de código:** Un subagente revisor que inspecciona el diff generado por otro subagente frente a `ACCEPTANCE.md` y `AGENTS.md`.
* **Creación de tests y casos borde:** Elaboración de suites de pruebas E2E o unitarias por un subagente distinto al que implementó la lógica.
* **Migraciones repetitivas:** Refactorización sintáctica de muchos componentes siguiendo una regla exacta.

### Cuándo No Delegar:
* Modificaciones de menos de 3 a 5 archivos.
* Tareas fuertemente acopladas que comparten estado o modelos de datos en desarrollo.
* Cuando el orquestador no tenga una especificación clara y cerrada para el brief.

---

## 4. Contrato Obligatorio de Brief (7 Campos)

Un subagente no hereda el historial conversacional del hilo principal. Para invocarlo, el orquestador debe proporcionar obligatoriamente este contrato estructurado:

```text
1. Rol: [implementador / tester / revisor_adversarial / explorador]
2. Objetivo: [Una sola frase concreta que defina el éxito de la tarea]
3. Contexto: [Rutas de archivos a leer obligatoriamente; archivo de referencia a imitar]
4. Alcance: [Archivos autorizados para edición; archivos estrictamente PROHIBIDOS]
5. Criterios de Aceptación: [Lista verificable con viñetas; 0 ambigüedad]
6. Restricciones: [No alterar schema; no instalar librerías externas; tipado estricto]
7. Verificación requerida: [Comando exacto a ejecutar en consola; formato de reporte con git diff --stat]
```

---

## 5. Matriz de Propiedad de Archivos (Anti-Colisiones)

Antes de lanzar dos o más subagentes en paralelo:

1. El orquestador define una tabla explícita de `Archivo → Subagente Propietario`.
2. Ningún archivo puede tener dos dueños simultáneos.
3. Si dos tareas necesitan modificar el mismo archivo (ej. `routes.ts` o `schema.prisma`), se ejecutan **de forma secuencial**, no paralela.
4. Límite máximo de concurrencia: **2 a 3 subagentes activos simultáneamente**.
