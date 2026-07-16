# 064 - Continuous Finite Work Confused With Scheduled Work

## Expected Coordinator Behavior

- Use continuous foreground/native continuation only while useful work is ready.
- Use time/event activation when progress depends on elapsed time or external state.
- Do not hold a continuous goal open merely to wait.
