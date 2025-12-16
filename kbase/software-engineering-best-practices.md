# Universal Software Engineering Best Practices

## Overview

This document defines the engineering standards for code generation, architecture, and problem-solving across all projects. It establishes the universal baseline for quality, maintainability, and reliability that governs your output in any codebase.

## Core Principles

### 1. Code Quality

- **Clean Code**: Write code for humans first, machines second. Ensure readability and clarity.
- **SOLID Principles**:
    - **Single Responsibility**: Ensure each class/module has one reason to change.
    - **Open/Closed**: Extend functionality without modifying existing code.
    - **Liskov Substitution**: Ensure derived classes substitute base classes without altering correctness.
    - **Interface Segregation**: Create specific interfaces rather than general-purpose ones.
    - **Dependency Inversion**: Depend on abstractions, not concretions.
- **DRY (Don't Repeat Yourself)**: Abstract common logic to single sources of truth.
- **KISS (Keep It Simple, Stupid)**: Prefer simple, understandable solutions over complex ones.

### 2. Architecture & Design

- **Modularity**: Decouple components to ensure independent evolution and testing.
- **Scalability**: Design systems to handle growth in data volume and traffic.
- **Design Patterns**: Apply standard patterns (Factory, Observer, Strategy) where appropriate. Avoid over-engineering.
- **Separation of Concerns**: Distinctly separate logic for UI, business rules, and data access.

### 3. Debugging & Troubleshooting

- **Systematic Approach**: Isolate variables, reproduce issues consistently, and verify fixes.
- **Root Cause Analysis**: Identify and fix the underlying issue, not just the symptom.
- **Observability**: Implement robust logging and metrics to facilitate future debugging.
- **Hypothesis Testing**: Formulate a hypothesis, test it, and refine understanding based on evidence.

### 4. Testing Strategy

- **TDD (Test-Driven Development)**: Write failing tests before implementing functionality.
- **Testing Pyramid**: Prioritize Unit tests (base), followed by Integration tests, and finally E2E tests (tip).
- **Coverage**: Aim for high coverage on critical paths. Treat test code with the same quality standards as production code.

## Directives for Agents

- **ALWAYS** apply these standards regardless of the specific project context.
- **ALWAYS** refactor code that violates these principles during the `Refine` phase.
- **NEVER** leave commented-out code, debug prints, or temporary logic in production artifacts.
- **ALWAYS** justify architectural decisions in the `PRAR` plan.
- **ALWAYS** verify that changes maintain or improve the existing code quality metrics.
