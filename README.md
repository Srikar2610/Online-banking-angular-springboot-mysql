# Online-banking-angular-springboot-mysql

Online-Bank-Simulator

Spring Boot/Spring Data/Spring Security/Hibernate/MySQL/REST

The project simulates online banking system. It allows to register/login, deposit/withdraw money from accounts, add/edit recipients, transfer money between accounts and recipients, view transactions, make appointments.

There are two roles user and admin.

## Thing to run the application

__Clone the repository__
```
git clone https:https://github.com/Srikar2610/Online-banking-angular-springboot-mysql
```

__Go the folder__
```
cd Online-banking-angular-springboot-mysql
```

__Set Your MySQL username & password in application.properties__

[application.properties](../../blob/master/src/main/resources/application.properties)

__Run the application__
```
mvn clean package
mvn clean spring-boot:run
```

## Screen shot 

### Sign Up Page

![Sign Up Page](img/signup.png "Sign Up Page")

### Sign In Page

![Sign Up](img/login.png "Login Page")

### Dashboard Page

![Dashboard page](img/dashboard1.png "Dashboard Page")

### Deposit Page

![Deposit Page](img/deposit.png "Deposit Page")

### Dashboard Page   
![Dashboard page](img/dashboard2.png "Dashboard Page")

AWS Cloud-Native Online Banking Application
Online-Bank-Simulator
A Cloud-Native Deployment for Scalable & Secure Financial Services using AWS with PHP, Flask/Python, Spring Boot, Spring Data, Spring Security, Hibernate, MySQL, and RESTful APIs.

The project simulates an online banking system that allows users to register/login, deposit/withdraw money from accounts, add/edit recipients, transfer money between accounts and recipients, and view transactions. It also includes functionality for making appointments. The system supports two distinct roles: user and admin, providing different levels of access and functionality.

🚀 Features
This project showcases a comprehensive cloud-native deployment with the following key features:

Multi-Tier Application:

Frontend: Angular

Backend: A SpringBoot application deployed on Amazon EKS.

Database: Amazon RDS for MySQL with Multi-AZ deployment for high availability and automated failover.

Automated CI/CD:

Source Code Management: Utilizes GitHub for version control.

Automated Build, Test, and Deployment: Orchestrated using AWS CodePipeline and CodeBuild.

Container Image Management: Securely managed with Amazon Elastic Container Registry (ECR).

Code Quality & Security:

Static Code Analysis: Integrated SonarQube in the build process to identify code smells, bugs, and vulnerabilities early.

Container Image Vulnerability Scanning: Trivy scans Docker images before they are pushed to ECR, enhancing supply chain security.

Multi-Region Disaster Recovery (DR):

Active-Passive Strategy: us-east-1 serves as the primary active region, handling all live traffic. us-west-2 acts as the passive, standby DR region.

Automated Failover Routing: Achieved via Amazon Route 53 health checks, redirecting traffic to the DR region in case of primary region failure.

Duplicate Infrastructure: The entire infrastructure in the DR region is consistently provisioned using Terraform, ensuring an identical environment to the primary.

Robust Monitoring & Alerting:

Centralized Logging and Metrics: Leverages Amazon CloudWatch for collecting and storing application and infrastructure logs and metrics.

Real-time Alerts: Configured via Amazon SNS (Simple Notification Service) for critical conditions (e.g., EKS Node CPU utilization exceeding 75%).

Security Best Practices:

IAM Least Privilege: Granular IAM roles and service-linked roles ensure all AWS services operate with the minimum necessary permissions.

Network Isolation: Application and database tiers reside within private subnets of the VPC, isolated from direct internet access.

Security Groups & NACLs: Granular traffic control implemented at both instance and subnet levels.

🛠️ AWS Services Used
This project extensively utilizes the following AWS services:

Networking:

Amazon VPC (Virtual Private Cloud)

Public/Private Subnets

Internet Gateway (IGW)

NAT Gateway

Compute & Containerization:

Amazon EKS (Elastic Kubernetes Service)

Amazon EC2 (for EKS Worker Nodes)

Amazon Elastic Container Registry (ECR)

