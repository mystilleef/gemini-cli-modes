### AI/ML development: from local prototyping to cloud production

This guide provides a comprehensive decision framework for developing
AI/ML applications, covering local experimentation, cloud deployment,
and the full spectrum of tasks from inference to fine-tuning.

#### **1. Local development & experimentation**

**Goal:** quickly run and interact with models on a local machine.

- **Primary Recommendation: `Ollama`**
  - **Use case:** serves models instantly for initial prototyping. Its
    command-line interface (`ollama run gemma`) provides the fastest way
    to get a model running and accessible via a local API.
- **Secondary Recommendation: Hugging Face `transformers` + FastAPI**
  - **Use case:** builds the actual application logic. This setup
    mirrors the production environment, allowing for direct programmatic
    control over the model within your application code.

#### **2. Production inference on the cloud**

**Goal:** deploy a model for scalable, reliable inference in a
production environment like Cloud Run.

- **Primary Recommendation: Hugging Face `transformers` + FastAPI in a
  Docker Container**
  - **Why:** this represents the industry-standard stack, offering an
    optimal balance of flexibility, portability, and ease of use. It
    serves as the default choice for deploying models on Cloud Run.
- **Performance Optimization: `vLLM` / `TensorRT-LLM`**
  - **Use case:** high-throughput applications where inference cost and
    latency remain critical. These specialized servers can dramatically
    improve performance but add complexity. Recommended when the
    standard stack hits its performance limits.

#### **3. Fine-tuning and training**

**Goal:** adapt a pre-trained model to a specific task or build a new
model.

- **Primary Recommendation (Fine-Tuning): Hugging Face `transformers`
  (`Trainer` API) + `PEFT`**
  - **Why:** offers the most direct and resource-efficient method for
    fine-tuning models from the Hugging Face Hub. The `PEFT` library's
    support for LoRA/QLoRA enables management of hardware requirements.
- **Primary Recommendation (Custom Models & Flexibility): `Keras` 3**
  - **Why:** provides a powerful, user-friendly, multi-backend (`JAX`,
    PyTorch, TensorFlow) high-level API. It functions as the primary
    choice for building custom architectures or when you need more
    flexibility than the `Trainer` API offers.
- **Expert-Level Recommendation (Peak Performance): `JAX` / Flax**
  - **Why:** supports advanced research and large-scale training where
    peak performance holds priority. This stack offers the most control
    and optimization potential, especially on `TPUs`.

#### 4. `Agentic` frameworks

**Goal:** build applications that reason and orchestrate tool use.

- **Default Choice: Google `ADK` (Agents & Development Kit)**
  - **Why:** encourages usage of Google's own open-source framework,
    helps find issues, and contributes back to its development.
    Developers prefer this choice for deep integration with the Google
    ecosystem.
- **Alternative: LangChain & LangGraph (Python)**
  - **Why:** represents the most mature and widely adopted ecosystem. It
    offers a strong alternative when the project requires broader
    community support or specific features.

#### **5. API integration & security**

**Goal:** securely connect to managed AI services like Vertex AI.

- **Authentication:** **Avoid using API keys in production.** Always use
  **Workload Identity**.
  1.  Create a dedicated **`IAM` Service Account** for your backend
      service.
  2.  Grant it the `Vertex AI User` role.
  3.  Configure your Cloud Run service to use this service account.
  - **Benefit:** Automatic, secure authentication with no keys to manage
    or leak.

#### **6. Caching strategy for Large Language Models (`LLMs`)**

**Goal:** improve performance and reduce costs.

- **Technology:** **Redis** (or **`Memorystore` for Redis** on `GCP`).
- **Pattern: Semantic Caching**
  - **Problem:** `Large Language Model (LLM)` calls incur high latency
    and cost.
  - **Solution:** Before calling the `Large Language Model (LLM)`,
    generate embeddings for the user's query and perform a vector
    similarity search against a cache of past queries. If a semantically
    similar query exists, return the cached response.
