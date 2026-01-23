# UI/UX Design Principles

## Purpose

Define universal guidelines for clear, consistent, accessible UI.

## Scope

- In: layout, typography, color, components, responsiveness,
  accessibility.
- Out: implementation details or framework-specific guidance.

## Core Philosophy

| Principle       | Definition                                                | Application                                             |
| :-------------- | :-------------------------------------------------------- | :------------------------------------------------------ |
| **Clarity**     | User always understands current state and action outcomes | Avoid ambiguity, provide clear labels, visible feedback |
| **Consistency** | Similar elements behave identically                       | Reduce cognitive load through predictable patterns      |
| **Simplicity**  | Every element serves a purpose                            | Aggressively remove clutter, focus attention            |

## Visual Design Foundation

### Layout & Spacing

**Grid System**

- Use column-based grid (12-column standard for web)
- Ensures alignment and professional organization
- All elements snap to grid for visual harmony

**Spacing Scale**

- Establish consistent spacing based on multiples of 4 or 8
- Example scale: 4px, 8px, 12px, 16px, 24px, 32px, 48px, 64px
- Creates visual rhythm, makes components feel cohesive
- **Recommendation**: 8-point grid system for all spacing and sizing

**Whitespace Strategy**

- Whitespace groups related items and separates unrelated ones
- Provides visual breathing room for content
- More whitespace = clearer hierarchy and reduced overwhelm

### Typography

**Font Family Limits**

- Maximum 2 font families per application
- Display font: Headings and emphasis
- Body font: Paragraphs and UI text
- Use clean sans-serif fonts for maximum readability

**Type Scale**

- Define hierarchical text sizes: 12px, 14px, 16px, 20px, 24px, 32px,
  48px
- Communicates information importance visually
- Maintain consistent scale across application

**Readability Standards**

| Property       | Guideline                              | Rationale                                     |
| :------------- | :------------------------------------- | :-------------------------------------------- |
| Line height    | 1.5× font size for body text           | Comfortable reading experience                |
| Line length    | 50-75 characters per line              | Prevents fatigue from overly long/short lines |
| Touch targets  | Minimum 44×44px                        | Easy mobile tappability                       |
| Letter spacing | Default to normal, adjust for all-caps | Improves legibility                           |

### Color Palette Structure

**Primary Colors (1-2)**

- Main brand colors
- Use for primary actions, key elements, brand identity

**Secondary Colors (1-2)**

- Complement primary colors
- Use for secondary actions, highlighting information

**Neutrals (3-5 shades)**

- Grays and off-whites for text, backgrounds, borders
- Essential for clean, professional UI
- Range from light to dark for flexibility

**Semantic Colors (4)**

| Color                   | Meaning             | Usage                                |
| :---------------------- | :------------------ | :----------------------------------- |
| Success (Green)         | Positive outcome    | Confirmations, completed actions     |
| Warning (Yellow/Orange) | Potential issue     | Alerts, non-critical problems        |
| Error (Red)             | Failure/problem     | Validation errors, critical failures |
| Info (Blue)             | Neutral information | Informational messages, tips         |

**Accessibility**

- All text/background combinations must pass WCAG AA contrast standards
  (4.5:1 for normal text, 3:1 for large text)
- Test with contrast checker tool
- Consider color-blind users (don't rely solely on color to convey
  meaning)

## Component & Interaction Design

### State Design

Design explicit states for all interactive components:

| State          | Visual Treatment           | Purpose                         |
| :------------- | :------------------------- | :------------------------------ |
| Default        | Base appearance            | Resting state                   |
| Hover          | Subtle highlight           | Indicates interactivity         |
| Focused        | Clear focus indicator      | Keyboard navigation support     |
| Active/Pressed | Visual depression          | Confirms user action            |
| Disabled       | Reduced opacity/saturation | Communicates unavailability     |
| Loading        | Spinner or skeleton        | Shows ongoing process           |
| Empty          | Helpful placeholder        | Guides user when no data exists |
| Error          | Red accent, error message  | Displays validation issues      |

### Feedback Patterns

- **Immediate response**: Never leave user wondering if action
  registered
- **Progress indicators**: Show loading states for operations >200ms
- **Toast notifications**: Success confirmations, non-blocking errors
- **Inline validation**: Real-time form feedback as user types
- **Optimistic updates**: Update UI immediately, sync in background

### Component Libraries

- Use established component library for accessibility and robustness
- Look for headless/unstyled libraries allowing custom styling
- Prioritize libraries with strong accessibility support (ARIA
  attributes, keyboard navigation)
- Don't build from scratch what exists and works well

## Responsive Design

### Mobile-First Approach

1. Design for smallest screen (mobile) first
2. Forces prioritization of essential content and features
3. Progressively enhance layout for larger screens
4. Easier to add than to subtract

### Fluid Layouts

- Use relative units: percentages (%), viewport units (vw, vh, vmin,
  vmax)
- Containers adapt smoothly to different screen sizes
- Combine with max-width constraints to prevent overstretching

### Breakpoint Strategy

| Breakpoint | Typical Width | Device Class                    |
| :--------- | :------------ | :------------------------------ |
| xs         | <640px        | Mobile portrait                 |
| sm         | 640px+        | Mobile landscape                |
| md         | 768px+        | Tablet portrait                 |
| lg         | 1024px+       | Tablet landscape, small desktop |
| xl         | 1280px+       | Desktop                         |
| 2xl        | 1536px+       | Large desktop                   |

**Note**: Define breakpoints where layout naturally breaks, not based on
specific devices

### Touch Optimization

- Minimum touch target: 44×44px (Apple) or 48×48px (Android)
- Adequate spacing between interactive elements
- Avoid hover-dependent interactions on touch devices
- Support common touch gestures (swipe, pinch-to-zoom where appropriate)

## Graphics & Visualization

- **2D graphics**: Vector graphics suit scalable UI and data visuals
- **Canvas rendering**: Pixel-level control for dynamic or
  high-frequency scenes
- **3D scenes**: Declarative scene graphs reduce complexity in
  interactive visuals

## Design System Checklist

- [ ] Grid system established (e.g., 12-column)
- [ ] Spacing scale defined and documented
- [ ] Type scale defined with clear hierarchy
- [ ] Color palette structured (primary, secondary, neutrals, semantic)
- [ ] All color combinations pass WCAG AA contrast
- [ ] Component states designed (default, hover, focus, active,
      disabled, loading, error)
- [ ] Responsive breakpoints defined
- [ ] Mobile touch targets minimum 44×44px
- [ ] Component library selected or custom components built with
      accessibility
- [ ] Design tokens documented for developer handoff
