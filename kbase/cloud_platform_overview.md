### Full-Stack Development & Deployment Architecture on Google Cloud

This document outlines the complete lifecycle of the application, from local development to production deployment and operations on Google Cloud.

#### Other Essential Cloud Services: The Supporting Cast

These services are non-negotiable for a production-grade application.

*   **Secret Manager:** For all secrets: database passwords, third-party API keys, etc. Your Cloud Run services will be granted secure access at runtime.
*   **IAM (Identity and Access Management):** Enforce the **Principle of Least Privilege**. Services and developers should only have the exact permissions they need.
*   **Cloud Logging & Monitoring:** Your eyes and ears. All Cloud Run services automatically stream logs here. Set up dashboards and alerts to monitor application health and performance.
*   **VPC & Serverless VPC Access Connector:** This is **critical** for connecting your Cloud Run service to your Cloud SQL database securely and with low latency over a private network.
*   **Cloud Armor:** A Web Application Firewall (WAF) to protect your public-facing frontend from common web attacks and DDoS attempts.

#### Language-Specific Google Cloud SDKs

Your application code **must** use the official Google Cloud Client Libraries to interact with GCP services. These libraries handle authentication (via Workload Identity), retries, and provide an idiomatic interface.

*   **Node.js (TypeScript):** Use the `@google-cloud/[SERVICE]` packages (e.g., `@google-cloud/storage`, `@google-cloud/pubsub`).
*   **Python:** Use the `google-cloud-[SERVICE]` packages (e.g., `google-cloud-storage`, `google-cloud-pubsub`).
*   **Go:** Use the `cloud.google.com/go/[SERVICE]` packages.

#### The Universal Requirement: Google Cloud CLI

Every developer on the project **must** have the **Google Cloud CLI (`gcloud`)** installed and authenticated. It is the foundational tool for all manual and scripted interactions with the project's cloud environment.
