# AWS Secure Cloud Foundation & DevSecOps Automation Platform

[![DevSecOps CI Security Pipeline](https://github.com/farjad-m/aws-secure-foundation-iac/actions/workflows/devsecops-pipeline.yml/badge.svg)](https://github.com/farjad-m/aws-secure-foundation-iac/actions/workflows/devsecops-pipeline.yml)
[![Terraform](https://img.shields.io/badge/Terraform-v1.9-purple.svg)](https://www.terraform.io/)
[![Compliance](https://img.shields.io/badge/Compliance-SOC2%20%7C%20ISO27001-blue.svg)](https://www.iso.org/)

An enterprise-grade, audit-ready AWS cloud foundation deployed via **Modular Infrastructure-as-Code (Terraform)** and protected by automated **Shift-Left DevSecOps CI/CD security gates (GitHub Actions)**. Designed to satisfy strict governance, risk, and compliance (GRC) standards out of the box.

---

## 🏗️ Architecture & System Design

The following Mermaid diagram illustrates the dual-layer architecture: preventative cloud security hardening in AWS paired with automated security scanning on every Git push.

```mermaid
graph TD
    subgraph Developer Workstation
        A[Terraform Code & Python Scripts] -->|Git Push| B(GitHub Repository)
    end

    subgraph GitHub Actions CI/CD Pipeline
        B --> C{Security Gates}
        C -->|1. Gitleaks| D[Secret Scanning]
        C -->|2. Trivy Config| E[IaC Misconfiguration Scan]
        C -->|3. Trivy FS| F[SCA Dependency Check]
        C -->|4. Bandit| G[SAST Python Analysis]
    end

    subgraph AWS Secure Cloud Foundation
        H[AWS CloudTrail Multi-Region Audit Trail] -->|Encrypted Logs| I[Hardened S3 Vault]
        I -->|AES-256 & TLS 1.2+| J[SOC 2 / ISO 27001 Compliance Baseline]
    end

    C -->|All Checks Pass| K[Production Deployment]