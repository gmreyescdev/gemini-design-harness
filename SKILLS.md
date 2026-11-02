# SKILLS.md — Política de Skills Procedimentales para Gemini

> **Concepto:** Una skill es un **procedimiento operativo estándar y reutilizable** que el agente carga bajo demanda cuando se cumple un disparador específico. No es un gate, no es una especificación y no reemplaza el juicio de diseño.

---

## 1. Jerarquía de Capas del Harness

| Capa | Ubicación | Cuándo se Carga | Propósito |
|---|---|---|---|
| **Invariantes** | `AGENTS.md` | Siempre (raíz del proyecto) | Reglas absolutas, límites y disciplina. |
| **Protocolo** | `HARNESS.md` | Siempre / por sesión | Metodología de Gates G0 a G6 y rondas. |
| **Alineación de Modelo**| `MODEL-NOTES.md` | Al inicio de sesión | Fortalezas, sesgos y anti-alucinación de Gemini. |
| **Economía** | `COST.md` | Permanente | Disciplina de caché y tokens. |
| **Delegación** | `SUBAGENTS.md` | En G6 (Construcción) | Reglas de paralelismo y briefs. |
| **Procedimientos** | `skills/*/SKILL.md` | **Solo si el disparador aplica** | Pasos exactos para tareas repetitivas o críticas. |

---

## 2. Regla de Oro para Crear una Skill

> **Una skill nace de una corrección repetida al menos dos veces, nunca de la imaginación previa.**

Se crea una nueva skill cuando:
1. El agente cometió el mismo error o requirió la misma corrección dos veces consecutivas.
2. El procedimiento involucra una secuencia no obvia de comandos (ej. configurar Tailwind v4 con Next.js App Router, o crear una migración de base de datos con políticas RLS).
3. El costo del error es alto: autenticación, pasarelas de pago, despliegues a producción o eliminación de datos.
4. Se busca estandarizar una convención arquitectónica en decenas de archivos.

---

## 3. Anatomía Estándar de una Skill

Toda skill reside en su propia carpeta `skills/<nombre-skill>/SKILL.md` y cuenta con encabezado YAML compatible con Antigravity y OpenCode:

```markdown
---
name: nombre-de-la-skill
description: Resumen en 1 frase de qué hace y cuándo debe invocarse exactamente.
---

# Nombre de la Skill

## Disparador (Cuándo invocar)
- Cargar cuando el usuario solicite [X] o cuando se edite un archivo tipo [Y].

## Entradas Requeridas
- Lista de archivos o variables necesarias antes de ejecutar.

## Procedimiento Paso a Paso
1. Paso 1 (con comando exacto o patrón de código).
2. Paso 2.
3. Paso 3.

## Verificación
- Comando exacto para comprobar que el resultado es exitoso.

## Casos de Error y Recuperación
- Qué hacer si falla el comando o la prueba.
```

---

## 4. Skills Incluidas en este Harness

El kit incluye dos skills precalibradas para Gemini:

1. [`skills/gemini-ui-audit`](skills/gemini-ui-audit/SKILL.md): Realiza una auditoría visual y de código de un componente o página frente a `DESIGN-SYSTEM.md` (revisión de contraste AA, estados de UI, tokens y responsive).
2. [`skills/gemini-adversarial-review`](skills/gemini-adversarial-review/SKILL.md): Ejecuta una revisión adversarial estricta de un slice vertical frente a los criterios de `ACCEPTANCE.md` antes de dar por cerrada la tarea.
