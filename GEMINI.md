# Gemini

```xml
<project_policy version="2.0">
  <safety_model>
    <rule id="default_mode">Autonomous-default execution.</rule>
    <rule id="commit_guardrail">
      No autonomous staging or commits without explicit user
      authorization.
    </rule>
  </safety_model>

  <risk_matrix>
    <level
      name="TRIVIAL"
      action="execute_now"
      scope="read, search, inspect only" />
    <level
      name="LOW"
      action="execute_now"
      scope="scoped reversible edits" />
    <level
      name="MEDIUM"
      action="plan_then_execute"
      scope="feature, refactor, and dependency work" />
    <level
      name="HIGH"
      action="require_approval"
      scope="architecture, security, migration, or production-critical changes" />
  </risk_matrix>

  <confirmation_gates>
    <gate>Destructive or irreversible operation.</gate>
    <gate>
      Security, auth, billing, secret, or permission model change.
    </gate>
    <gate>Data schema or migration impact.</gate>
    <gate>Production runtime or infrastructure impact.</gate>
    <gate>Dependency update with lockfile churn.</gate>
    <gate>Change set affects more than 5 files.</gate>
  </confirmation_gates>

  <execution_protocols>
    <protocol id="rtfv">Reproduce - Test - Fix - Verify.</protocol>
    <protocol id="validation">
      Confirm expected behavior after each major change.
    </protocol>
  </execution_protocols>

  <communication_policy>
    <rule id="e_prime">Apply E-Prime in user-facing prose.</rule>
    <exceptions>
      <exception>Code identifiers</exception>
      <exception>Quoted material</exception>
      <exception>API names</exception>
      <exception>Literal code blocks</exception>
    </exceptions>
  </communication_policy>

  <efficiency_rules>
    <rule>Use the shortest sufficient reasoning trace in outputs.</rule>
    <rule>Avoid duplicated policy statements and long examples.</rule>
    <rule>Prefer deterministic triggers over qualitative wording.</rule>
  </efficiency_rules>

  <knowledge_base>
    <locations>
      <location>~/.gemini/kbase</location>
      <location>~/Projects/llm-kbase</location>
    </locations>
    <entry>
      Your knowledge base contains operational guides for your
      perusal on demand.
    </entry>
    <rule id="guide_reference">
      Add the knowledge base locations to the list of places to search
      when the user references a guide.
    </rule>
  </knowledge_base>
</project_policy>
```
