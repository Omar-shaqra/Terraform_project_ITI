
# Terraform AWS Infrastructure Project

This repository contains a Terraform configuration to set up a complete infrastructure on AWS. The infrastructure includes a Virtual Private Cloud (VPC), load balancers, proxy servers, and web servers. It is designed to manage traffic securely and efficiently, with state management and locking enabled for high availability.

## Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Infrastructure Components](#infrastructure-components)
- [State Management](#state-management)
- [License](#license)

## Project Overview

This Terraform project provisions a scalable AWS infrastructure designed to support web applications with load balancing, secure traffic management, and high availability. The infrastructure consists of a VPC, load balancers, proxy servers, and web servers.

The project also utilizes S3 for remote state storage and DynamoDB for state locking, ensuring consistent and reliable infrastructure management, especially in collaborative environments.

## Features

- **VPC Setup**: A custom VPC with subnets for public and private resources.
- **Load Balancers**: Configurable Elastic Load Balancers (ELBs) to distribute incoming traffic.
- **Proxy Servers**: Secure proxy servers to manage traffic between web servers and clients.
- **Web Servers**: Highly available web servers deployed within private subnets.
- **Traffic Security**: Integrated security groups and network ACLs to control traffic flow.
- **State Management**: Terraform state is stored in an S3 bucket with DynamoDB table for state locking to ensure high availability and consistency.

## Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads) >= v0.12
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- An AWS account with sufficient permissions to create VPCs, EC2 instances, and other resources.
- Configure your AWS CLI with appropriate credentials using `aws configure`.

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/terraform-project-iti.git
   cd terraform-project-iti
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Create an execution plan:
   ```bash
   terraform plan
   ```

4. Apply the changes:
   ```bash
   terraform apply
   ```

5. To destroy the infrastructure when it's no longer needed:
   ```bash
   terraform destroy
   ```

## Infrastructure Components

- **VPC**: A custom VPC that includes multiple subnets (both public and private) across availability zones.
- **Elastic Load Balancer (ELB)**: A load balancer for distributing traffic to web servers.
- **Proxy Servers**: Deployed in public subnets to serve as gateways between the load balancer and web servers.
- **Web Servers**: EC2 instances in private subnets behind the load balancer for high availability and security.
- **Security Groups**: Configured to ensure proper traffic rules for web servers, load balancers, and proxy servers.

## State Management

This project uses remote state storage and state locking to manage Terraform's state effectively.

- **Remote State Storage**: The Terraform state is stored in an S3 bucket to enable collaboration and ensure that the state is shared across users.
- **State Locking**: A DynamoDB table is used for state locking to prevent concurrent changes and maintain the integrity of the infrastructure.

