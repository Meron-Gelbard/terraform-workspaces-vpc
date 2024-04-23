
# AWS VPC IaC Deployment with Terraform Workspaces

## Overview

This Terraform project automates the deployment of an AWS VPC architecture.
 It supports deploymet of multiple environments (e.g., development, staging, production) with one TF module directory using Terraform workspaces to ensure isolation and management of resources across different deployment stages.

## Features

- **VPC Creation:** 
This module sets up a VPC with multiple private and public subnets. It deploys a set of EC2 servers as a high-availability target group along with an Application Load Balancer in public subnets routing traffic to the backend servers.
An internet gateway and a NAT gateway are deployed with all the required routes.
Configures security groups for the EC2s and ALB.
- **Multi-Environment Support:** Uses Terraform workspaces to manage and switch between environments seamlessly.
- **Scalability:** Dynamically configures subnets and EC2s to ensure high availability and scalability.

## Prerequisites

- AWS Account
- Terraform installed (version 0.12+ recommended)
- AWS CLI installed and configured
- Configure your Terraform Workspaces.

## Quick Start

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/terraform-aws-vpc.git
   cd terraform-aws-vpc
   ```

2. **Initialize Terraform**

   Initialize Terraform to download the necessary plugins and modules:

   ```bash
   terraform init
   ```

3. **Create Workspaces**

   Create a new workspace for each environment you want to manage 
   (currently works with dev and prod):

   ```bash
   terraform workspace new dev
   terraform workspace new prod
   ```

   Switch to the desired workspace using:

   ```bash
   terraform workspace select dev
   ```

4. **Configure Your Variables**

   Modify the `terraform.tfvars` or configure environment-specific variables in the config_locals.tf file.

5. **Plan and Apply**

   Generate and review the execution plan to see the changes that will be applied:

   ```bash
   terraform plan
   ```

   Apply the configuration to create the infrastructure:

   ```bash
   terraform apply
   ```

## Workspace Management

Terraform workspaces allows you to manage separate state files for different environments, making it easier to manage infrastructure across multiple configurations with asingle IaC code base. Use the `terraform workspace` command to manage workspaces:

- List all workspaces: `terraform workspace list`
- Switch workspaces: `terraform workspace select [workspace_name]`