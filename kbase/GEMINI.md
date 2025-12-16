# Gemini project: `kbase`

## Directory overview

This directory, `~/.gemini/kbase`, serves as the knowledge base for
autonomous AI agent operations. The documents within define the core
operational protocols, communication directives, and development
conventions that govern agent behavior. The central purpose of this
knowledge base provides foundational rules and best practices to ensure
agents operate in a clear, deliberate, and verifiable manner.

## Core operational protocols

### Mandatory verification protocol (`MVP`)

Follow the three-phase protocol defined in
`agent-verification-protocol.md`:

1. **Perceive → Reason Gate**: Ground understanding in evidence
   - List specific files read to understand requests
   - Resolve all ambiguities before proceeding

2. **Reason → Act Gate**: Make plans safe, transparent, and verifiable
   - Provide chain-of-thought justification for chosen approach
   - State risk level (Low/Medium/High) with justification
   - Define exact, runnable verification commands before implementation

3. **Act → Refine Gate**: Prove solutions correct
   - Execute every verification command from the plan
   - Provide evidence of success (all tests pass, linters pass)
   - If verification fails, start Reflex Arc protocol

### Explorer mode protocol

In the default Explorer Mode, you strictly follow the investigation
protocols defined in `templates/explore.md`.

### E-prime communication protocol

All text output must adhere to E-Prime (defined in
`e-prime-directive.md`):

- **Avoid all forms of `to be`** (`is`, `am`, `are`, `was`, `were`,
  `be`, `been`, `being`)
- Use active verbs and descriptive language
- Describe functionality and behavior rather than static states
- Example: "The system responds slowly" instead of `The system is slow`
- Example: "This variable holds the user's login status" instead of
  `This variable is a flag`

### Git commit standards

Follow Conventional Commits v1.0.0 specification (see
`conventional-commit-summary.md`):

**Format**: `<type>[optional scope]: <description>`

**Common types**:

- `feat`: New feature (`MINOR` version bump)
- `fix`: Bug fix (`PATCH` version bump)
- `docs`: Documentation changes
- `refactor`: Code restructuring without behavior change
- `test`: Test additions or updates
- `chore`: Maintenance tasks

**Breaking changes**: use `!` before colon (for example, `feat!:`) or
`BREAKING CHANGE:` footer

**Description rules**:

- Use imperative mood ("add" not "added")
- Keep ≤50 characters (72 max)
- No period at end

### Atomic commit strategy

Reference `atomic-commits-best-practices.md` and
`autonomous-staging-patterns.md`:

**Atomic commit definition**: self-contained change that:

1. Represents single logical modification
2. Describes the change concisely in one sentence
3. Includes all necessary files for completeness
4. Leaves project in valid, working state
5. Reverts independently

**Staging patterns**:

- Group implementation + test files together
- Group component + styles + types together
- Group related configuration files (package.json + package-lock.json)
- Separate unrelated changes (feature vs. docs vs. formatting)
- Use file path patterns and change content to determine grouping

**Priority rules**:

1. Smallest complete atomic unit
2. Highest cohesion between files
3. Feature work over cleanup
4. Implementation before documentation

## Technology stack recommendations

### Backend

#### **Node.js (TypeScript)**

- Frameworks: NestJS (structured, large apps) or Express.js (flexible,
  minimal)
- Best for: real-time apps, I/O-heavy `APIs`, full-stack TypeScript
  teams
- Linting: `ESLint` + Prettier (enforced in CI)
- Package manager: `npm` or `pnpm` with committed lock files

#### **Python**

- Framework: FastAPI (modern, high-performance, auto-docs)
- Best for: AI/ML integration, rapid development, data processing
- Linting: Ruff (replaces Black, `isort`, Flake8)
- Package manager: `uv` with pyproject.toml
- Configuration validation: `pydantic`

#### **Go**

- Best for: high-performance microservices, straightforward deployment
- Deploys as single static binary
- Linting: `gofmt`, `golint`
- Configuration management: viper

### Frontend

#### **Web-first applications**

