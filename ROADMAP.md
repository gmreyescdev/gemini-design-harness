# ROADMAP — Gemini Design Harness

Plan de evolución para futuras versiones del harness.

---

## Versión 1.1.0 (Corto Plazo)
- [ ] **Linter de Markdown para Gates:** Script en Node/PowerShell que valida que todos los checkboxes de `GATE-PRE-CODE.md` y `DOD-SLICE.md` estén marcados antes de permitir commits en git (hook pre-commit).
- [ ] **Generative UI Widget Templates:** Componentes HTML interactivos listos para previsualizar tokens de color y tipografía directamente en el chat de Antigravity durante la Ronda 4 (Diseño).
- [ ] **Sincronización con StitchMCP:** Comandos integrados para exportar o importar variantes de diseño visual creadas con StitchMCP hacia `DESIGN-SYSTEM.md`.

---

## Versión 1.2.0 (Medio Plazo)
- [ ] **Subagente Especializado de Arquitectura:** Integración con `define_subagent` para crear un evaluador formal de seguridad y patrones de base de datos ejecutado con Gemini Pro en G4.
- [ ] **Generador Automático de Diagramas de Base de Datos:** Generación directa de diagramas entidad-relación en Mermaid o SVG a partir de esquemas Prisma, Drizzle o SQL crudo.
- [ ] **Presupuestador Automático de Tokens:** Medidor de consumo estimado de sesión para advertir al usuario sobre la conveniencia de compactar el contexto con `/compact`.
