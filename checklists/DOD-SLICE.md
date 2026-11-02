# DEFINITION OF DONE (DoD) — Checklist por Slice Vertical

> Este checklist debe cumplirse **en cada slice vertical desarrollado en el Gate G6** antes de dar por cerrada la tarea y pasar a la siguiente funcionalidad del Roadmap.

**Slice:** [Número y Nombre] · **Fecha:** [AAAA-MM-DD] · **Implementado por:** [Agente Gemini]

---

## 1. Completitud Funcional
- [ ] Criterios de aceptación específicos del slice (definidos en `ACCEPTANCE.md`) satisfechos al 100%.
- [ ] Flujo completo implementado (Ruta → UI → Acción / API → Persistencia de datos).
- [ ] Sin datos "hardcodeados" simulados en pantallas de producción.

---

## 2. Robustez de Interfaz y Estados
- [ ] **Estado Loading:** Feedback visual inmediato (skeleton o spinner con CLS = 0).
- [ ] **Estado Error:** Manejo amigable de fallos con botón de reintento accesible.
- [ ] **Estado Vacío (Empty):** Vista orientada a la acción cuando no hay registros.
- [ ] **Estado Nominal (Success):** Renderizado limpio con jerarquía tipográfica correcta.
- [ ] Responsive verificado en anchos de pantalla estándar: Mobile (375px), Tablet (768px) y Desktop (1280px).

---

## 3. Calidad de Código y Tipado
- [ ] TypeScript estricto: cero uso de `any` sin tipar, cero `@ts-ignore` sin justificar.
- [ ] Linter ejecutado sin errores ni advertencias de formato (`eslint` / `biome` en verde).
- [ ] Separación limpia entre componentes de presentación y hooks/servicios de datos.

---

## 4. Verificación Real por Consola
- [ ] `typecheck` ejecutado en consola con salida limpia (Exit code: 0).
- [ ] `build` de la aplicación ejecutado y exitoso.
- [ ] Pruebas unitarias o de integración relevantes escritas y pasando en verde.
- [ ] Evidencia de ejecución (comandos y resultados) reportada en el chat.

---

## 5. Documentación y Estado Vivo
- [ ] `git diff --stat` presentado al usuario resumiendo los archivos tocados.
- [ ] `state/PROJECT-STATE.md` actualizado con el avance real, decisiones tomadas y próximo slice.
