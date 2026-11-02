# PROJECT-STATE — [Nombre del Sistema]

> **Single Source of Truth (Fuente Única de Verdad).**  
> El modelo Gemini debe leer este archivo obligatoriamente al inicio de cada sesión y actualizarlo inmediatamente al cerrar cualquier ronda, decisión o slice vertical.
> Si el estado indicado aquí y los archivos del proyecto no coinciden, **prevalece el archivo más reciente** y este documento se sincroniza de inmediato.

* **Última Actualización:** [AAAA-MM-DD HH:MM]
* **Modo de Trabajo:** `[Express / Completo]`
* **Gate Actual:** `[G0 / G1 / G2 / G3 / G4 / G5 / G6]`
* **Próximo Paso Operativo:** [Una frase clara y ejecutable]

---

## 1. Estado de los Artefactos

| Artefacto | Estado | Aprobado por | Fecha de OK | Notas / Discrepancias |
|---|---|---|---|---|
| **SPEC.md** | `pendiente` | — | — | Requiere Ronda 1 y Ronda 2 |
| **DATA-MODEL.md** | `pendiente` | — | — | Requiere Ronda 3 |
| **DESIGN-SYSTEM.md** | `pendiente` | — | — | Requiere Ronda 4 (Multimodal) |
| **ARCHITECTURE.md** | `pendiente` | — | — | Requiere Ronda 5 |
| **ACCEPTANCE.md** | `pendiente` | — | — | Requiere Ronda 6 |
| **ROADMAP.md** | `pendiente` | — | — | Requiere Ronda 2 y Ronda 6 |
| **GATE-PRE-CODE.md** | `pendiente` | — | — | Gate G5 antes de codificar |

*Estados posibles:* `pendiente` · `borrador` · `en revisión` · `aprobado` · `REVISAR` (cuando un cambio posterior afecta el artefacto).

---

## 2. Registro Inmutable de Decisiones de Arquitectura (ADR)

| ID | Fecha | Decisión Acordada | Justificación Técnica | Alternativa Descartada | Reversible | Supersedida por |
|---|---|---|---|---|---|---|
| **D-01** | [Fecha] | [Ej. Next.js App Router] | [Soporte Server Components] | [Vite SPA] | Sí | — |

> *Regla:* Una decisión nunca se edita ni se borra. Si cambia el requerimiento, se registra una nueva decisión (ej. `D-02`) indicando que supersede a la anterior.

---

## 3. Registro de Supuestos de Diseño

| ID | Supuesto Asumido | Impacto Técnico si es Falso | Disparador de Validación Obligatorio | Estado Actual |
|---|---|---|---|---|
| **S-01** | [Premisa técnica o negocio] | [Riesgo de costo o retrabajo] | [Ej. Validar en Gate G4 con cliente] | `abierto` |

*Estados posibles:* `abierto` · `validado` · `refutado` (obliga a crear nueva decisión).

---

## 4. Preguntas Abiertas y Bloqueantes

| # | Pregunta Clave | Responsable Asignado | Resolver antes de Gate | Estado |
|---|---|---|---|---|
| **Q-01** | [Duda de negocio o técnica] | [Humano / Agente] | [G1 / G2 / G3 / G4] | `abierta` |

---

## 5. Matriz de Riesgos del Proyecto

| Riesgo Detectado | Probabilidad | Impacto | Estrategia de Mitigación | Dueño |
|---|---|---|---|---|
| [Riesgo técnico o de tiempo] | Media | Alto | [Plan de acción concreto] | [Agente / Humano] |

---

## 6. Progreso de Slices en Construcción (Gate G6)

| Slice | Nombre de la Funcionalidad | Estado | Comandos de Verificación |
|---|---|---|---|
| **Slice 0** | Setup base y configuración | `pendiente` | `npm run build && npm run typecheck` |
| **Slice 1** | Autenticación y Layout base | `pendiente` | Tests unitarios + E2E login |
| **Slice 2** | CRUD de Entidad Principal | `pendiente` | Tests de integración API + UI |
