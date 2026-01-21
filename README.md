# Cloud Security Guardrails Sandbox  
**Terraform + OPA (Policy-as-Code)**

---

## Overview

This repository demonstrates **preventive cloud security guardrails** enforced at **Terraform plan time** using **OPA (Open Policy Agent)** and **Conftest**.

It serves as a **policy design and validation sandbox** where cloud security teams define, test, and iterate on both:

- **CIS-inspired baseline controls**
- **Organization-specific security policies**

The objective is to **stop insecure cloud configurations before they reach production**, without relying on manual reviews or post-deployment detection.

This pattern reflects how modern **Cloud Security, Platform Security, and DevSecOps** teams enforce security at scale.

---

## What This Project Demonstrates

- Policy-as-Code using **OPA (Rego)**
- Preventive security enforcement **before `terraform apply`**
- Layered guardrails:
  - CIS-inspired baseline policies
  - Custom organization policies
- Reproducible validation using real Terraform execution plans
- Security enforcement that scales across teams and environments

> This is **not** a compliance checklist.  
> It is a **practical enforcement layer** used in real-world cloud security programs.

---

## Guardrail Strategy

### Baseline + Custom Policy Layering

This repository intentionally combines **baseline** and **custom** policies to demonstrate how security teams operate in practice:

- **Baseline policies** provide secure-by-default protections aligned with CIS guidance
- **Custom policies** encode organization-specific risk tolerance, internal standards, and lessons learned

Both policy types are evaluated together.  
Infrastructure is only allowed to deploy if **all guardrails pass**.

---

## Guardrails Implemented

### CIS-Inspired Baseline Controls

- Block public S3 bucket ACLs  
- Require S3 Public Access Block  
- Enforce encryption for cloud storage  
- Restrict overly permissive network exposure (e.g. `0.0.0.0/0`)  

### Custom Organization Policies

- Organization-specific rules layered on top of the baseline
- Demonstrates policy strengthening and override capability
- Written to be clear, auditable, and extensible

---

## Proof of Enforcement

Two Terraform examples are included to demonstrate enforcement behavior:

- **`bad_s3`**  
  Intentionally insecure configuration → **fails policy evaluation**

- **`good_s3`**  
  Secure, compliant configuration → **passes all guardrails**

This demonstrates that insecure infrastructure is **blocked before deployment**, while compliant configurations proceed without friction.

---

## Policy Enforcement Flow

1. Developers write Terraform code  
2. Terraform generates an execution plan  
3. OPA / Conftest evaluates the plan:
   - CIS-inspired baseline policies applied
   - Custom organization policies applied
4. `terraform apply` is allowed only if all policies pass  

In production environments, this policy gate typically runs in:

- CI/CD pipelines
- Pull request checks
- Pre-deployment approval workflows

---

## Why This Matters

This project demonstrates:

- Preventive, automation-first cloud security
- Policy-as-code maturity
- Secure-by-default platform thinking
- How security teams reduce risk **without slowing delivery**

It reflects how **senior and principal-level cloud security engineers** design and enforce guardrails at scale.

---

## Interview Context

If asked to explain this repository:

> “This is a sandbox I use to design and validate cloud guardrails before they’re promoted into production CI/CD pipelines. It shows how baseline and organization-specific policies are layered to prevent insecure infrastructure before deployment.”

---
