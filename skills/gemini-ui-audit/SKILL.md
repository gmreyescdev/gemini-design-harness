---
name: gemini-ui-audit
description: Auditoría visual, accesible y semántica de componentes o vistas web frente a DESIGN-SYSTEM.md.
---

# Auditoría Visual y de Interfaz (Gemini UI Audit)

Procedimiento estandarizado para auditar cualquier componente, pantalla o formulario antes de dar por completado un slice vertical en el Gate G6.

---

## 1. Disparador (Cuándo Invocarse)
* Al finalizar la maquetación de una vista o componente nuevo.
* Cuando el usuario solicite: *"Audita la UI de [componente/ruta]"* o *"Verifica el diseño visual contra DESIGN-SYSTEM.md"*.
* Antes de someter un slice vertical al checklist `DOD-SLICE.md`.

---

## 2. Archivos de Entrada
* `docs/harness/templates/DESIGN-SYSTEM.md` (o el Design System activo del proyecto).
* El archivo de código de la vista (ej. `src/components/...` o `src/app/...`).
* Opcional: Captura de pantalla del componente renderizado para inspección multimodal.

---

## 3. Lista de Comprobación Paso a Paso

### 3.1 Verificación de Tokens Semánticos
1. Comprobar que no existan valores de color hexadecimales arbitrarios (*hardcodeados*) en el código.
2. Verificar que se empleen las clases semánticas o variables CSS del Design System (ej. `bg-canvas`, `text-primary`, `border-subtle`).
3. Comprobar que los textos secundarios utilicen la clase de contraste adecuada (`text-muted`).

### 3.2 Los 4 Estados Obligatorios
1. **Loading:** ¿Existe un skeleton o estado de carga mientras se obtienen los datos?
2. **Error:** Si la petición falla, ¿aparece una alerta clara con botón de reintentar?
3. **Empty:** Si la lista o registro no contiene elementos, ¿hay un estado vacío explicativo?
4. **Success:** ¿La vista nominal renderiza los datos sin saltos de layout (*CLS*)?

### 3.3 Accesibilidad (WCAG 2.1 AA)
1. Contrastes: Texto normal $\ge 4.5:1$, texto grande/iconos $\ge 3:1$.
2. Navegación por teclado: ¿Todos los botones e inputs reciben foco visible (`ring-focus`)?
3. Formularios: ¿Todos los `<input>` tienen su `<label>` asociado o `aria-label`?
4. Botones con solo icono: ¿Cuentan con texto accesible para lectores de pantalla (`sr-only` o `aria-label`)?

### 3.4 Responsive y Dispositivos
1. Mobile (375px): Elementos en una columna, controles táctiles accesibles ($\ge 44\times 44\text{ px}$).
2. Desktop (1280px+): Aprovechamiento equilibrado del ancho de pantalla sin líneas de texto infinitas (máximo 75–80 caracteres por línea de lectura).

---

## 4. Salida Esperada de la Auditoría

El agente debe emitir un reporte en este formato conciso:

```text
### Reporte de Auditoría UI — [Nombre del Componente]
- [✓] Tokens de color y espaciado: Conforme con DESIGN-SYSTEM.md.
- [✓] 4 Estados de interfaz: Implementados (Loading Skeleton, Error Banner, Empty Card, Datos).
- [!] Accesibilidad: Faltaba aria-label en botón de borrado -> Corregido.
- [✓] Responsive: Verificado en 375px y 1280px.
Dictamen: APROBADO para DoD.
```
