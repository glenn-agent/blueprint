# AI Infra Project Brief

Date: 2026-10-08

## User direction

The user asked Glenn-Agent to keep contributing and to start another AI-infrastructure-related project, but only after careful direction finding. The project should avoid reinventing existing wheels and should do something genuinely valuable.

## Landscape scan

Crowded layers that should not be cloned blindly:

- **LLM gateways / routers / proxies**: LiteLLM, Portkey Gateway, Helicone AI Gateway, Envoy AI Gateway, Bifrost, Kong/APISIX AI gateway patterns, and many smaller OpenAI-compatible provider proxies already cover routing, fallback, budgets, cache, auth, and provider normalization.
- **Observability / eval platforms**: Langfuse, Arize Phoenix, Opik, Helicone, Laminar, OpenLIT, Promptfoo, DeepEval, RAGAS, AgentOps, and many SaaS platforms already cover traces, evals, dashboards, datasets, prompt management, and cost/latency monitoring.
- **Agent frameworks / runtimes**: LangGraph, OpenAI Agents SDK, OpenHands, SWE-agent, Goose, Semantic Kernel, AutoGen, CrewAI, Letta, and other frameworks already cover orchestration patterns.
- **OpenAI-compatible endpoint conformance**: `thousand-ships/oaiconform` already targets the valuable niche of executable conformance probes for OpenAI-compatible endpoints, including streaming tool calls, structured output, usage, and CI-friendly reports.

Conclusion: do **not** start another generic gateway, observability dashboard, agent framework, prompt manager, or OpenAI-compatible API conformance clone.

## Candidate gaps

### 1. Portable agent run bundle / state package

Problem: Long-running agents spread state across chat history, tool traces, workspace files, memory, artifacts, approvals, environment assumptions, and human decisions. Observability tools capture spans, but teams still lack a small portable bundle that can be inspected, handed off, archived, redacted, and replayed across runtimes.

Possible project: `agent-statepack` / `agentpack` / `runpack`.

Core idea: an open schema + CLI for packaging an agent run into a safe, reviewable, portable bundle:

- `agentpack.json` manifest
- task/request summary
- timeline of agent steps and tool calls
- repo/workspace diff summary
- artifact index
- verification evidence
- environment metadata without secrets
- approval / policy decisions
- redaction report
- optional links to OpenTelemetry trace IDs or external observability backends

Why it is not a duplicate:

- It complements gateways and observability platforms instead of replacing them.
- It can export/import with Langfuse/Phoenix/OpenTelemetry later, but the core value is portable handoff and audit packaging.
- It fits Glenn-Agent's daily work: open-source PRs, writeback, proof, and long-running agent memory.
- It can later support physical-AI workflow evidence by packaging simulation/run metadata, safety envelopes, approval gates, and rollback notes.

MVP:

- CLI that runs in a Git workspace.
- Generates `agentpack.json` and a Markdown handoff from a small config.
- Captures Git status, recent commits, changed files, verification commands, artifacts, and redaction warnings.
- Includes a JSON Schema for the manifest.
- Has no network dependency and no hosted service.

Risks:

- Overlap with AgentProof if scoped too narrowly around PR evidence.
- Must not collect secrets or private conversations by default.
- Needs a crisp schema or it becomes another vague logging tool.

### 2. Agent infra decision matrix / compatibility catalog

Problem: The ecosystem is fragmented; teams struggle to choose between gateways, observability, sandboxes, runtimes, eval tools, and policy layers.

Possible project: machine-readable catalog + CLI that helps teams choose stack components based on deployment constraints.

Why lower priority:

- Useful, but it can become yet another awesome list.
- Harder to maintain objectively.
- Less unique unless paired with executable checks.

### 3. Runtime policy contract tester

Problem: Agent runtimes expose tool permissions, approval gates, file access, and publish permissions differently. Teams need a way to test whether a runtime enforces policy boundaries.

Possible project: deterministic policy test harness for agent sandboxes/runtimes.

Why promising but heavier:

- Valuable and safety-relevant.
- Requires adapters for runtimes and careful destructive-test isolation.
- Better after Glenn-Agent has more direct runtime contribution experience in OpenClaw/NemoClaw.

## Recommendation

Start with **portable agent run bundles** as the second AI infra project direction, but do not create the repository yet.

Working name: `agentpack`.

One-line thesis:

> AgentPack is an open, redaction-first run bundle format and CLI for packaging agent work so it can be reviewed, handed off, archived, and replayed across agent runtimes.

Why this is the best fit now:

- It avoids the crowded gateway/observability/framework layers.
- It is infrastructure, not an app demo.
- It has immediate dogfood value for Glenn-Agent's own workflow.
- It complements AgentProof rather than replacing it: AgentProof proves PR work; AgentPack packages broader run/session state.
- It can become a bridge between coding agents, evals, OpenTelemetry-backed systems, and future physical-AI evidence workflows.

## Next step before repo creation

Before creating a repository, produce:

1. A one-page problem statement.
2. A minimal `agentpack.json` schema draft.
3. Three real user stories:
   - coding-agent PR handoff,
   - failed agent run debugging,
   - physical-AI simulation/evaluation evidence bundle.
4. A non-goals list to prevent scope creep.
5. A comparison table explaining why this is not a gateway, not an observability dashboard, not an eval platform, and not just AgentProof again.
