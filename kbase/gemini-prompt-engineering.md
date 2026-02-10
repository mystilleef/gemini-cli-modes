# Gemini prompt engineering guide

## Core principles

- **Clarity & Specificity**: Define precise instructions. Use questions,
  tasks, or entity mappings.
- **Constraints**: Explicitly state what to do and what _not_ to do (for
  example, length, exclusions).
- **Format Control**: Specify output structure (JSON, Markdown, Table,
  List). Use response prefixes to guide generation.

## Input strategies

- **Partial Completion**: Provide a starting pattern for the model to
  complete.
  - _Example_: `Order: Burger. Output: {"burger": 1}`
- **Context Injection**: Supply necessary background info (docs, logs)
  directly in the prompt.
- **Prefixes**: Use labels to demarcate sections (for example, `Input:`,
  `Context:`, `Output:`).

## Few-shot prompting

- **Show, don't just tell**: Provide examples of input -> desired
  output.
- **Consistency**: Maintain identical formatting across examples.
- **Patterns**: Show positive patterns. Avoid anti-patterns (showing
  what _not_ to do).
- **Quantity**: Use enough examples to define the pattern without
  `overfitting`.

## Complexity management

- **Decomposition**: Break complex tasks into single-instruction
  prompts.
- **Chaining**: Use output of one prompt as input for the next.
- **Aggregation**: Process data chunks in parallel and combine results.

## Model parameters

- **Max Output Tokens**: Limits response length.
- **Temperature**: Controls randomness. Use `0.0` for deterministic
  tasks, `1.0` (default) for Gemini 3.
- **TopK/TopP**: Filters token selection probability.

## Gemini 3 specifics

- **Structure**: Use XML tags (`<context>`, `<task>`) or Markdown
  headers for clear separation.
- **Reasoning**: Explicitly request preparation or self-critique before the
  final answer.
- **`Multimodality`**: Treat text, image, and video inputs as equal
  classes.
- **Verbosity**: Explicitly request detailed explanations if needed;
  defaults to concise.

## Agent-based workflows

Configure agents across three dimensions:

1.  **Reasoning**: Logical decomposition, problem diagnosis, information
    exhaustiveness.
2.  **Execution**: Adaptability to new data, persistence in error
    recovery, risk assessment (read vs. write).
3.  **Interaction**: Ambiguity handling (ask vs. assume), verbosity,
    precision.

### Agent system instruction template

```text
Act as a strong reasoner. Prepare before acting.

1. **Logical Dependencies**: Analyze prerequisites and order of operations.
2. **Risk Assessment**: Evaluate consequences. Prefer reading (low risk) over writing (high risk).
3. **Hypothesis Generation**: Identify likely causes; look beyond the obvious.
4. **Adaptability**: Revise roadmaps based on new observations.
5. **Completeness**: Incorporate all tools, policies, and constraints.
6. **Persistence**: Retry transient errors; change strategy for logical errors.

**Action Protocol**:
- Reason through steps 1-6.
- Inhibit response until reasoning completes.
- Execute action.
```
