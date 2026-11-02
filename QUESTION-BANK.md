# QUESTION-BANK.md — Banco de Preguntas por Rondas para Gemini

Cada ronda de preguntas se formula en **un solo mensaje**. El agente formula un máximo de **5 preguntas**.
Toda pregunta acepta la respuesta `"no sé"`: en tal caso, el agente aplica el **(Recomendado)** y lo asienta como un **supuesto** (`S-XX`) en `PROJECT-STATE.md`.

---

## Ronda 1 — Producto y Usuarios → `SPEC.md` (Gate G0)

| ID | Pregunta Clave | Justificación Técnica | (Recomendado) por Defecto |
|---|---|---|---|
| **P1.1** | ¿Qué es el sistema y qué problema concreto resuelve en una sola frase? | Establece el alcance ontológico de todo el desarrollo. | — (Obligatorio del humano) |
| **P1.2** | ¿Quiénes son los usuarios y qué frecuencia de uso tendrán? | Define la complejidad de la UI, flujos de onboarding y modelos de sesión. | 2 roles: Usuario final habitual + Administrador de plataforma. |
| **P1.3** | ¿Cuál es la **acción central** repetitiva (el verbo principal)? | Prioriza la pantalla principal, índices de base de datos y diseño UX. | — (Obligatorio del humano) |
| **P1.4** | ¿Cómo se resuelve este problema actualmente y cuál es la mayor fricción? | Identifica la propuesta de valor real frente a soluciones manuales. | Hojas de cálculo compartidas + Mensajería/Email. |
| **P1.5** | ¿Qué significa éxito a 90 días expresado en una sola métrica verificable? | Previene la creación de features innecesarias sin impacto medible. | "X usuarios activos completan la acción central al menos Z veces por semana". |

* **Pregunta de Cierre:** *"¿Hay algún aspecto crítico del negocio o del usuario que no hayamos tocado y que condicione el diseño?"*

---

## Ronda 2 — Alcance y Límites → `SPEC.md` v1 + `ROADMAP.md` v0 (Gate G1)

| ID | Pregunta Clave | Justificación Técnica | (Recomendado) por Defecto |
|---|---|---|---|
| **P2.1** | ¿Cuáles son las 3 a 5 features indispensables que conforman el MVP? | Delimita el perímetro construible en la primera fase. | Flujo de autenticación, CRUD de la entidad principal, panel de listado y métricas básicas. |
| **P2.2** | ¿Qué queda **explícitamente fuera** de esta primera versión? | Elimina falsas expectativas y frena el *scope creep*. | Todo lo no listado en P2.1 (ej. facturación automatizada, integraciones complejas de terceros, apps móviles nativas). |
| **P2.3** | ¿Existe una fecha límite fija o un hito de entrega inamovible? | Determina el balance entre profundidad técnica y velocidad. | Sin fecha externa crítica; objetivo MVP funcional en 4 a 6 semanas. |
| **P2.4** | ¿Quién aprueba el software y quién lo utiliza? ¿Son la misma persona? | Revela requisitos ocultos corporativos o de cumplimiento. | El usuario directo es el tomador de decisiones. |
| **P2.5** | ¿La arquitectura será para un solo cliente o Multi-Tenant? | Modifica drásticamente el modelo de base de datos, aislamiento y autenticación. | Single-Tenant o partición lógica básica hasta validar tracción. |

* **Pregunta de Cierre:** *"Si tuvieras que lanzar una versión utilizable en 10 días, ¿cuáles dos funcionalidades salvarías a toda costa?"*

---

## Ronda 3 — Modelo de Datos y Permisos → `DATA-MODEL.md` (Gate G2)

| ID | Pregunta Clave | Justificación Técnica | (Recomendado) por Defecto |
|---|---|---|---|
| **P3.1** | ¿Cuál es la entidad central y cómo se identificará? | Constituye el núcleo de la base de datos relacional/documental. | Clave UUID v7 (ordenable temporalmente) + slug o identificador natural. |
| **P3.2** | ¿Cuáles son las relaciones principales (1:N, N:M)? | Define esquemas, tablas intermedias y necesidades de joins/agregaciones. | 1 Organización tiene N Usuarios; 1 Usuario gestiona N Entidades Centrales. |
| **P3.3** | ¿Qué roles existen y qué permisos tiene cada uno sobre los datos? | Establece la matriz de autorización (RBAC) y políticas de seguridad (RLS). | Dueño (Control total), Editor (Crear/Modificar), Lector (Solo lectura). |
| **P3.4** | ¿Se gestionarán datos sensibles (pagos, salud, contraseñas, PII)? | Obliga a implementar cifrado en reposo, auditoría y cumplimiento normativo. | PII mínima estándar: Correo electrónico, nombre y hash de autenticación seguro. |
| **P3.5** | ¿Cuál es la política de ciclo de vida del dato (borrado blando, retención, exportación)? | Define integridad referencial y requerimientos legales. | *Soft delete* (`deleted_at`) + Capacidad de exportación en JSON/CSV. |

