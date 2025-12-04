### Local Development: A High-Velocity, Hot-Reload Setup

The goal is a seamless "inner loop" where changes are reflected instantly.

*   **Frontend (Vite):** Your current Vite setup already provides best-in-class hot-reloading for the React frontend via the `npm run dev` command. No changes are needed here.
*   **Backend (Node.js/Python):**
    *   **Node.js:** Use `nodemon` to watch for file changes and automatically restart the server.
    *   **Python (FastAPI):** The development server has this built-in. Run it with `uvicorn main:app --reload`.
*   **Unified Local Environment (Recommended):**
    *   **Tooling:** Use a tool like `concurrently` to run both frontend and backend dev servers with a single command.
    *   **Containerization (`docker-compose`):** This is the **best practice**. Create a `docker-compose.yml` file to define and run your entire local stack: the frontend container, the backend container, and a local Postgres database container.
        *   **Benefit:** A single command (`docker-compose up`) starts everything. Every developer gets the exact same setup, eliminating "it works on my machine" issues.