- Next.js: public-facing sites with `SEO` needs
- `Vite` + React: internal tools, admin dashboards
- Angular: large enterprise applications

#### **Mobile-first applications**

- Flutter: cross-platform iOS/Android from single codebase

### Testing strategy

Follow the testing pyramid (see `testing-strategy.md`):

1. **Unit Tests** (most common): Test individual functions/components
   - Tools: Jest (JS/TS), `Pytest` (Python)

2. **Integration Tests**: Test service interactions (API to DB)
   - Run against docker-compose services in CI

3. **E2E Tests** (least common): Simulate full user journeys
   - Tools: Playwright or Cypress

### Local development

**Frontend (`Vite`)**: `npm run dev` provides hot-reloading

**Backend**:

- Node.js: use `nodemon` for auto-restart
- Python (FastAPI): `uvicorn main:app --reload`

**Recommended setup**: use docker-compose.yml to define entire local
stack (frontend + backend + database). Run everything with
`docker-compose up`.

### CI/CD pipeline

GitOps workflow using Cloud Build and Cloud Deploy:

1. **Build** (cloudbuild.yaml):
   - Install dependencies
   - Run all tests
   - Build Docker images
   - Push to Artifact Registry

2. **Deploy** (clouddeploy.yaml):
   - Define promotion path (`dev` → staging → prod)
   - Each target points to different Cloud Run environment

## Key reference documents

### Verification & quality

- **`agent-verification-protocol.md`**: Multi-phase verification
  checklist for agent operations
- **`code-quality-and-dependencies.md`**: Code standards, linting,
  dependency management
- **`software-engineering-best-practices.md`**: Universal engineering
  standards for code quality, architecture, and testing

### Architecture & development

- **`technology-stack-recommendations.md`**: Guides for selecting frontend and backend technology stacks.
- **`database-interaction.md`**: Database access patterns, query
  optimization, migrations
- **`local-development-setup.md`**: Environment setup, tooling,
  development workflows

### Cloud & deployment

- **`cloud-platform-overview.md`**: Cloud infrastructure, services,
  resource management
- **`cloud-database-and-storage.md`**: Cloud database services, storage
  solutions, backup strategies
- **`containerization-and-deployment.md`**: Docker, orchestration,
  deployment patterns
- **`ci-cd-pipeline.md`**: Continuous integration/deployment workflows,
  automation
- **`production-readiness.md`**: Launch checklist, monitoring, scaling,
  security

### Git & version control

- **`conventional-commit.md`**: Full Conventional Commits v1.0.0
  specification
- **`conventional-commit-summary.md`**: Quick reference for commit
  message format
- **`conventional-commit-examples.md`**: Real-world commit message
  examples
- **`atomic-commits-best-practices.md`**: Single logical changes,
  independent `revertibility`
- **`autonomous-staging-patterns.md`**: File grouping heuristics for
  intelligent staging
- **`git-status-codes.md`**: Git status output codes and their meanings
- **`git-status-presentation.md`**: Status formatting, visual
  presentation patterns
- **`ignore-patterns-reference.md`**: .gitignore patterns, file
  exclusion rules

### Communication & standards

- **`e-prime-directive.md`**: E-Prime communication protocol (avoid
  "`to be`" verbs)
- **`gemini-prompt-design.md`**: Gemini 3 prompt engineering best
  practices

### Specialized topics

- **`ai-ml-integration.md`**: Machine learning integration, model
  deployment, inference
- **`data-analysis-and-science.md`**: Data processing, analysis
  pipelines, visualization
- **`graphics-and-visualization.md`**: Graphics rendering, charting,
  visual representation
- **`ui-ux-design.md`**: User interface patterns, accessibility, design
  systems

## Usage

The content of this directory functions as immutable operational
directives for AI agents. Agents should load, understand, and adhere to
these protocols during all operational cycles, from planning and
communication to code generation and verification. These documents shape
agent behavior to ensure consistent, reliable outputs. The knowledge
base targets internal agent operations rather than direct user
interaction.
