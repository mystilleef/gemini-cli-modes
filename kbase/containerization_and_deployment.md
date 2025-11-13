### Deployment: Serverless & Scalable with Cloud Run

Cloud Run is the ideal target for containerized applications, offering auto-scaling (even to zero) and a simple developer experience.

*   **Strategy:** Deploy the frontend and backend as two separate, independent Cloud Run services.
    *   **Frontend Service:** A `Dockerfile` will build the React app and use a lightweight web server like **Nginx** to serve the static files.
    *   **Backend Service:** A `Dockerfile` will package your Node.js or Python application.
*   **Communication:** The frontend service will be configured with the public URL of the backend service to make API calls.
*   **Security:**
    *   The frontend service should be public.
    *   The backend service should be configured to only accept requests from the frontend service and authenticated users.

### The "Local to Cloud" Upgrade Path: A Step-by-Step Workflow

This is the practical guide to moving from your `docker-compose` setup to a production deployment.

**Baseline:** You have a `docker-compose.yml` that spins up your frontend, backend, and a local Postgres database.

**Step 1: Author Production `Dockerfile`s**
Your `docker-compose` file uses `Dockerfile`s, but they need to be production-ready. This means multi-stage builds to create small, secure final images. For the frontend, this involves building the static assets and then copying them into a minimal Nginx image.

**Step 2: Externalize Configuration & Secrets**
This is the most critical transition.
*   **Local:** You use a `.env` file and `docker-compose` to inject environment variables like `DATABASE_URL=postgres://user:pass@localhost:5432/mydb`.
*   **Cloud:**
    1.  Store all secrets (database passwords, API keys) in **Google Secret Manager**.
    2.  In your Cloud Run service definition, you will mount these secrets as environment variables.
    3.  Your application code **does not change**. It still reads from `process.env.DATABASE_URL`. The *value* is just supplied by Cloud Run (from Secret Manager) instead of `docker-compose`.

**Step 3: Provision Cloud Infrastructure with IaC**
Do not click in the GCP console to create your database or Cloud Run services. Use **Infrastructure as Code (IaC)**.
*   **Tool:** **Terraform**.
*   **Workflow:**
    1.  Write Terraform files (`.tf`) that define all your GCP resources: the Cloud SQL Postgres instance, the VPC network, the Serverless VPC Access Connector, the IAM service accounts, the Cloud Run services, etc.
    2.  Running `terraform apply` will create or update all your cloud infrastructure in a repeatable, version-controlled way.

**Step 4: Connect to the Database**
*   **Local:** Your backend connects to `localhost:5432`.
*   **Cloud:** Your backend Cloud Run service connects to the **private IP address** of your Cloud SQL instance via the **Serverless VPC Access Connector**. This is crucial for security and low latency. The private IP is a value you get from your Terraform output and securely provide to your Cloud Run service as an environment variable.
