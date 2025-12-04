### Code Quality & Dependency Management

These are mandatory for all projects.

*   **Code Style & Linting (Enforced in CI):**
    *   **JavaScript/TypeScript:** **ESLint** (for linting) and **Prettier** (for formatting). Use a pre-commit hook to run these automatically.
    *   **Python:** **Ruff** (for ultra-fast linting and formatting). It replaces older tools like Black, isort, and Flake8.
    *   **Go:** Standard `gofmt` and `golint`.
*   **Dependency Management:**
    *   **Node.js:** Use `npm` or `pnpm`. All projects **must** have a `package-lock.json` or `pnpm-lock.yaml` file committed to the repository to ensure reproducible builds.
    *   **Python:** Use **`uv`** with a `pyproject.toml` file. This is the modern, high-speed replacement for `pip` and `venv`. The `pyproject.toml` defines all dependencies, and `uv` creates a virtual environment based on it.
*   **Language-Specific Ecosystem Enhancements:**
    *   **Node.js (TypeScript) / Frontend:**
        *   **Configuration Management:** Use **`zod`** for validating environment variables at runtime. This prevents misconfigurations and ensures your application starts in a known-good state.
    *   **Python:**
        *   **Configuration Management:** Use **`pydantic`** for settings management. It provides the same benefits as `zod` for the Python ecosystem.
        *   **CLI Tooling:** For any Python-based CLIs, use **`Typer`** or **`Click`**. They provide a simple, declarative way to build robust command-line interfaces.
    *   **Go:**
        *   **Configuration Management:** Use **`viper`** for handling configuration from files, environment variables, and flags.
        *   **CLI Tooling:** Use **`cobra`** to build powerful, modern CLI applications. It is the foundation of many popular tools like `kubectl` and `hugo`.
