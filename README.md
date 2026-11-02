# Gemini Design Harness

Kit de arquitectura y diseño para construir **sistemas de software y aplicaciones web desde cero** utilizando modelos de la familia **Gemini** (Gemini 3.8 / Flash / Pro) dentro de **Antigravity** o entornos de codificación asistida por agentes.

Evolucionado a partir del concepto de *Specification-Driven Development*, este arnés aprovecha las capacidades distintivas de Gemini:
- **Ventana de contexto ultra-amplia** gestionada mediante arquitectura jerárquica (cero degradación de atención).
- **Comprensión multimodal nativa:** ingestión directa de wireframes, capturas de pantalla, bocetos y diagramas de arquitectura en las fases de diseño.
- **Artefactos visuales e interactivos:** generación de esquemas Mermaid, fórmulas KaTeX y vistas previas en Generative UI.
- **Enrutamiento inteligente:** ciclo diario de alta velocidad en **Gemini Flash (High)** y escalado quirúrgico a **Gemini Pro** para auditorías críticas de arquitectura, seguridad y concurrencia.

> **Contrato central no negociable:** no se escribe código de producto hasta que existan y estén aprobados `SPEC.md`, `DATA-MODEL.md`, `DESIGN-SYSTEM.md`, `ARCHITECTURE.md`, `ACCEPTANCE.md` y `ROADMAP.md` mediante el checklist de compuerta **G5 (Pre-código)**.

---

## Estructura del Harness

| Archivo / Carpeta | Función |
|---|---|
| [`AGENTS.md`](AGENTS.md) | Reglas operativas que el modelo Gemini debe acatar en el repositorio destino. |
| [`HARNESS.md`](HARNESS.md) | Protocolo de diseño: 6 Gates, mecánica de entrevistas, control de cambios y comandos. |
| [`MODEL-NOTES.md`](MODEL-NOTES.md) | Calibración específica para Gemini: gestión de contexto amplio, multimodalidad, `[VERIFICAR]` y mitigación de alucinaciones. |
| [`SUBAGENTS.md`](SUBAGENTS.md) | Reglas de delegación paralela (Antigravity subagents: `research`, `self`, `image-generator`). |
| [`COST.md`](COST.md) | Economía de tokens de Gemini: Prompt Caching (>32k), tokens multimodales por imagen y ruteo Flash vs Pro. |
| [`SKILLS.md`](SKILLS.md) | Política de skills: ciclo de vida, triggers, compatibilidad con Antigravity y OpenCode. |
| [`QUESTION-BANK.md`](QUESTION-BANK.md) | 6 rondas de preguntas con defaults recomendados y soporte para inputs visuales. |
| [`KICKOFF.md`](KICKOFF.md) | Prompts listos para arrancar, retomar sesiones y activar slash commands (`/grill-me`, `/plan`, `/boost`). |
| [`CHANGELOG.md`](CHANGELOG.md) | Historial de versiones del harness. |
| [`ROADMAP.md`](ROADMAP.md) | Evolución del kit y mejoras planificadas. |
| [`install.ps1`](install.ps1) / [`install.sh`](install.sh) | Scripts de instalación automatizada para Windows, macOS y Linux. |
| [`templates/`](templates/) | Plantillas estándar de especificación técnica, datos, UI y arquitectura. |
| [`state/PROJECT-STATE.md`](state/PROJECT-STATE.md) | Single Source of Truth del proyecto: estado vivo, decisiones inmutables `D-XX`, supuestos `S-XX` y riesgos. |
| [`checklists/`](checklists/) | Compilado de validaciones: `GATE-PRE-CODE.md` y `DOD-SLICE.md`. |
| [`skills/`](skills/) | Skills procedimentales reutilizables (auditoría visual multimodal y revisión adversarial). |

---

## Flujo en 6 Gates

```
G0 Intake ──► G1 Alcance ──► G2 Datos ──► G3 Diseño ──► G4 Técnico ──► G5 Pre-código ──► G6 Construcción
   SPEC        SPEC v1        DATA-MODEL    DESIGN-SYSTEM   ARCHITECTURE    checklist        slices + DoD
               ROADMAP v0                    + Wireframes    ACCEPTANCE      GATE-PRE-CODE    (Flash / Pro)
                                             (Multimodal)    ROADMAP v1
```

1. **G0 Intake:** Problema, roles, acción principal (el verbo del usuario) y métrica de éxito a 90 días.
2. **G1 Alcance:** 3 a 5 features centrales del MVP y no-alcance estrictamente delimitado.
3. **G2 Datos:** Entidades, relaciones, permisos de rol (RBAC), datos sensibles y retención.
4. **G3 Diseño:** Tokens de diseño, componentes base, layout, a11y AA y validación multimodal de capturas/bocetos.
5. **G4 Técnico:** Stack, auth con validación en servidor, observabilidad, manejo de secretos y mitigación de fallos.
6. **G5 Pre-código:** Verificación estricta del checklist de salida. Solo tras el OK explícito del humano se inicia G6.
7. **G6 Construcción:** Implementación por slices verticales punta a punta con Definition of Done verificado.

---

## Inicio Rápido en 3 Pasos

### 1. Instalar en tu proyecto

En **PowerShell** (Windows):
```powershell
.\install.ps1 -Project "C:\Ruta\A\TuProyecto"
```

En **Bash** (macOS / Linux):
```bash
./install.sh /ruta/a/tu-proyecto
```

### 2. Abrir Antigravity (o tu entorno de IA) en la carpeta del proyecto

Asegúrate de que la raíz de trabajo sea la carpeta del proyecto recién creada/inicializada.

### 3. Pegar el comando de arranque

```text
Inicia el Gemini Design Harness en modo Express. Hazme la Ronda 1.
```

O si prefieres un cuestionario interactivo profundo guiado por el agente:
```text
/grill-me Actúa como Arquitecto Técnico e inicia el Gemini Design Harness. Comencemos con la Ronda 1 de Intake.
```

---

## Principios Fundamentales

1. **Multimodalidad de Primera Clase:** No describas en 500 palabras lo que un wireframe o captura de pantalla explica en un segundo. Gemini analiza diseños visuales directamente en G3.
2. **Preguntar antes de asumir:** Toda ambigüedad se transforma en una pregunta con default o en un supuesto explícito (`S-XX`).
3. **Persistencia en Archivos, no en el Chat:** Lo que no está registrado en `PROJECT-STATE.md` o en los artefactos de `docs/harness/`, no existe.
4. **Decisiones Inmutables:** Las decisiones (`D-XX`) nunca se borran ni sobrescriben; se superseden con una nueva entrada y justificación.
5. **Slices Verticales y Verificación Real:** Una feature se implementa completa (Ruta → UI → Datos → Estados → Verificación) con `typecheck`, `lint` y pruebas ejecutadas realmente, nunca reportadas de memoria.
6. **Economía de Atención:** Aunque Gemini maneja más de 1 millón de tokens, la calidad técnica óptima se logra manteniendo las instrucciones base estables y leyendo quirúrgicamente solo los archivos relevantes.
