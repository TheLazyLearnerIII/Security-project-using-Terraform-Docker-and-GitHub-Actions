# Security Project 1: CI/CD with Terraform, Docker, and GitHub Actions

This project automates AWS infrastructure provisioning using Terraform and performs security scans with Lynis inside a Docker container, all triggered automatically through GitHub Actions.

## Architecture Overview

1. Terraform provisions a secure AWS environment:
    - Custom VPC & subnet
    - EC2 instance with least privilege IAM role
    - Outbound-only security group

2. Docker + Lynis runs a system security audit inside a container.

3. GitHub Actions automates:
    - Terraform deployment
    - Security scans
    - Uploading logs as artifacts

    +---------------------+       +---------------------+       +---------------------+
|  Terraform CI/CD    | --->  |  AWS Infrastructure | --->  | Docker Lynis Scan   |
|  (GitHub Actions)   |       |  (VPC, EC2, IAM)     |       | (Security Report)   |
+---------------------+       +---------------------+       +---------------------+

Project-Security/
├── terraform/                # Terraform configuration files
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── provider.tf
├── docker-lynis/              # Docker-based Lynis scanner
│   ├── Dockerfile
│   └── lynis-scan.sh
├── .github/workflows/         # GitHub Actions workflows
│   ├── terraform.yml
│   └── docker-lynis.yml
├── logs/                      # Security scan output (auto-generated)
└── README.md


## Pre-requisites

- AWS Account
    - IAM user w/ programmatic access
    - Access keys stored as Github Secrets: AWS_ACCESS_KEY_ID & AWS_SECRET_ACCESS_KEY
- Local Tools
    - Terraform
    - Docker

## How it runs

1. Deploy Infrastructure (Local)
cd terraform
terraform init
terraform apply

2. Run Lynis Scan (Local)
cd docker-lynis
docker build -t lynis-sec .
docker run --rm -v "$(pwd)/logs:/var/log/lynis-scan" lynis-sec

3. Trigger via GitHub Actions
- push changes to main branch
- Workflows:
    - Terraform CI: Deploy AWS resources
    - Docker Lynis Security: Builds/runs container scan


## Outputs

Terraform Outputs
    - EC2 Instance Public IP
    - EC2 Instance ID

Lynis Security Scan
    - Output file: logs/scan.log
======================================
[ Lynis 3.0.8 Results ]              ||
Hardening index : 72 [#######---]    ||
Warnings        : 3                  ||
Suggestions     : 5                  ||
======================================

##  Important Note

I have worked on this project for almost 2 weeks. I used alot resorces in order to get the project up and running. 

For Terraform I used the Terraform Registry to format my terraform correctly - https://registry.terraform.io/

For Docker I used the docker docs to learn the basic concepts aswell as alot of googling. - https://docs.docker.com/

When it came to Github actions and creating a yml file from scratch I used ALOT more resources thaan the previous tools, since I didnot have any experience with CI/CD before this project. I used google, medium.com and ChatGPT. 

I'll be 100% tranparent, 60% of my research came from chatGPT. But, I made sure to ask ChatGPT not to show the live code but the steps on how to complete the project. 

## Contact

Created by Edward A. Polanco Murillo A cloud security enthusiast certified in the AWS Certified Solutions Architect – Associate and the CompTIA security+ certifications.