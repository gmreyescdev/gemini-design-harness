# EMPIEZA AQUÍ — Gemini Design Harness

> **Guía rápida para arrancar en menos de 5 minutos.**

---

## Paso 1 — Instalar el Harness en tu proyecto

Abre PowerShell en tu terminal y ejecuta el script instalador indicando la ruta de tu proyecto:

```powershell
.\install.ps1 -Project "C:\Users\Gerald\Desktop\mi-nuevo-proyecto"
```

*(Si no existe la carpeta, el script la creará automáticamente y copiará todos los archivos necesarios a `docs/harness/` y el archivo `AGENTS.md` a la raíz).*

---

## Paso 2 — Abrir Antigravity en la carpeta del proyecto

Abre el espacio de trabajo en la carpeta destino (`mi-nuevo-proyecto`), **no en la carpeta del kit**.
De esta forma el modelo Gemini detectará automáticamente `AGENTS.md` y sabrá cómo operar.

---

## Paso 3 — Iniciar el proceso de diseño

En el chat de Antigravity, escribe:

```text
Inicia el Gemini Design Harness en modo Express. Hazme la Ronda 1.
```

O si deseas que Gemini te haga preguntas desafiantes para pulir tu idea:

```text
/grill-me Actúa como Arquitecto Técnico e inicia el Gemini Design Harness. Ejecuta la Ronda 1 (Intake).
```

---

## ¿Qué ocurrirá paso a paso?

| Ronda | Objetivo de Diseño | Artefacto Generado |
|---|---|---|
| **1. Intake** | Problema, usuarios y acción central | `SPEC.md` v0 |
| **2. Alcance** | MVP delimitado (3-5 features) y lo que NO entra | `SPEC.md` v1 + `ROADMAP.md` v0 |
| **3. Datos** | Entidades, relaciones, permisos y datos sensibles | `DATA-MODEL.md` |
| **4. UI/Diseño** | Componentes, tokens, layouts y soporte para imágenes/wireframes | `DESIGN-SYSTEM.md` |
| **5. Arquitectura** | Stack técnico, auth, deploy, observabilidad y aceptación | `ARCHITECTURE.md` + `ACCEPTANCE.md` |
| **Gate G5** | Checklist de revisión exhaustivo | `GATE-PRE-CODE.md` aprobado |
| **G6 Construcción** | Desarrollo iterativo por slices verticales | Código de producto verificado |

---

## Consejos Útiles con Gemini

* **Si no sabes qué elegir:** Responde `"no sé"`. Gemini aplicará la mejor práctica por defecto del `QUESTION-BANK.md` y lo registrará como un supuesto formal en `PROJECT-STATE.md`.
* **Si tienes un boceto o diseño previo:** Arrastra la imagen o captura al chat en la Ronda 4 (Diseño). Gemini interpretará los componentes, tipografía y distribución visualmente.
* **Si el agente intenta escribir código antes de tiempo:** Recuérdale: *"Estamos en la fase de diseño; respeta el Gate pre-código de AGENTS.md"*.
* **Cambio de fase o sesión nueva:** Consulta `KICKOFF.md` para ver los prompts optimizados para retomar cualquier trabajo pendiente.
