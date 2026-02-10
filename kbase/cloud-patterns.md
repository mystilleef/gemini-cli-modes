# Cloud & Deployment Patterns

## Purpose

Define technology-agnostic patterns for deployment and production
readiness.

## Scope

- In: containerization, CI/CD, data storage, IaC, observability,
  security.
- Out: application-level code style or UI/UX design.

## Containerization Patterns

### Multi-Stage Container Builds

- **Build stage**: Install dependencies, compile code, run tests
- **Production stage**: Copy only runtime artifacts into minimal base
  image
- **Benefits**: Smaller image size, reduced attack surface, faster
  deployments

### Configuration Externalization

- **Never hardcode**: Database URLs, API keys, service endpoints
- **Environment-based injection**: Supply configuration at runtime via
  environment variables
- **Secrets management**: Store sensitive values in managed secrets
  service, mount as environment variables
- **Local vs Cloud**: Same application code, different configuration
  sources

## Deployment Architecture

### Service Separation

- **Frontend service**: Serve static assets via lightweight web server
- **Backend service**: Handle API requests, business logic, data access
- **Benefits**: Independent scaling, deployment isolation, clear
  boundaries

### Serverless Containerized Deployment

- **Auto-scaling**: Scale to zero during inactivity, scale up under load
- **Stateless design**: Store session state externally (database, cache)
- **Network isolation**: Backend services accessible only through
  authenticated channels

### Zero-Downtime Deployment

- **Rolling updates**: Gradually replace old instances with new ones
- **Health checks**: Verify new instances before routing traffic
- **Instant rollback**: Revert to previous version on deployment failure

## CI/CD Pipeline Patterns

### GitOps Workflow

Automated path from code commit to production deployment:

1. **Source Control Integration**: Repository triggers build on code
   push
2. **Build Phase**:
   - Install dependencies
   - Run test suite
   - Build container images
   - Tag artifacts with version identifiers
3. **Artifact Storage**: Push versioned images to container registry
4. **Deployment Automation**: Trigger deployment pipeline on successful
   build

### Environment Promotion

- **Sequential environments**: Development → Staging → Production
- **Promotion gates**: Automated tests, manual approval, smoke tests
- **Auditable process**: Track which version runs in each environment
- **Rollback capability**: One-click revert to previous stable version

### Automated Quality Gates

- **Dependency scanning**: Check for vulnerabilities in third-party
  packages
- **Container scanning**: Analyze images for OS-level security issues
- **Test execution**: Unit, integration, and E2E tests in pipeline
- **Build failure on issues**: Block deployment if quality gates fail

## Data Storage Patterns

### Database Type Selection

| Type                     | Data Model                     | Use Case                                  | When to Choose                                                                  |
| :----------------------- | :----------------------------- | :---------------------------------------- | :------------------------------------------------------------------------------ |
| **Relational**           | SQL (tables, rows)             | Structured data, ACID compliance required | Financial data, user credentials, e-commerce orders, complex queries with joins |
| **Document Store**       | NoSQL (JSON documents)         | Semi-structured data, flexible schema     | User profiles, real-time chat, activity feeds, rapid prototyping                |
| **Wide-Column**          | NoSQL (column families)        | Massive datasets, high throughput         | IoT sensor data, time-series metrics, terabyte+ scale with high write rates     |
| **Analytical Warehouse** | Columnar (optimized for reads) | Business intelligence, analytics          | Complex analytical queries, log analysis, ML model training data                |
| **Object Storage**       | Unstructured files             | Blobs, media, backups                     | User-uploaded images/videos, static assets, data lakes                          |

### Default Choice Guidance

- **Start with relational**: Provides strongest consistency guarantees,
  familiar query language
- **Choose document store when**: Schema flexibility outweighs
  relational guarantees
- **Choose wide-column when**: Data volume exceeds relational database
  scale limits
- **Use analytical warehouse for**: Read-heavy analytical workloads (not
  transactional operations)
- **Use object storage for**: Files that reference metadata stored in
  transactional database

### Database Connectivity

- **Private network**: Connect application to database via internal
  network
- **Connection pooling**: Reuse database connections for efficiency
- **Credentials management**: Load connection strings from managed
  secrets service

## Infrastructure as Code (IaC)

### Core Principles

- **Declarative configuration**: Define desired state in
  version-controlled files
- **Reproducible infrastructure**: Create identical environments from
  same configuration
- **Automated provisioning**: Execute scripts to create/update all
  resources
- **Prevent manual changes**: Avoid console/UI modifications that drift
  from code

### IaC Workflow

1. Define resources in configuration files (databases, networks, compute
   instances)
2. Execute provisioning tool to create or update infrastructure
3. Version control all configuration files alongside application code
4. Document infrastructure dependencies and networking requirements

## Production Readiness

### Security Patterns

**Authentication & Authorization**

- **Never build custom auth**: Use managed identity provider service
- **Principle of least privilege**: Grant minimum permissions required
- **Automated vulnerability scanning**: Integrate into CI/CD pipeline
  - Scan dependencies for known vulnerabilities
  - Scan container images for OS-level security issues

**Secrets Management**

- Store all secrets in managed secrets service
- Never commit secrets to version control
- Rotate secrets regularly on defined schedule
- Audit secret access logs

### Observability Patterns

**Structured Logging**

- Emit logs in structured format (JSON) for parsing
- Include context: request ID, user ID, service name, timestamp
- Define log levels: DEBUG, INFO, WARN, ERROR, FATAL
- Centralize logs from all services for unified search

**Distributed Tracing**

- Trace requests across service boundaries
- Identify performance bottlenecks in multi-service flows
- Correlate logs and metrics with traces
- Essential for debugging distributed systems

**Metrics & Alerting**

- Define Key Performance Indicators (KPIs): latency, throughput, error
  rate
- Set Service Level Objectives (SLOs): target values for KPIs
- Create alerts for SLO violations
- Monitor resource utilization: CPU, memory, disk, network

**Dashboard Design**

- Real-time system health visualization
- Historical trend analysis for capacity preparation
- Alert status and on-call escalation visibility

### Deployment Checklist

- [ ] All secrets stored in managed service, none in code
- [ ] Structured logging implemented across all services
- [ ] Distributed tracing configured end-to-end
- [ ] Metrics collection and alerting configured
- [ ] Automated vulnerability scanning in CI/CD
- [ ] Health check endpoints implemented
- [ ] Database connections use private network
- [ ] Infrastructure defined as code
- [ ] Rollback procedure tested and documented
- [ ] Load testing completed for expected traffic
