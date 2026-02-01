##     Implemented Infrastructure as Code using Terraform to provision a secure, multi-tier frontend–backend application on AWS. 
![alt text](<Screenshot 2026-02-01 191453.png>)
# Terraform AWS Frontend–Backend Architecture
* Through this implementation, I gained hands-on experience with:
* Designing and implementing a Virtual Private Cloud (VPC) with proper network isolation
* Building multi-tier architectures using public and private subnets
* Configuring route tables to control traffic flow between subnets, internet gateways, and NAT gateways
* Implementing security groups to enforce least-privilege communication between frontend and backend tiers
* Deploying and integrating internet-facing and internal Application Load Balancers with target groups
* Using NAT Gateways and Internet Gateways to manage controlled outbound and inbound connectivity
* Managing DNS using Route 53, including alias records for load balancers
* Maintaining remote Terraform state in an S3 state bucket and understanding Terraform’s state management model
* Understanding Terraform’s dependency graph and how resource relationships determine creation order
* Applying Terraform best practices using variables, functions, and user-data templates to build reusable and maintainable infrastructure

* Used Terraform to manage infrastructure as code, and understood how it enables consistent, repeatable infrastructure provisioning.

HAVE A LOOK AT MY PROJECT IMPLEMENTATION 
## Overview

This repository contains a **Terraform-defined AWS infrastructure** implementing a **secure, multi-tier frontend–backend application**.

The system deploys:

* A **Streamlit frontend**
* A **Flask backend**
* A **public frontend Application Load Balancer**
* A **private (internal) backend Application Load Balancer**
* **Route 53 DNS** for frontend access
* Strong **network and security isolation**
* **Remote Terraform state stored in Amazon S3**

The focus of this project is correct **AWS networking, security boundaries, and infrastructure-as-code design**, rather than application complexity.

---

## Architecture Summary

### Traffic flow

```
Client
  ↓
Route 53 (DNS)
  ↓
Frontend ALB (public)
  ↓
Frontend EC2 instances (private subnets)
  ↓
Backend ALB (private / internal)
  ↓
Backend EC2 instances (private subnets)
```

---

### Networking

* Single VPC spanning multiple Availability Zones
* **Public subnets**

  * Frontend Application Load Balancer
  * NAT Gateways
* **Private subnets**

  * Frontend EC2 instances
  * Backend EC2 instances
* **Backend ALB**

  * Deployed in private subnets
  * Not internet-facing
  * Accessible only from the frontend tier

---

## DNS (Route 53)

* A **Route 53 hosted zone** is used to manage DNS records
* The frontend application is exposed using a **Route 53 alias record**
* The alias points directly to the **Frontend ALB**
* No public DNS record exists for the backend ALB

This ensures:

* Clean and stable frontend access
* Backend services remain fully private

---

## Security Design

### Frontend Security Group

Frontend EC2 instances are deliberately restricted:

* Inbound traffic:

  * Allowed **only from the Frontend ALB**
* Outbound traffic:

  * Allowed **only to the Backend ALB**
* No unrestricted internet access

This enforces a controlled and auditable communication path.

---

### Backend Security Group

Backend EC2 instances are isolated by design:

* No public IP addresses
* Inbound traffic:

  * Allowed **only from the Backend ALB**
* Outbound traffic:

  * Routed through a **NAT Gateway** for system updates

---

### Load Balancers

* **Frontend ALB**

  * Internet-facing
  * Receives traffic via Route 53
* **Backend ALB**

  * Internal
  * Receives traffic only from frontend instances

---

## Application Components

### Frontend

* Streamlit application running on EC2
* Deployed in private subnets
* Backend endpoint injected dynamically using user-data
* No hardcoded backend addresses

### Backend

* Flask application running on EC2
* Deployed in private subnets
* Accessible only through the private backend ALB

---

## Infrastructure as Code (Terraform)

### Terraform Usage

* Remote state backend using **Amazon S3**
* Use of variables and outputs throughout
* Use of Terraform functions:

  * `file`
  * `templatefile`
  * `path.module`
* User-data templates for instance bootstrapping
* Clear separation of networking, security, and compute concerns

Terraform’s dependency graph determines creation order.

---


## Deployment Workflow

1. Configure AWS credentials
2. Initialize Terraform

   ```bash
   terraform init
   ```
3. Review the plan

   ```bash
   terraform plan
   ```
4. Apply the infrastructure

   ```bash
   terraform apply
   ```

After deployment, the frontend is accessible via the **Route 53 domain name**.

---

## Design Considerations

* Backend services are never exposed publicly
* Inter-tier communication is enforced using security groups
* Architecture supports future Auto Scaling with minimal changes
* Emphasis on correctness, isolation, and clarity

---

## Future Enhancements

* Auto Scaling Groups
* HTTPS using ACM
* CloudWatch monitoring
* DynamoDB state locking
* CI/CD pipeline integration

---

