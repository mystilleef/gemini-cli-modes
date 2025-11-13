### AI/ML Development: From Local Prototyping to Cloud Production

This guide provides a comprehensive decision framework for developing AI/ML applications, covering local experimentation, cloud deployment, and the full spectrum of tasks from inference to fine-tuning.

#### **1. Local Development & Experimentation**

**Goal:** Quickly run and interact with models on a local machine.

*   **Primary Recommendation: Ollama**
    *   **Use Case:** For instant model serving and initial prototyping. Its command-line interface (`ollama run gemma`) provides the fastest way to get a model running and accessible via a local API.
*   **Secondary Recommendation: Hugging Face `transformers` + FastAPI**
    *   **Use Case:** When building the actual application logic. This setup more closely mirrors the production environment, allowing for direct programmatic control over the model within your application code.

#### **2. Production Inference on the Cloud**

**Goal:** Deploy a model for scalable, reliable inference in a production environment like Cloud Run.

*   **Primary Recommendation: Hugging Face `transformers` + FastAPI in a Docker Container**
    *   **Why:** This is the industry-standard stack, offering the best balance of flexibility, portability, and ease of use. It is the default choice for deploying models on Cloud Run.
*   **Performance Optimization: vLLM / TensorRT-LLM**
    *   **Use Case:** For high-throughput applications where inference cost and latency are critical. These specialized servers can dramatically improve performance but add complexity. They are the recommended next step when the standard stack hits its performance limits.

#### **3. Fine-Tuning and Training**

**Goal:** Adapt a pre-trained model to a specific task or build a new model.

*   **Primary Recommendation (Fine-Tuning): Hugging Face `transformers` (`Trainer` API) + `PEFT`**
    *   **Why:** The most direct and resource-efficient method for fine-tuning models from the Hugging Face Hub. The `PEFT` library's support for LoRA/QLoRA is essential for managing hardware requirements.
*   **Primary Recommendation (Custom Models & Flexibility): Keras 3**
    *   **Why:** A powerful, user-friendly, multi-backend (JAX, PyTorch, TensorFlow) high-level API. It's the best choice for building custom architectures or when you need more flexibility than the `Trainer` API offers.
*   **Expert-Level Recommendation (Peak Performance): JAX / Flax**
    *   **Why:** For cutting-edge research and large-scale training where maximum performance is the absolute priority. This stack offers the most control and optimization potential, especially on TPUs.

#### **4. Agentic Frameworks**

**Goal:** Build applications that reason and orchestrate tool use.

*   **Default Choice: Google ADK (Agents & Development Kit)**
    *   **Why:** The default choice to encourage usage of Google's own open-source framework, help find issues, and contribute back to its development. It is the preferred choice for deep integration with the Google ecosystem.
*   **Alternative: LangChain & LangGraph (Python)**
    *   **Why:** As the most mature and widely adopted ecosystem, it is a strong alternative when its broader community support or specific features are required.

#### **5. API Integration & Security**

**Goal:** Securely connect to managed AI services like Vertex AI.

*   **Authentication:** **Do not use API keys in production.** Always use **Workload Identity**.
    1.  Create a dedicated **IAM Service Account** for your backend service.
    2.  Grant it the `Vertex AI User` role.
    3.  Configure your Cloud Run service to use this service account.
    *   **Benefit:** Automatic, secure authentication with no keys to manage or leak.

#### **6. Caching Strategy for LLMs**

**Goal:** Improve performance and reduce costs.

*   **Technology:** **Redis** (or **Memorystore for Redis** on GCP).
*   **Pattern: Semantic Caching**
    *   **Problem:** LLM calls are slow and expensive.
    *   **Solution:** Before calling the LLM, generate embeddings for the user's query and perform a vector similarity search against a cache of previously answered queries. If a semantically similar query exists, return the cached response.
