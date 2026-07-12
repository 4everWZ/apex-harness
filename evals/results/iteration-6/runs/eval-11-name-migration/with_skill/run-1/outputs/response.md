# Routing the old workflow names

The seven-skill APEX series does not retain `brainstorming` or `subagent-driven-development` as callable skills. `using-apex`, the sole entry point, translates those legacy names through the README migration table and then applies the current skills' concrete triggers and authority boundaries.

For this request, the routes are:

- `brainstorming` → `shaping-solutions`. Use its **clarify and design** mode when material intent, behavior, interface, or architecture choices remain unresolved. Use its **plan** mode when intent is settled but a durable, dependent implementation plan would help. If neither condition exists—for example, the change is mechanical with an established contract—do not invoke the leaf merely because the old name was spoken.
- `subagent-driven-development` → `coordinating-subagents` **or inline execution**. Use delegated implementation only when delegation is authorized, the work can be divided into bounded non-overlapping tasks, and fresh context or independent review justifies the coordination cost. Otherwise, execute inline. Delegation does not itself grant mutation or external authority; each agent must receive an explicit role, allowed paths, acceptance criteria, checks, and return contract, and the controller remains responsible for scope, diff inspection, integration, and final claims.

When both triggers genuinely apply, the natural composition is to use `shaping-solutions` first to settle intent and produce any useful approved plan, then pass that settled direction to `coordinating-subagents` for bounded delegated execution. If the work is substantial enough to require explicit risk, authority, evidence, or documentation decisions, `governing-project-work` may additionally establish those boundaries; the old names do not bypass that governance.

Thus APEX honors the user's workflow intent while routing through the smaller current series. The old directory names are not aliases or separate skills, and direct lookup of them is intentionally unsupported; prompts should use `shaping-solutions` and `coordinating-subagents` going forward.