Database:

Amazon RDS for MySQL (Multi-AZ)

Developer Tools (CI/CD):

AWS CodePipeline

AWS CodeBuild

AWS CodeStar Connections (for GitHub integration)

Management & Governance:

Amazon CloudWatch (Logs, Metrics, Alarms)

Amazon SNS (Simple Notification Service)

AWS IAM (Identity and Access Management)

Amazon Route 53

Infrastructure as Code:

Terraform (for Region B DR deployment)

AWS CloudFormation (for Region A primary deployment, as seen in project context)

🔄 CI/CD Pipeline Details
The CI/CD pipeline automates the journey of your application code from GitHub to a running service on EKS.

       ┌────────────┐        ┌────────────┐        ┌──────────────┐        ┌────────────┐
       │  GitHub    │ ───▶   │ CodeBuild  │ ───▶   │    ECR       │ ───▶   │EKS/Kubernetes│
       └────────────┘        └────────────┘        └──────────────┘        └────────────┘
             ▲                                            │                         │
             └──────────────────[Triggered on push]───────┴─────────[Rolling updates / hooks]



Workflow Breakdown:

Source Stage (GitHub):

Code changes pushed to the main branch in GitHub automatically trigger AWS CodePipeline via a CodeStar Connection.

Build Stage (CodeBuild):

A CodeBuild environment is provisioned (as defined by buildspec.yml).

Static Code Analysis: SonarQube scanner runs against the PHP and Python codebases, ensuring adherence to quality and security standards.

Dependency Management & Build: The Frontend (PHP) and Backend (Flask/Python) applications are built, and their respective Docker images are created.

Image Scanning: Trivy scans the newly built Docker images for vulnerabilities. This step can be configured to fail the build if critical vulnerabilities are found, acting as a security gate.

Build Artifacts: Container images and dynamically updated Kubernetes manifests (deployment.yaml, service.yaml) are prepared as artifacts.

Push to ECR Stage:

The validated container images (PHP frontend, Flask backend) are pushed to their respective private repositories in Amazon ECR.

ECR's private image scanning feature provides an additional layer of security post-push.

Deploy Stage (EKS):

AWS CodeBuild (or a direct CodePipeline action) applies the prepared Kubernetes manifests (e.g., Deployment, Service, Ingress) to the Amazon EKS cluster in us-east-1 (primary region). This updates the application to the latest version via rolling updates.

🌐 Disaster Recovery Strategy
The DR strategy ensures the application remains highly available and resilient even in the event of a full regional outage.

Active-Passive Setup: us-east-1 is configured as the primary active region, serving all user traffic. us-west-2 functions as the passive, standby DR region, ready for activation.

Data Replication: Amazon RDS in us-east-1 replicates data to us-west-2 using cross-region read replicas (which can be promoted to primary) or consistent snapshot replication, ensuring a low Recovery Point Objective (RPO).

Infrastructure as Code for DR: The entire infrastructure in us-west-2 is consistently managed and provisioned by Terraform, allowing for rapid and consistent deployment of an identical environment to the primary region during a disaster or DR drill.

Automated Failover (Route 53):

Amazon Route 53 performs continuous health checks on the application's endpoint (e.g., Application Load Balancer / Network Load Balancer) in both us-east-1 and us-west-2.

If the primary region's endpoint fails its health checks, Route 53 automatically updates DNS records to direct all new user traffic to the us-west-2 region.

Upon failover, the RDS replica in us-west-2 is promoted to primary, and Kubernetes services are scaled up/activated to handle incoming traffic, ensuring minimal downtime (low RTO - Recovery Time Objective).

⚙️ Setup and Deployment (High-Level)
This section outlines the high-level steps to set up and deploy the Online Banking application across both regions.

Prerequisites:
AWS Account with administrative access.

AWS CLI configured and authenticated.

Terraform installed (version 1.x recommended) for DR region setup.

kubectl configured for EKS interaction.

Docker installed.

maven-settings.xml file configured for Maven mirror (for Docker build process).

Steps:
Clone Repository:

git clone https://github.com/PavanThumati/AWS_CapStone_Final_Project.git
cd AWS_CapStone_Final_Project



