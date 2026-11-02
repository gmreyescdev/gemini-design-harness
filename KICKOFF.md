# KICKOFF.md — Prompts Listos para Copiar y Pegar

Colección de prompts optimizados para interactuar con Gemini en cada fase del ciclo de vida del arnés.

---

## 1. Arranque del Proyecto

### Modo Express (30–45 minutos, defaults recomendados aplicados)
```text
Inicia el Gemini Design Harness en modo Express. Hazme las preguntas de la Ronda 1 (Intake).
```

### Modo Completo (Paso a paso, análisis exhaustivo)
```text
Inicia el Gemini Design Harness en modo Completo. Vamos a recorrer las 6 rondas con calma. Preséntame la Ronda 1.
```

### Modo Interrogatorio Profundo con Slash Command
```text
/grill-me Actúa como Arquitecto de Software Principal e inicia el Gemini Design Harness. Interrógate sobre los puntos débiles de mi idea en la Ronda 1.
```

---

## 2. Continuar y Retomar Sesiones Anteriores

### Reanudar Trabajo tras Pausa
```text
Lee docs/harness/state/PROJECT-STATE.md y los artefactos de la fase actual.
Indícame en 3 líneas: en qué Gate estamos, qué decisiones o supuestos están pendientes y cuál es el siguiente paso propuesto. No escribas código aún.
```

### Avanzar de Ronda / Gate
```text
Apruebo el artefacto de la ronda anterior. Actualiza docs/harness/state/PROJECT-STATE.md y lánzame las preguntas de la siguiente Ronda.
```

---

## 3. Aprobación y Gate Pre-Código (G5)

### Revisión del Gate Pre-Código
```text
Hemos terminado la especificación técnica. Lee docs/harness/checklists/GATE-PRE-CODE.md, evalúa cada uno de los ítems contra los artefactos generados e indícame si estamos listos para construir o qué falta por definir.
```

### Auditoría Adversarial con Boost
```text
/boost Realiza una revisión crítica y adversarial completa de SPEC.md, DATA-MODEL.md, DESIGN-SYSTEM.md y ARCHITECTURE.md antes de autorizar el Gate G5. Busca contradicciones, huecos de seguridad o invariantes no cubiertas.
```

---

## 4. Construcción por Slices en G6

### Planificar el Siguiente Slice Vertical
```text
/plan Vamos a implementar el Slice [N]: [Nombre de la Feature].
Revisa docs/harness/templates/ACCEPTANCE.md y desglosa el plan de ejecución en 4 pasos (Ruta → UI → Datos → Verificación). No toques archivos todavía.
```

### Ejecutar Slice con Verificación Estricta
```text
Implementa el Slice [N] siguiendo el plan acordado.
Asegúrate de cubrir los estados de loading, error, vacío y éxito.
Al terminar, ejecuta typecheck, lint y tests, y muéstrame el git diff --stat con la evidencia de ejecución.
```

---

## 5. Spikes Técnicos Exploratorios

### Solicitar Spike Descartable
```text
Necesito validar la viabilidad técnica de [Tecnología / API / Flujo] antes de cerrar la decisión en la arquitectura.
Crea un spike descartable en spikes/spike-[tema].ts (máximo 1 archivo). No toques código de producto ni modifiques dependencias de producción.
```

---

## 6. Mantenimiento y Compresión de Contexto

### Resumen y Compresión de Conversación
```text
/compact Hemos terminado una sesión intensa de especificación. Asegúrate de que todas las decisiones y supuestos estén persistidos en docs/harness/state/PROJECT-STATE.md antes de compactar el historial.
```
