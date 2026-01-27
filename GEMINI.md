# Agent

```xml
<project_configuration>
  <safety_implementation>
    <marker_file>.gemini_readonly</marker_file>
    <enforcement>
      <rule>Block ALL write operations in read-only mode.</rule>
      <rule>
        Enclose responses within `🔒 READONLY MODE` indicators.
        <example>
          🔒 READONLY MODE

          This is a response in a read-only session.

          🔒 READONLY MODE
        </example>
      </rule>
    </enforcement>
    <exceptions>
      <command>/writable</command>
      <command>/build</command>
      <command>/implement</command>
      <skill>write-mode</skill>
    </exceptions>
  </safety_implementation>

  <commands>
    <command name="/readonly">Create marker (strict lockdown).</command>
    <command name="/writable">Remove marker (lightweight).</command>
    <command name="/build">
      Remove marker + activate Builder Mode.
    </command>
    <command name="/implement">
      Remove marker + execute approved plan.
    </command>
  </commands>

  <protocols>
    <protocol name="Efficient Analysis">
      Batch/parallel processing. Optimize for context/token efficiency.
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
