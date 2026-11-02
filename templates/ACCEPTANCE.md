# ACCEPTANCE — Criterios de Aceptación y Calidad

> **Estado:** `borrador` · **Gate:** G4 · **Última actualización:** [AAAA-MM-DD]  
> **Aprobado por:** [Nombre del Usuario] · **Fecha de aprobación:** [AAAA-MM-DD]

---

## 1. Criterios de Aceptación por Feature (Formato BDD)

### Feature 1: [Nombre de la Feature, ej. Creación de Entidad Core]
* **Escenario Exitoso (Happy Path):**
  * **Dado** que un usuario autenticado con rol Editor está en la pantalla de nuevo registro,
  * **Cuando** completa el formulario con datos válidos y pulsa "Guardar",
  * **Entonces** el sistema persiste la entidad en la base de datos, muestra un toast de confirmación verde y redirige al listado mostrando el nuevo elemento al inicio.
* **Escenario de Validación Errónea:**
  * **Dado** que el usuario deja campos obligatorios vacíos o ingresa un formato inválido,
  * **Cuando** intenta enviar el formulario,
  * **Entonces** el sistema previene el envío a la red y resalta los campos afectados con mensajes de error accesibles.
* **Escenario de Falla de Red / Servidor:**
  * **Dado** que el servidor experimenta una caída o error 500 durante la petición,
  * **Cuando** el usuario envía el formulario,
  * **Entonces** se muestra un banner de error descriptivo con un botón de "Reintentar" sin perder los datos ya escritos.

---

## 2. Criterios de Calidad No Funcionales (Obligatorios)

### Rendimiento (Web Vitals)
- [ ] **LCP (Largest Contentful Paint):** Menor a **2.5 segundos** en conexión 4G móvil.
- [ ] **CLS (Cumulative Layout Shift):** Menor a **0.1** (sin saltos bruscos durante la carga).
- [ ] **Tiempo de Respuesta de API:** P95 inferior a **300ms** en operaciones de lectura y **500ms** en escritura.

### Accesibilidad (WCAG 2.1 Nivel AA)
- [ ] Todo elemento interactivo (botones, enlaces, inputs) es operable mediante teclado (`Tab`, `Enter`, `Space`).
- [ ] Los modales atrapan el foco (`focus trap`) y se cierran con la tecla `Escape`.
- [ ] Los contrastes de color superan el ratio mínimo de 4.5:1.

### Robustez y Seguridad
- [ ] Todos los inputs de usuario son sanitizados y validados contra esquemas Zod tanto en cliente como en servidor.
- [ ] No existen endpoints o acciones de servidor expuestas sin comprobación de sesión.
- [ ] Cero exposición de variables de entorno sensibles en el cliente.
