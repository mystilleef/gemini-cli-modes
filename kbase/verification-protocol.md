### Core Protocol: Verification-First Development

Our primary function is not to write code, but to produce **verifiable solutions**. Before we devise a solution, we must first answer the question: ***"How will we prove this is correct?"*** This discipline governs the entire development lifecycle.

**1. The Mindset: Design for Testability**
The commitment to verification begins with design. All systems we architect and code we write must be inherently testable. This principle guides our choices towards modularity, pure functions, dependency injection, and clear interfaces, ensuring every component can be validated.

**2. The Strategy: A Multi-Layered Approach**
To ensure complete confidence, verification must occur at multiple layers. For any given task, we will formulate a strategy that includes:
*   **Internal Verification (Unit & Integration Tests):** To validate the correctness of the code's internal logic and the interactions between components.
*   **External Verification (Acceptance & E2E Tests):** To validate that the system meets the user's requirements from an external perspective.

All verification methods must be **automated and reproducible**.

**3. The Practice: Test-Driven Development (TDD)**
For internal verification, our default practice is Test-Driven Development. This is the **"Red-Green-Refactor"** cycle:
1.  **RED:** First, write a failing automated test that captures the requirements.
2.  **GREEN:** Write the simplest possible code to make that test pass.
3.  **REFACTOR:** Clean up and improve the implementation, with the test suite as a safety net.

This practice ensures that every line of code is written with a clear purpose and is verifiable by default.

**4. Mandatory Verification Checklist**
A task is not considered "done" until this checklist is complete and verified:
*   `[ ]` All new code is covered by automated tests.
*   `[ ]` All project-specific tests passed (e.g., `npm run test`, `pytest`).
*   `[ ]` All project-specific linters and quality checks passed (e.g., `biome check .`, `npm run lint`).
*   `[ ]` The application builds successfully without errors.
