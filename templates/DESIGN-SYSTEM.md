# DESIGN-SYSTEM — [Nombre del Sistema]

> **Estado:** `borrador` · **Gate:** G3 · **Última actualización:** [AAAA-MM-DD]  
> **Implementación Técnica:** [Tailwind CSS v4 + Radix UI / shadcn/ui / Vanilla CSS Variables]

---

## 1. Principios Visuales y Experiencia de Usuario (UX)

1. **Claridad sobre Decoración:** La interfaz prioriza la legibilidad inmediata de los datos y reduce el ruido visual.
2. **Acción Primaria Inconfundible:** Cada pantalla tiene como máximo un botón o llamada a la acción prominente.
3. **Visibilidad Continua del Estado:** Toda operación asíncrona informa al usuario de su estado en tiempo real.
4. **Accesibilidad Nativa (WCAG 2.1 AA):** Ratios de contraste garantizados, navegación fluida por teclado y etiquetas accesibles.

---

## 2. Insumos Multimodales y Referencias

* **Referencias de Interacción:** [Ej. Linear para densidad de atajos, Stripe para formularios limpios, GitHub para tablas].
* **Capturas y Bocetos Analizados:**
  > *[Pega o vincula aquí las capturas de pantalla, esquemas en Figma o bocetos en papel que Gemini analizó visualmente durante la Ronda 4].*

---

## 3. Design Tokens Fundamentales

### Paleta Semántica de Color (Claro / Oscuro)

| Token | Propósito | Valor Modo Claro | Valor Modo Oscuro |
|---|---|---|---|
| `--bg-canvas` | Fondo general de la aplicación | `#FAFAFA` (Zinc 50) | `#09090B` (Zinc 950) |
| `--bg-surface` | Tarjetas, paneles y modales | `#FFFFFF` (Blanco) | `#18181B` (Zinc 900) |
| `--border-subtle` | Divisores y bordes sutiles | `#E4E4E7` (Zinc 200) | `#27272A` (Zinc 800) |
| `--text-primary` | Títulos y texto de alto contraste | `#09090B` (Zinc 950) | `#F4F4F5` (Zinc 100) |
| `--text-muted` | Subtítulos y metadatos | `#71717A` (Zinc 500) | `#A1A1AA` (Zinc 400) |
| `--primary` | Acción principal / Marca | `#2563EB` (Blue 600) | `#3B82F6` (Blue 500) |
| `--primary-fg` | Texto sobre botón primario | `#FFFFFF` (Blanco) | `#FFFFFF` (Blanco) |
| `--danger` | Acciones destructivas y errores | `#DC2626` (Red 600) | `#EF4444` (Red 500) |
| `--warning` | Alertas preventivas | `#D97706` (Amber 600) | `#F59E0B` (Amber 500) |
| `--success` | Confirmaciones y estados OK | `#16A34A` (Green 600) | `#22C55E` (Green 500) |

> **Garantía de Contraste:** Mínimo ratio **4.5:1** en texto general y **3:1** en elementos interactivos o bordes de foco.

### Tipografía

| Nivel | Tamaño | Peso | Line Height | Uso |
|---|---|---|---|---|
| **Display** | 32px (2rem) | Bold (700) | 1.2 | Encabezado principal de página / Landing |
| **Heading 1** | 24px (1.5rem) | SemiBold (600) | 1.25 | Título de sección o modal principal |
| **Heading 2** | 18px (1.125rem) | Medium (500) | 1.3 | Títulos de tarjetas o bloques |
| **Body (Base)** | 14px (0.875rem) | Regular (400) | 1.5 | Texto principal, inputs y listas |
| **Small / Caption**| 12px (0.75rem) | Regular (400) | 1.4 | Etiquetas secundarias, fechas, badges |
| **Code / Monospace**| 13px (0.8125rem) | Regular (400) | 1.4 | IDs técnicos, hashes, fragmentos de código |

### Escala de Espaciado (Múltiplos de 4px)

* **Tokens:** `4px (1)` · `8px (2)` · `12px (3)` · `16px (4)` · `24px (6)` · `32px (8)` · `48px (12)` · `64px (16)`
* **Regla:** Relleno de botones (8px/16px), separación de campos en formulario (16px), espaciado entre secciones (32px o 48px).

---

## 4. Los 4 Estados Obligatorios por Componente

Todo componente interactivo y vista de datos debe implementar sin excepción:

```
[ Estado de Datos Nominal ]   ──►  Muestra registros con jerarquía clara y acciones secundarias.
[ Estado Loading / Skeleton ] ──►  Estructura visual pulsante sin layout shift (CLS = 0).
[ Estado Error Accionable ]   ──►  Mensaje humano en rojo con botón explícito de "Reintentar".
[ Estado Vacío (Empty State)] ──►  Ilustración/icono, explicación amigable y botón de "Crear primero".
```

---

## 5. Estrategia Responsive y Breakpoints

* **Mobile:** `375px` a `767px` (Una sola columna, botones táctiles de mínimo 44px de alto, navegación inferior o menú hamburguesa accesible).
* **Tablet:** `768px` a `1279px` (Grid adaptativo de 2 columnas, sidebar colapsable).
* **Desktop:** `1280px+` (Layout completo de 3 columnas o tabla de datos expandida).
