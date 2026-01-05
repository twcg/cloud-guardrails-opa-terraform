Preventative Cloud Security Guardrails (Terraform + OPA)

Overview:
This project implements preventative cloud security guardrails by evaluating Terraform execution plans against policy-as-code rules before any infrastructure is deployed to AWS.
The goal is to block insecure or non-compliant infrastructure configurations (e.g., public storage, missing encryption) at deploy time, eliminating entire classes of cloud misconfiguration risk without slowing development teams.

Problem Statement:
Cloud security incidents are frequently caused by insecure infrastructure configurations, not application bugs. Examples include:
Publicly accessible storage
Over-permissive access controls
Missing encryption
Traditional security controls often detect these issues after deployment, increasing incident response effort, audit findings, and business risk.

Solution:
This project enforces policy-as-code guardrails on Terraform plans using OPA (Open Policy Agent) and Conftest.
By validating Terraform plans before terraform apply, insecure configurations are blocked before AWS resources are created.
This approach:
Prevents misconfigurations instead of detecting them later
Requires no AWS credentials
Integrates cleanly into CI/CD workflows
Scales across teams and environments

Where This Runs in the Lifecycle:
This control runs before infrastructure exists.

Terraform code
      ↓
terraform plan
      ↓
OPA / Conftest policy evaluation  ← (this project)
      ↓
terraform apply (only if policies pass)
      ↓
AWS resources created
This project does not monitor or control running workloads; it enforces security exclusively at infrastructure deployment time.

What Is Enforced (Current Scope)

The current implementation enforces secure S3 storage defaults:

❌ Blocks public S3 bucket ACLs
❌ Blocks S3 buckets without public access blocks
✅ Allows private, encrypted S3 buckets

The pattern is intentionally generic and extensible to other controls (IAM, networking, encryption, etc.).

Bad vs Good Examples

This repository includes intentionally insecure and secure Terraform examples to demonstrate how the guardrails behave in both failure and success scenarios.

bad_s3: Defines a publicly accessible S3 bucket and is blocked by policy.
good_s3: Defines a private, encrypted S3 bucket and passes policy checks.

This pattern shows how insecure infrastructure is prevented from deployment while compliant configurations proceed without friction.
