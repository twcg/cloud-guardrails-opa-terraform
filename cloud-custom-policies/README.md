Cloud Security Guardrails (Terraform + OPA)

Overview

This project demonstrates preventive cloud security guardrails enforced at Terraform plan time using OPA (Open Policy Agent) and Conftest.

The goal is to stop insecure cloud infrastructure before it is deployed, by evaluating Terraform plans against opinionated, CIS-aligned baseline policies and custom security controls.

This pattern is commonly used in platform security, cloud security engineering, and DevSecOps teams to reduce risk, enforce standards, and scale security across engineering organizations.

What This Project Demonstrates

	•	Policy-as-Code using OPA (Rego)
	•	Preventive controls evaluated before terraform apply
	•	CIS-inspired baseline guardrails for common cloud risks
	•	Composable policies (baseline + custom)
	•	Reproducible validation via a single script

This is not a compliance checklist — it is a practical security enforcement layer designed for real-world cloud environments.

Guardrails Implemented:

CIS Baseline Policies

	•	Public storage blocked
	◦	No public S3 bucket ACLs
	◦	S3 Public Access Block required
	•	Encryption required
	◦	EBS volumes must be encrypted
	•	Network exposure restricted
	◦	No world-open SSH/RDP (0.0.0.0/0)
Custom Policies

	•	Additional organization-specific rules layered on top of the baseline

Policies are written to be clear, auditable, and extensible.

Proof the Guardrail Works

This repository includes two Terraform examples:
	•	bad_s3 — intentionally insecure
	•	good_s3 — secure and compliant
Running the policy gate shows:
	•	❌ bad_s3 fails (public ACL + missing public access block)
	•	✅ good_s3 passes all baseline and custom checks

How to Run
From the repository root:

chmod +x scripts/test-policies.sh
./scripts/test-policies.sh

Expected behavior:
	•	Insecure infrastructure fails the policy gate
	•	Secure infrastructure passes cleanly

Where This Fits in a Real Environment

In production, this policy gate would run:

	•	In CI/CD pipelines
	•	On pull requests
	•	Before terraform apply

This ensures security is enforced automatically, without relying on manual reviews or post-deployment detection.

Why This Matters

This project demonstrates:

	•	Cloud security architecture judgment
	•	Preventive security controls
	•	Policy-as-code maturity
	•	Secure-by-default platform thinking

It reflects how modern security teams enable developers while reducing risk at scale.
