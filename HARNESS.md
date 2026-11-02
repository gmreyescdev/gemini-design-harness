# HARNESS.md — Protocolo de Diseño y Gates para Gemini

Este documento establece el **proceso metódico** mediante el cual una idea conceptual se transforma en un sistema de software robusto, verificable y modular sin invenciones arbitrarias por parte del agente.

---

## 1. Las 6 Compuertas (Gates) de Calidad

| Gate | Ronda | Pregunta Central | Artefacto Generado | Criterio de Salida |
|---|---|---|---|---|
| **G0 Intake** | R1 | ¿Qué problema resuelve, para quién y cuál es la acción clave? | `SPEC.md` (v0) | Problema en 1 frase, actores, verbo principal y éxito a 90 días definidos. |
| **G1 Alcance** | R2 | ¿Qué conforma el MVP y qué queda explícitamente afuera? | `SPEC.md` (v1) + `ROADMAP.md` (v0) | Lista cerrada de 3 a 5 features y lista de no-alcance aprobada. |
| **G2 Modelo de Datos** | R3 | ¿Qué información persiste y qué permisos rigen el acceso? | `DATA-MODEL.md` | Entidades, claves primarias/foráneas, matriz RBAC y datos sensibles delimitados. |
| **G3 Sistema de Diseño** | R4 | ¿Cómo interactúa el usuario y qué patrones visuales aplican? | `DESIGN-SYSTEM.md` | Tokens (color, tipografía, espacio), componentes base, estados y wireframes validados. |
| **G4 Arquitectura Técnica** | R5 + R6 | ¿Con qué tecnologías se construye y cómo se mitigan fallos? | `ARCHITECTURE.md` + `ACCEPTANCE.md` + `ROADMAP.md` (v1) | Stack fijado, flujo de autenticación, esquema de deploy, riesgos y criterios BDD. |
| **G5 Pre-código** | — | ¿Está todo especificado sin vacíos críticos? | `GATE-PRE-CODE.md` | Checklist 100% verificado + aprobación explícita humana. |
| **G6 Construcción** | — | ¿El software implementado cumple la especificación? | Slices verticales + `DOD-SLICE.md` | Cada slice compilado, probado y documentado. |

> **Regla de oro de los Gates:** Ningún gate se cierra por suposición ni por prisa. Se cierra exclusivamente cuando el artefacto está escrito, coherente y aprobado explícitamente por el usuario humano.

---

## 2. Dinámica de una Ronda de Preguntas

Para maximizar la claridad y reducir la sobrecarga cognitiva del usuario:

1. **Apertura:** Anuncia la ronda:
   > *"Ronda N — [Tema]. A continuación te haré [X] preguntas clave. Puedes elegir la opción recomendada, responder libremente o decir 'no sé' para que aplique el estándar."*
2. **Formulación:**
   * Máximo **5 preguntas concisas** por mensaje.
   * Cada pregunta incluye su `(Recomendado: ...)` basado en estándares de la industria.
   * Si el tema es visual (Ronda 4), invita al usuario a adjuntar capturas o bocetos.
3. **Espera activa:** Espera la respuesta del usuario. No generes el artefacto antes de recibir retroalimentación o la confirmación de defaults.
4. **Persistencia:** Redacta o actualiza el archivo en `docs/harness/templates/` y actualiza la sección correspondiente de `state/PROJECT-STATE.md`.
5. **Cierre de Ronda:** Presenta:
   * 5 a 8 viñetas con los puntos consolidados.
   * Supuestos adoptados (`S-XX`).
   * Petición de validación: *"¿Apruebas este artefacto para avanzar al Gate siguiente o ajustamos algún punto?"*

---

## 3. Manejo Disciplinado de Supuestos

Cuando el usuario responda *"no sé"*, *"como te parezca mejor"* o surja una laguna no resuelta:

1. Proponer una alternativa técnica o de negocio fundamentada.
2. Registrarla obligatoriamente en `state/PROJECT-STATE.md` bajo el formato:
   * **ID:** `S-01`, `S-02`, etc.
   * **Supuesto:** Declaración clara de la premisa asumida.
   * **Impacto si es falso:** Qué componente o costo se vería afectado.
   * **Disparador de Validación:** Hito en el que debe validarse obligatoriamente (ej. *"Validar con prueba de carga antes del Slice 3"* o *"Confirmar con el cliente antes de implementar pasarela de pago"*).
3. **Nunca** tratar un supuesto como una decisión definitiva.

---

## 4. Registro Inmutable de Decisiones de Arquitectura (ADR)

* Cada decisión relevante se documenta en `state/PROJECT-STATE.md`:
  $$\text{D-XX} \mid \text{Fecha} \mid \text{Decisión} \mid \text{Motivo técnico} \mid \text{Alternativas descartadas} \mid \text{Reversibilidad}$$
* **Inmutabilidad:** Si una decisión tomada en G2 cambia durante G4, la decisión original **no se edita ni se borra**. Se crea una nueva decisión (ej. `D-08`) que explicite: *"Supersede a D-02 por motivo de..."*.
* Cualquier cambio que afecte artefactos previos pone automáticamente a esos artefactos en estado **`REVISAR`**.

---

## 5. Spikes Técnicos (Válvula de Escape)

Si durante el diseño surge una duda de viabilidad técnica (ej. compatibilidad de librerías, latencia de un SDK o comportamiento de una API de terceros):

* Se permite escribir un **Spike** aislado en `spikes/`.
* **Restricciones:** Máximo 1 archivo autocontenido, sin lógica de negocio final.
* Debe registrarse en `PROJECT-STATE.md` con su objetivo y tiempo límite.
* Una vez completada la prueba, el spike se documenta y se aísla o elimina. **Nunca se promueve código de spike directamente a producción sin pasar por G5 y G6.**

---

## 6. Sinergia con Slash Commands de Antigravity

El protocolo se potencia directamente con los comandos nativos del entorno:

* **`/grill-me`:** Utilízalo en las Rondas 1 a 4 para someter la idea de producto a un interrogatorio técnico exhaustivo que descubra casos borde y limitaciones ocultas.
* **`/plan`:** Utilízalo al inicio de G4 (Técnico) o antes de iniciar un slice vertical complejo en G6 para desglosar la secuencia exacta de cambios en archivos.
* **`/boost`:** Recomendado en el Gate G5 para ejecutar una revisión adversarial profunda de toda la especificación antes de autorizar la primera línea de código.
* **`/compact`:** Cuando la conversación sea muy extensa tras varias rondas, utilízalo para consolidar el contexto en base al `PROJECT-STATE.md`.
