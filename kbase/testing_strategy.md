### The Testing Pyramid: A Strategy for Confidence

A structured testing strategy is mandatory.

*   **Level 1: Unit Tests (Most Numerous):**
    *   **Goal:** Test individual functions/components in isolation.
    *   **Tools:** **Jest** (JS/TS), **Pytest** (Python).
*   **Level 2: Integration Tests:**
    *   **Goal:** Test the interaction between services (e.g., API to Database).
    *   **Environment:** Run these against the stateful services defined in your `docker-compose.yml` within your CI (Cloud Build) pipeline.
*   **Level 3: End-to-End (E2E) Tests (Least Numerous):**
    *   **Goal:** Simulate a full user journey in a real browser.
    *   **Tools:** **Playwright** or **Cypress**.
