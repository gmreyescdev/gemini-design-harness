# Carpeta de Skills de Gemini Design Harness

Este directorio contiene procedimientos operativos reutilizables que los modelos Gemini pueden cargar bajo demanda para ejecutar tareas complejas, repetitivas o críticas.

---

## Compatibilidad de Entornos

Las skills de este harness son compatibles con:
1. **Antigravity:** Se instalan en `.gemini/skills/` (o son leídas directamente desde la raíz de configuración).
2. **OpenCode:** Se instalan en `.opencode/skills/`.

Ambos entornos reconocen la cabecera YAML estándar de `SKILL.md` con los metadatos `name` y `description`.

---

## Estructura de una Skill

Cada skill debe residir en su propio subdirectorio con un archivo `SKILL.md`:

```text
skills/
├── _TEMPLATE/
│   └── SKILL.md                 # Plantilla base para nuevas skills
├── gemini-ui-audit/
│   └── SKILL.md                 # Auditoría de interfaz y diseño visual
└── gemini-adversarial-review/
    └── SKILL.md                 # Revisión adversarial pre-entrega
```

---

## Skills Preinstaladas

* [`gemini-ui-audit`](gemini-ui-audit/SKILL.md): Inspección visual y estática de accesibilidad, tokens de color, responsive y los 4 estados de interfaz frente a `DESIGN-SYSTEM.md`.
* [`gemini-adversarial-review`](gemini-adversarial-review/SKILL.md): Auditoría estricta de un diff de código frente a los criterios de `ACCEPTANCE.md` para evitar regresiones o atajos de implementación.
