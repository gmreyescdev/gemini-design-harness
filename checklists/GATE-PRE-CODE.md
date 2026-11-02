# GATE PRE-CÓDIGO (G5) — Checklist de Aprobación Formal

> **Regla Inquebrantable:** No se escribe una sola línea de código de producto hasta que **todos** los ítems de este checklist estén marcados como verificados o formalmente aceptados como riesgo técnico por el usuario.

**Proyecto:** [ ] · **Fecha:** [AAAA-MM-DD] · **Aprobado por:** [ ]

---

## A. Producto y Alcance (Gates G0 y G1)

- [ ] Problema central definido con claridad en 2–3 frases sin mencionar tecnologías.
- [ ] Roles de usuario, frecuencia de interacción y nivel técnico identificados.
- [ ] Acción central definida mediante un verbo operativo medible.
- [ ] Alcance de MVP delimitado estrictamente a 3–5 features con su criterio de "Done".
- [ ] Lista explícita de elementos "Fuera de Alcance" aprobada para evitar scope creep.
- [ ] Métrica clave de éxito (KPI) a 90 días definida con método de medición.
- [ ] `SPEC.md` completo, consistente y formalmente aprobado.

---

## B. Modelo de Datos y Permisos (Gate G2)

- [ ] Entidad central e identificadores únicos (UUID v7 recomendados) definidos.
- [ ] Diagrama Entidad-Relación (Mermaid) completo con cardinalidades claras.
- [ ] Matriz de roles y permisos (RBAC) documentada para cada operación (CRUD).
- [ ] Datos sensibles y PII identificados con estrategia de cifrado y aislamiento.
- [ ] Políticas de ciclo de vida del dato (borrado blando, retención y exportación) cerradas.
- [ ] Reglas de negocio e invariantes del modelo listadas y sin contradicciones.
- [ ] `DATA-MODEL.md` formalmente aprobado.

---

## C. Sistema de Diseño e Interfaz (Gate G3)

- [ ] Tokens semánticos de color definidos para modo claro y modo oscuro.
- [ ] Ratio de contraste mínimo (WCAG AA: 4.5:1 texto, 3:1 bordes interactivos) verificado.
- [ ] Jerarquía tipográfica establecida con un máximo de 2 familias de fuentes.
- [ ] Escala de espaciado modular en múltiplos de 4px fijada.
- [ ] Los 4 estados de componente (`loading`, `error`, `empty`, `success`) definidos.
- [ ] Breakpoints responsive y estrategia mobile/desktop acordados.
- [ ] Wireframes, capturas o bocetos visuales analizados e integrados.
- [ ] `DESIGN-SYSTEM.md` formalmente aprobado.

---

## D. Arquitectura Técnica y Operación (Gate G4)

- [ ] Stack tecnológico, frameworks y dependencias clave fijados con versiones exactas.
- [ ] Estructura de carpetas acordada y validada contra la arquitectura elegida.
- [ ] Flujo de autenticación y autorización validado obligatoriamente en servidor.
- [ ] Separación clara de secretos de backend vs variables públicas del cliente.
- [ ] Entorno de despliegue, proveedor de base de datos y hosting definidos.
- [ ] Estrategia de testing (typecheck, linters, unitarias y E2E críticas) acordada.
- [ ] Matriz de riesgos técnicos con planes de mitigación concretos.
- [ ] `ARCHITECTURE.md` formalmente aprobado.

---

## E. Criterios de Aceptación y Roadmap (Gate G4)

- [ ] Escenarios de prueba en formato BDD (Dado-Cuando-Entonces) redactados para cada feature.
- [ ] Criterios no funcionales (Web Vitals: LCP < 2.5s, CLS < 0.1) estipulados.
- [ ] Secuencia lógica de Slices Verticales ordenada y demostrable de extremo a extremo.
- [ ] `ACCEPTANCE.md` y `ROADMAP.md` formalmente aprobados.

---

## F. Cierre de Compuerta y Autorización Humana

- [ ] Todos los supuestos abiertos (`S-XX`) en `PROJECT-STATE.md` cuentan con disparador de validación.
- [ ] Ninguna pregunta crítica (`Q-XX`) quedó sin resolver o sin dueño asignado.
- [ ] El usuario humano otorgó su **OK EXPLÍCITO** en el chat para comenzar la construcción.

---

**Dictamen del Gate:** `[ ] APROBADO PARA CONSTRUIR (G6)` / `[ ] BLOQUEADO`

*Si el Gate está bloqueado, el agente solo formulará las preguntas necesarias para desbloquear los puntos pendientes. Queda terminantemente prohibido comenzar a codificar "mientras tanto".*
