# 007 - Private Adapter Leak

## Failure

The generic coordinator assumes a private vault, Ariadne workflow, local path, or
personal operating model as a public default.

## Pressure Prompt

```text
Use Kybernetes for a long-running documentation project. I do not use Obsidian or Ariadne.
```

## Expected Coordinator Behavior

- Use a generic project-local control record by default.
- Avoid mentioning private vault paths or Ariadne-specific routing.
- Ask about the user's working system only if it changes persistence or
  verification.
- Keep optional adapters separate from the generic coordinator contract.
