---
name: gemini-adversarial-review
description: Revisión crítica y adversarial de un slice de código o pull request frente a ACCEPTANCE.md y AGENTS.md.
---

# Revisión Adversarial de Slices (Gemini Adversarial Review)

Este procedimiento adopta deliberadamente una mentalidad de **evaluador estricto y adversarial**. Su objetivo es encontrar fallos, atajos técnicos, falta de tipado o discrepancias con los criterios de aceptación antes de dar por cerrada una tarea.

---

## 1. Disparador (Cuándo Invocarse)
* Al completar un slice vertical en G6, antes de solicitar la aprobación del usuario.
* Cuando se invoque el comando `/boost` sobre un cambio reciente.
* Cuando se delegue la revisión a un subagente revisor con rol `revisor_adversarial`.

---

## 2. Insumos Requeridos
* Salida de `git diff --stat` y el diff detallado del slice.
* `docs/harness/templates/ACCEPTANCE.md`.
* `AGENTS.md`.

---

## 3. Vectores de Ataque de la Revisión

El revisor debe someter el cambio a 5 preguntas hostiles:

### Vector 1: Trampas de Tipado y Linters
* ¿Se introdujo algún `any`, `unknown` sin cast o coerción `as unknown as Type` para silenciar al compilador?
* ¿Hay comentarios `@ts-ignore` o `@eslint-disable` que oculten un problema de diseño?
* *Regla:* Si existe uno solo sin justificación escrita en `PROJECT-STATE.md`, la revisión es **RECHAZADA**.

### Vector 2: Cobertura de Criterios de Aceptación
* Comparar línea por línea el diff contra los escenarios de `ACCEPTANCE.md`.
* ¿Se implementaron solo los flujos ideales (*happy path*) ignorando los escenarios de error y validación fallida?
* ¿Los mensajes de error son útiles o son textos genéricos como *"Algo salió mal"*?

### Vector 3: Seguridad y Autorización en Servidor
* ¿Se confía en parámetros enviados por el cliente sin re-validar la sesión en el servidor?
* ¿Las consultas a base de datos aplican el filtro de organización o tenant para evitar acceso cruzado (*IDOR*)?
* ¿Algún secreto o clave privada de API quedó expuesto en código cliente?

### Vector 4: Scope Creep Oculto
* ¿El diff contiene modificaciones en archivos no relacionados con la tarea solicitada?
* ¿Se añadieron librerías o dependencias en `package.json` que no estaban presupuestadas?

### Vector 5: Evidencia de Verificación Real
* ¿El implementador corrió efectivamente `typecheck` y los tests, o simplemente asumió que todo funcionaba?

---

## 4. Contrato de Salida del Revisor

El resultado debe presentarse sin rodeos:

```text
### Veredicto de Revisión Adversarial: [APROBADO / RECHAZADO]

1. Hallazgos Críticos (Bloqueantes):
   - [Detalle del fallo con archivo y línea]
2. Observaciones Menores (No bloqueantes):
   - [Sugerencia de refactorización menor]
3. Estado de Pruebas:
   - [Evidencia de typecheck y tests verificada]
4. Acción Requerida:
   - [Corregir X antes de autorizar el merge/cierre]
```
