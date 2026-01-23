# Universal Engineering Principles

## Purpose

Define core code quality, architecture, testing, and debugging
standards.

## Scope

- In: engineering principles, testing strategy, and code hygiene.
- Out: deployment, infrastructure, and ops practices (see
  `cloud-patterns.md`).

Core software engineering principles applicable to any technology stack.

## Code Quality Principles

### SOLID Principles

- **Single Responsibility**: Each class/module has one reason to change
- **Open/Closed**: Extend functionality without modifying existing code
- **Liskov Substitution**: Derived classes substitute base classes
  without altering correctness
- **Interface Segregation**: Create specific interfaces rather than
  general-purpose ones
- **Dependency Inversion**: Depend on abstractions, not concretions

### Simplicity & Maintainability

- **DRY (Don't Repeat Yourself)**: Abstract common logic to single
  sources of truth
- **KISS (Keep It Simple)**: Prefer simple, understandable solutions
  over complex ones
- **Clean Code**: Write code for humans first, machines second
- **Readability**: Prioritize clarity and self-documenting code

## Architecture & Design

### Structural Principles

- **Modularity**: Decouple components for independent evolution and
  testing
- **Separation of Concerns**: Distinctly separate UI, business logic,
  and data access
- **Scalability**: Design systems to handle growth in data volume and
  traffic
- **Extensibility**: Allow future enhancements without major refactoring

### System Design Essentials

- **Data management**: Choose data stores based on consistency, scale,
  and access patterns
- **API design**: Consistent boundaries, validation at entry points,
  idempotent operations
- **Security**: Managed identity, least privilege, secrets outside
  source control
- **Observability**: Structured logs, traces, and metrics for diagnosis
  and reliability

### Design Patterns

Apply standard patterns where appropriate:

- **Factory**: Object creation abstraction
- **Observer**: Event-driven communication
- **Strategy**: Algorithm selection at runtime
- **Repository**: Data access abstraction
- **Singleton**: Single instance coordination

**Warning**: Avoid over-engineering. Apply patterns only when they solve
actual problems.

## Testing Strategy

### Testing Pyramid

Structure tests in three layers (base to tip):

1. **Unit Tests (Base - Majority)**
   - Test individual functions/methods in isolation
   - Fast execution, high count, narrow scope
   - Mock external dependencies

2. **Integration Tests (Middle)**
   - Test component interactions
   - Moderate execution speed, medium count
   - Verify contracts between modules

3. **End-to-End Tests (Tip - Minority)**
   - Test complete user workflows
   - Slow execution, low count, broad scope
   - Validate system behavior from user perspective

### Testing Principles

- **Test-Driven Development (TDD)**: Write failing tests before
  implementing functionality
- **High Coverage on Critical Paths**: Focus testing effort on core
  business logic
- **Test Quality**: Apply same quality standards to test code as
  production code
- **Fast Feedback**: Optimize test suites for quick execution

## Debugging & Troubleshooting

### Systematic Approach

1. **Reproduce Consistently**: Create reliable reproduction steps
2. **Isolate Variables**: Change one thing at a time
3. **Hypothesis Testing**: Formulate hypothesis → test → refine
   understanding
4. **Root Cause Analysis**: Fix underlying issue, not symptoms

### Observability

Observability standards live in `cloud-patterns.md`.

## Quality Standards

### Code Hygiene

- Remove commented-out code before committing
- Eliminate debug statements and temporary logic
- Maintain consistent formatting and style
- Refactor continuously to prevent technical debt

### Documentation

- Document the "why" (rationale), not the "what" (implementation)
- Keep documentation close to code
- Update documentation when changing behavior
