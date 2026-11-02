# CHANGELOG — Gemini Design Harness

Formato basado en [Keep a Changelog](https://keepachangelog.com/es/1.1.0/).
Versionado Semántico (SemVer).

---

## [1.0.0] — 2026-11-02

### Añadido
- **Lanzamiento inicial del Gemini Design Harness** optimizado específicamente para Gemini (Flash High y Pro) en Antigravity.
- **Protocolo de 6 Gates:** G0 (Intake), G1 (Alcance), G2 (Datos), G3 (Diseño), G4 (Técnico), G5 (Pre-código), G6 (Construcción).
- **Mapeo nativo con Slash Commands de Antigravity:** `/grill-me`, `/plan`, `/boost`, `/compact`.
- **Integración Multimodal de Primera Clase en G3:** Capacidad nativa de Gemini para ingerir wireframes, capturas de interfaz y diagramas visuales.
- **Aritmética de Costes y Prompt Caching:** Guía en `COST.md` detallando prefijos inmutables (>32k tokens) y costos multimodales.
- **Sistema de Subagentes:** Matriz de delegación estricta en `SUBAGENTS.md` basada en los subagentes nativos de Antigravity (`research`, `self`, `image-generator`).
- **Skills integradas:**
  - `skills/gemini-ui-audit`: Auditoría visual de componentes contra `DESIGN-SYSTEM.md`.
  - `skills/gemini-adversarial-review`: Revisión adversarial de slices de código contra `ACCEPTANCE.md`.
- **Plantillas y Checklists completas:** `templates/` para los 6 artefactos maestros y `checklists/` para validación formal pre-código y DoD.
- **Instaladores automatizados:** `install.ps1` (PowerShell) e `install.sh` (Bash).
