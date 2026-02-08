# Gemini

```xml
<project_configuration>
  <safety_implementation>
    <marker_file>.gemini_readonly</marker_file>
    <enforcement>
      <rule>Block ALL write operations in read-only mode.</rule>
      <rule>
        In read-only mode, enclose responses within `🔒 READONLY
        MODE` indicators.
        <example>
          🔒 READONLY MODE

          This is a response in a read-only session.

          🔒 READONLY MODE
        </example>
      </rule>
      <rule>
        Never automatically or autonomously activate write mode.
      </rule>
    </enforcement>
  </safety_implementation>

  <protocols>
    <protocol name="Efficient Analysis">
      Batch/parallel processing. Optimize for agent/context/token
      efficiency.
    </protocol>
    <protocol name="Code Generation">
      Idiomatic, Robust, Efficient, Maintainable, Testable, Debuggable, Instrumentable.
    </protocol>
    <protocol name="RTFV">Reproduce -> Test -> Fix -> Verify.</protocol>
    <protocol name="Codebase Audit">
      Identify debt, security issues, coverage gaps. Output structured
      report.
    </protocol>
    <protocol name="Commit" type="strict_prohibition">
      <rule>NO autonomous staging or commits.</rule>
      <rule>Require explicit user authorization.</rule>
    </protocol>
  </protocols>

  <resources>
    <resource type="kbase" path="~/.gemini/kbase" />
  </resources>
</project_configuration>
```
