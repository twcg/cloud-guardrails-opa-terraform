# Custom Cloud Security Policies (OPA)

## Overview
This directory contains **custom cloud security policies** enforced using **Open Policy Agent (OPA)** and evaluated against Terraform execution plans prior to infrastructure deployment.

These policies represent **organization-specific security requirements** that extend beyond generic industry baselines, allowing teams to codify risk tolerance, internal standards, and business-driven security decisions as enforceable guardrails.

---

## Purpose of Custom Policies

Industry benchmarks such as CIS provide strong secure defaults, but they cannot fully capture:

- Organization-specific risk appetite
- Internal security standards
- Regulatory or audit-driven requirements
- Environment-specific constraints (e.g., production vs non-production)
- Security lessons learned from past incidents

Custom policies exist to **translate these requirements into automated, preventive controls** without requiring changes to Terraform modules or slowing development velocity.

---

## How These Policies Are Enforced

Custom policies are evaluated **alongside baseline policies** during Terraform plan validation:

Terraform code
|
v
terraform plan
|
v
OPA / Conftest evaluation
|-- CIS-inspired baseline policies
|-- Custom organization policies (this directory)
|
v
terraform apply (only if all policies pass)

Infrastructure is only deployed when **both baseline and custom policies pass**.

---

## Current Scope

The current custom policies focus on **secure S3 storage enforcement**, including:

- Blocking public S3 bucket ACLs
- Requiring S3 Public Access Block
- Enforcing private, secure-by-default storage configurations

These controls intentionally overlap with baseline rules to demonstrate:
- Policy layering
- Override capability
- How organizations can strengthen default guardrails based on internal risk

---

## Example Behavior

Terraform examples are provided to demonstrate enforcement behavior:

- **bad_s3**  
  Defines an insecure S3 configuration and fails custom policy evaluation.

- **good_s3**  
  Defines a secure S3 configuration and passes all custom policies.

This pattern demonstrates how insecure infrastructure is **prevented from deployment**, while compliant configurations proceed without friction.

---

## Extensibility

This directory is designed to evolve as organizational needs change and may include future custom controls such as:

- Mandatory tagging standards
- IAM privilege restrictions
- Environment-specific network exposure limits
- Additional encryption or logging requirements

---

## Key Takeaway

Custom policies enable organizations to **encode business-aligned security requirements as code**, ensuring consistent, automated enforcement while preserving developer productivity.
