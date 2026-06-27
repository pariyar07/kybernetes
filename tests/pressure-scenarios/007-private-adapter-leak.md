# 007 - Private Adapter Leak

## Failure

The generic loop governor assumes a private workspace, single tool workflow, local
path, or personal operating model as a public default.

## Pressure Prompt

```text
Use Kybernetes for a long-running documentation project. I do not use your private workspace or preferred knowledge tool.
```

## Expected Coordinator Behavior

- Use a generic project-local control record by default.
- Avoid mentioning private paths or tool-specific routing.
- Ask about the user's working system only if it changes persistence or
  verification.
- Keep optional adapters separate from the generic loop governor contract.