* **Pregunta de Cierre:** *"¿Qué dato o registro, en caso de pérdida o filtración involuntaria, causaría un daño irreparable al proyecto?"*

---

## Ronda 4 — UI, Sistema Visual y UX → `DESIGN-SYSTEM.md` (Gate G3)

> **Capacidad Multimodal:** Puedes arrastrar o adjuntar capturas de interfaces de referencia, bocetos a mano o wireframes directamente al chat.

| ID | Pregunta Clave | Justificación Técnica | (Recomendado) por Defecto |
|---|---|---|---|
| **P4.1** | ¿Qué 2 o 3 aplicaciones de referencia admiras visual y funcionalmente? | Establece el estándar estético de interacción sin ambigüedades. | Linear, Stripe, GitHub o Notion. |
| **P4.2** | ¿Existe ya una identidad visual previa (colores de marca, tipografías, logo)? | Permite generar los design tokens exactos desde el inicio. | Neutra moderna: Slate/Zinc con un color de acento primario (Indigo o Azul) y tipografía sans-serif de sistema (Inter). |
| **P4.3** | ¿Qué densidad de información se requiere? | Determina el espaciado, alturas de fila en tablas y jerarquía visual. | Espaciado equilibrado con tablas de datos en modo compacto. |
| **P4.4** | ¿Estrategia de temas: Modo claro, modo oscuro o soporte automático? | Multiplica o simplifica la definición de tokens semánticos de color. | Soporte nativo para modo claro y oscuro con switch accesible. |
| **P4.5** | ¿Estrategia de dispositivos y responsive? | Define breakpoints CSS y prioridad en la distribución de controles. | Mobile-First o Desktop-First adaptativo (Breakpoints: 375px, 768px, 1280px). |

* **Pregunta de Cierre:** *"¿Tienes alguna captura, diagrama o boceto de pantalla que quieras compartir para extraer su diseño directamente?"*

---

## Ronda 5 — Stack Tecnológico y Arquitectura → `ARCHITECTURE.md` (Gate G4)

| ID | Pregunta Clave | Justificación Técnica | (Recomendado) por Defecto |
|---|---|---|---|
| **P5.1** | ¿Cuál es el stack de Frontend y Backend preferido o requerido? | Congela tecnologías base, compiladores y ecosistema de paquetes. | TypeScript + Next.js (App Router) o Vite/React + Node/PostgreSQL. |
| **P5.2** | ¿Cómo se gestionará la autenticación y sesiones? | Define el perímetro de seguridad y cookies/tokens. | Auth gestionado seguro (Supabase Auth / Auth.js / Clerk) con validación en servidor. |
| **P5.3** | ¿Dónde y cómo se desplegará el sistema? | Determina si el código debe soportar Serverless, Edge o Contenedores Docker. | Vercel / Railway / Cloudflare con base de datos en Neon o Supabase. |
| **P5.4** | ¿Cuál es la estrategia de manejo de estado y consumo de datos? | Previene re-renders innecesarios y desorden en peticiones de red. | Server Components / TanStack Query (React Query) + validación de esquemas con Zod. |
| **P5.5** | ¿Cuál es la observabilidad mínima requerida? | Garantiza diagnóstico de incidencias en producción. | Logger estructurado + captura básica de excepciones con Sentry o log centralizado. |

---

## Ronda 6 — Criterios de Aceptación y Riesgos → `ACCEPTANCE.md` (Gate G4)

| ID | Pregunta Clave | Justificación Técnica | (Recomendado) por Defecto |
|---|---|---|---|
| **P6.1** | ¿Cuáles son los 3 flujos de usuario más críticos que nunca deben fallar? | Define las suites de pruebas E2E y de integración obligatorias. | Registro/Login, Creación de la Entidad Central, Visualización del Listado filtrado. |
| **P6.2** | ¿Qué condiciones de rendimiento mínimas se exigen? | Establece presupuestos de bundle y latencia de respuesta de API. | LCP < 2.5s, tiempo de respuesta de API < 300ms en percentil 95. |
| **P6.3** | ¿Cuáles son los principales riesgos técnicos o de dependencias de terceros? | Prepara planes de contingencia antes de iniciar el desarrollo. | Fallo o latencia de API externa → Mitigación: Colas y reintentos exponenciales con circuit breaker. |
| **P6.4** | ¿Cómo se estructurará la secuencia de Slices Verticales en el Roadmap? | Organiza la entrega funcional en módulos demostrables independientes. | Slice 1: Setup + Auth + Layout; Slice 2: CRUD Entidad Core; Slice 3: Permisos y Métricas. |
