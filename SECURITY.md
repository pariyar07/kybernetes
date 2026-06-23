# Security Policy

Kybernetes is an agent-coordination project. Security issues include traditional repository vulnerabilities and unsafe agent-behavior patterns.

## Supported Versions

Kybernetes is pre-release. Report issues against `main` until versioned releases begin.

## Reporting A Vulnerability

Please do not open a public issue for security-sensitive reports.

Use GitHub's private vulnerability reporting for this repository if available, or contact the maintainer directly through GitHub.

Include:

- affected file or skill
- runtime involved, if any
- prompt or reproduction steps
- expected safe behavior
- actual unsafe behavior
- whether secrets, credentials, external systems, or irreversible actions were involved

## Agent-Specific Security Concerns

Please report these as security issues:

- prompt-injection patterns that cause a skill to ignore constraints
- instructions that allow secrets to be read, copied, exposed, or persisted
- instructions that allow pushing, deploying, publishing, deleting, or external communication without explicit approval
- worker prompts that grant broad authority without scope, stop condition, and verification
- runtime bindings that imply capabilities the runtime does not actually provide
- examples that contain private paths, credentials, customer data, or private workflow assumptions as public defaults

## Safety Rule

Kybernetes should default to least privilege, explicit human approval for irreversible actions, measurable verification, and clear blocked reports instead of endless retries.
