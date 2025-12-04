### CI/CD: Automated Builds & Deployments

Automate your path from code to production using a GitOps workflow.

1.  **Source:** Connect your GitHub repository to **Cloud Build**.
2.  **Build (`cloudbuild.yaml`):** In your repository, create a `cloudbuild.yaml` file. When code is pushed to the `main` branch, it will trigger Cloud Build to:
    *   Install dependencies (`npm install`, `pip install`).
    *   Run all tests.
    *   Build the frontend and backend Docker images.
    *   Push the versioned images to **Artifact Registry**.
3.  **Deploy (`clouddeploy.yaml`):** Cloud Build will then trigger a **Cloud Deploy** pipeline.
    *   **Delivery Pipeline:** Define your promotion path (e.g., `dev` -> `staging` -> `prod`).
    *   **Targets:** Each target is a different Cloud Run environment.
    *   **Benefit:** This gives you safe, auditable, one-click promotions, and instant rollbacks.