Region A (Primary) Deployment (us-east-1):

Define core networking components (VPC, subnets, Internet Gateway, NAT Gateway) using AWS CLI or dedicated CloudFormation/Terraform scripts (if separate IaC is used for the primary region).

Deploy the Amazon EKS Cluster and associated Node Groups.

Create the Amazon RDS MySQL Multi-AZ instance (mydb).

Configure Amazon ECR repositories for both frontend and backend Docker images.

Set up AWS CodePipeline, CodeBuild projects, and a CodeStar Connection to your GitHub repository. This setup will automatically trigger initial builds and deployments.

Ensure all necessary IAM roles and security groups are correctly configured for secure resource interaction.

Region B (Disaster Recovery) Deployment (us-west-2):

Navigate to the terraform/dr-region directory within your cloned repository.

Initialize and apply Terraform commands to provision the duplicate infrastructure, including:

VPC and networking components.

A standby Amazon EKS cluster.

A standby RDS instance (configured for replication from the primary).

Configure the mirrored CodePipeline in us-west-2 (if applicable, for DR drills or specific multi-region deployment patterns).

Route 53 Configuration:

Configure the Amazon Route 53 hosted zone for srikar.com with failover routing policies.

Point DNS records to the Application Load Balancer (ALB) or Network Load Balancer (NLB) endpoints in both us-east-1 and us-west-2 regions.

Associate robust Route 53 health checks with these endpoints to enable automated failover.

(Note: Specific terraform directories, kubectl commands, and CodePipeline configurations will be detailed in dedicated sub-directories/documentation within this repository.)

📊 Monitoring and Alerting
Comprehensive monitoring and alerting are critical for maintaining application health and performance.

Amazon CloudWatch:

Log Collection: Collects and stores logs from EKS pods, application services (Spring Boot, PHP, Flask), AWS CodeBuild, AWS CodePipeline, VPC Flow Logs, and Load Balancer Access Logs.

Metrics: Gathers real-time performance data for EKS nodes, pods, containers, and database performance (CPU usage, memory utilization, network I/O, database connections).

CloudWatch Alarms: Configured to trigger alerts for critical conditions, such as:

EKS Node CPU Utilization > 75%

Application error rates, latency spikes

Database connection errors, high CPU/memory utilization

Amazon SNS Notifications: CloudWatch Alarms publish messages to configured SNS topics, which then notify operations teams via email, Slack, PagerDuty, or other integrated services.

Grafana: Provides advanced visualization and dashboarding capabilities, integrating with CloudWatch metrics for a holistic view of the application and infrastructure.

🔒 Security Considerations
Security is paramount for an online banking application. This project incorporates multiple layers of security:

IAM Least Privilege: All AWS services and roles (e.g., CodeBuild service role, EKS worker node roles) are configured with the absolute minimum necessary IAM permissions to perform their functions, adhering to the principle of least privilege.

Network Isolation:

Application and database tiers reside exclusively in private subnets within the VPC, meaning they are not directly exposed to the internet.

Access to these components is controlled via internal load balancers or bastion hosts, or Kubernetes Ingress controllers.

Security Groups & Network ACLs (NACLs): Granular traffic control is enforced at both the instance (Security Groups) and subnet (NACLs) levels, allowing only authorized traffic flows.

Container Security:

Trivy Scanning: Integrated into the CI/CD pipeline to identify and prevent known vulnerabilities in Docker images before deployment.

ECR's Native Scanning: Provides an additional layer of automated image scanning directly within the ECR repository.

Code Quality (SonarQube): Helps identify and remediate security vulnerabilities (e.g., SQL injection, XSS) within the application code itself, complementing container scanning.

Data Encryption: Data at rest (RDS, S3) and in transit (SSL/TLS for connections) should be encrypted. RDS Multi-AZ ensures data redundancy and consistency.

👋 Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, please feel free to:

Fork the repository.

Create a new branch (git checkout -b feature/your-feature-name).

Make your changes and ensure your code adheres to existing coding standards.

Write clear and concise commit messages.

Submit a pull request with a detailed description of your changes.

