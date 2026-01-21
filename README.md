Cloud Security Guardrails Sandbox (Terraform + OPA)

Overview

This repository demonstrates preventive cloud security guardrails enforced at Terraform plan time using OPA (Open Policy Agent) and Conftest.

It serves as a policy design and validation sandbox where cloud security teams define, test, and iterate on both baseline (CIS-inspired) and organization-specific security controls before infrastructure is deployed.

The objective is to stop insecure cloud configurations before they reach production, without relying on manual reviews or post-deployment detection.

⸻

What This Project Demonstrates
	•	Policy-as-code using OPA (Rego)
	•	Preventive enforcement before terraform apply
	•	Layered guardrails:
	•	CIS-inspired baseline controls
	•	Custom organization security policies
	•	Reproducible validation using real Terraform plans
	•	Security enforcement that scales across teams and environments

This is not a compliance checklist — it is a practical enforcement layer used in modern cloud security and DevSecOps teams.

⸻

Guardrail Strategy

Baseline + Custom Policy Layering

This repository intentionally combines baseline and custom policies to demonstrate how security teams operate in practice:
	•	Baseline policies provide secure-by-default protections aligned with CIS guidance
	•	Custom policies encode organization-specific risk tolerance, standards, and lessons learned

Both policy types are evaluated together. Infrastructure is only allowed to deploy if all guardrails pass.

⸻

Guardrails Implemented

CIS-Inspired Baseline Controls
	•	Block public S3 bucket ACLs
	•	Require S3 Public Access Block
	•	Enforce encryption for cloud storage
	•	Restrict overly permissive network exposure (e.g., 0.0.0.0/0)

Custom Organization Policies
	•	Organization-specific extensions layered on top of the baseline
	•	Demonstrates policy strengthening, overrides, and evolution
	•	Written to be auditable, composable, and easy to extend

⸻

Proof of Enforcement

Two Terraform examples are included:
	•	bad_s3
Intentionally insecure configuration → fails policy evaluation
	•	good_s3
Secure, compliant configuration → passes all checks

This clearly demonstrates that insecure infrastructure is prevented from deployment, while compliant changes proceed without friction.

⸻

Policy Enforcement Flow
	1.	Terraform generates an execution plan
	2.	OPA / Conftest evaluates the plan
	3.	Baseline and custom policies are applied
	4.	Deployment is blocked unless all policies pass

In production, this pattern runs in:
	•	CI/CD pipelines
	•	Pull request checks
	•	Pre-deployment gates

⸻

Why This Matters

This project demonstrates:
	•	Preventive, automation-first cloud security
	•	Policy-as-code maturity
	•	Secure-by-default platform thinking
	•	How security teams reduce risk without slowing delivery

It reflects how Principal-level Cloud Security Engineers design and enforce guardrails at scale.
