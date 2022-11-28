# GKE_DICOM_MLLP
Terraform for GKE with DICOM and MLLP adapter deplyments

<p align="center">
  <a href="" rel="noopener">
</p>

<h3 align="center">MLLP and DICOM adapter Generic deployments in GKE</h3>

---

## 📝 Table of Contents

- [Audience](#Audience)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting_started)
- [Built Using](#built_using)
- [CI/CD](#cicd)
- [Authors](#authors)

---

## Audience

Intended for use in healthcare engagements where the DICOM and MLLP adapters are required. Please refer to the latest Adapters [MLLP](https://github.com/GoogleCloudPlatform/mllp) and [DICOM] (https://github.com/GoogleCloudPlatform/healthcare-dicom-dicomweb-adapter) before deploying and modify as necessary.

---

## 🌡️ Prerequisites <a name = "prerequisites"></a>

- Shared VPC ([Shared VPC](https://cloud.google.com/vpc/docs/shared-vpc) )
- [Remote](https://www.terraform.io/language/settings/backends/gcs) State Bucket for TF

---
## ⛏️ Tools <a name = "built_using"></a>

- [Kubernetes](https://kubernetes.io/) - Container Orchestration
- [Terraform](https://terraform.io/) - Cloud IaC
- [Google Cloud Platform](https://www.cloud.google.com/)

## 🚀 CI/CD Lifecycles <a name = "cicd"></a>

The following directories have programs that can be containerized and deployed to kubernetes:

- [go/wiki-server](https://github.com/theboarderline/operators/tree/ops/go/wiki-server)
- [go/wiki-operator](https://github.com/theboarderline/operators/tree/ops/go/wiki-operator)
## ✍️ Authors <a name = "authors"></a>

- [@ryanlee](https://github.com/ryanleemw)