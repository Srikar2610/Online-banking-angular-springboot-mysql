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

Features
Multi-Tier Application:
Frontend: PHP application served via EKS.
Backend: Flask and Python application, deployed on EKS.
Database: Amazon RDS for MySQL with Multi-AZ deployment for high availability.
Automated CI/CD:
Source code management with GitHub.
Automated build, test, and deployment using AWS CodePipeline and CodeBuild.
Container image management with Amazon ECR.
Code Quality & Security:
Static code analysis with SonarQube integration in the build process.
Container image vulnerability scanning with Trivy pre-push to ECR.
Multi-Region Disaster Recovery (DR):
Active-passive DR strategy utilizing us-east-1 as primary and us-west-2 as DR region.
Automated failover routing via Amazon Route 53 health checks.
Duplicate infrastructure in the DR region, provisioned via Terraform for consistency.
Robust Monitoring & Alerting:
Centralized logging and metrics with Amazon CloudWatch.
Real-time alerts via Amazon SNS (e.g., EKS Node CPU utilization exceeding 75%).
Security Best Practices:
Granular IAM roles and service-linked roles for AWS services.
VPC private subnets for application and database tiers.
🔧 AWS Services Used
Networking:
Amazon VPC, Public/Private Subnets
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
🔄 CI/CD Pipeline Details
The CI/CD pipeline automates the journey of your application code from GitHub to a running service on EKS.

Source Stage (GitHub):
Code changes pushed to the main branch in GitHub automatically trigger CodePipeline via a CodeStar Connection.
Build Stage (CodeBuild):
CodeBuild environment is provisioned.
Static Code Analysis: SonarQube scanner runs against the PHP and Python codebases.
Dependency Management & Build: Frontend (PHP) and Backend (Flask/Python) applications are built, and their respective Docker images are created.
Image Scanning: Trivy scans the newly built Docker images for vulnerabilities. If critical vulnerabilities are found, the build can be configured to fail.
Build artifacts, including container images and Kubernetes manifests, are prepared.
Push to ECR Stage:
The validated container images (PHP frontend, Flask backend) are pushed to their respective repositories in Amazon ECR.
ECR's private image scanning feature provides an additional layer of security post-push.
Deploy Stage (EKS):
CodeBuild or a direct CodePipeline action applies the Kubernetes manifests (e.g., Deployment, Service, Ingress) to the Amazon EKS cluster in us-east-1. This updates the application to the latest version.

     ┌────────────┐       ┌────────────┐       ┌──────────────┐       ┌────────────┐
     │  GitHub    │ ───▶ │ CodeBuild  │ ───▶  │     ECR      │ ───▶ │EKS/Kubernetes│
     └────────────┘       └────────────┘       └──────────────┘       └────────────┘
          ▲                        │                   │                       │
          └─────────────[Triggered on push]────────────┴────[Rolling updates / hooks]
🌐 Disaster Recovery Strategy
The DR strategy ensures the application remains available even in the event of a regional outage.

Active-Passive Setup: us-east-1 is the primary active region handling all traffic. us-west-2 is the passive, standby DR region.
Data Replication: Amazon RDS in us-east-1 replicates data to us-west-2 via cross-region read replicas (which can be promoted) or consistent snapshot replication, ensuring low Recovery Point Objective (RPO).
Infrastructure as Code for DR: The infrastructure in us-west-2 is managed by Terraform, allowing for rapid and consistent provisioning of an identical environment to the primary.
Automated Failover (Route 53):
Route 53 performs continuous health checks on the application's endpoint (e.g., ALB/NLB) in both us-east-1 and us-west-2.
If the primary region's endpoint fails its health checks, Route 53 automatically updates DNS records to direct all new user traffic to the us-west-2 region.
Upon failover, the RDS replica in us-west-2 is promoted to primary, and EKS services are scaled up/activated to handle incoming traffic.
⚙️ Setup and Deployment (High-Level)
Prerequisites:
AWS Account with administrative access.
AWS CLI configured.
Terraform installed (for DR setup).
kubectl configured for EKS interaction.
Docker installed.
Clone Repository:
git clone https://github.com/PavanThumati/AWS_CapStone_Final_Project.git
cd AWS_CapStone_Final_Project
Region A (Primary) Deployment:
Define VPC, subnets, IGW, NAT Gateway using AWS CLI or CloudFormation/Terraform scripts (if separate IaC is used for primary).
Deploy EKS Cluster and Node Groups.
Create RDS MySQL Multi-AZ instance.
Configure ECR repositories.
Set up AWS CodePipeline, CodeBuild projects, and CodeStar Connection to your GitHub repo. This will automatically trigger initial deployments.
Ensure IAM roles and security groups are correctly configured.
Region B (Disaster Recovery) Deployment:
Navigate to the terraform/dr-region directory.
Initialize and apply Terraform to provision the duplicate VPC, EKS cluster, and standby RDS instance.
Configure the mirrored CodePipeline in us-west-2 (if necessary, for DR drills or specific multi-region deployments).
Route 53 Configuration:
Configure the Route 53 hosted zone with failover routing policies, pointing to the ALB/NLB endpoints in both regions, and associate health checks.
(Note: Specific terraform directories, kubectl commands, and CodePipeline configurations will be detailed in dedicated sub-directories/documentation within this repository.)

📊 Monitoring and Alerting
CloudWatch: Collects and stores logs from EKS pods, application services, CodeBuild, CodePipeline, VPC Flow Logs, and Load Balancer Access Logs. Metrics for EKS nodes, pods, and database performance are also collected.
CloudWatch Alarms: Configured to trigger alerts for critical conditions, such as:
EKS Node CPU Utilization > 75%
Application error rates, latency spikes
Database connection errors, high CPU/memory utilization
SNS Notifications: Alarms publish messages to SNS topics, which then notify operations teams via email, Slack, or other integrated services.
🔒 Security Considerations
IAM Least Privilege: All AWS services operate with the minimum necessary IAM permissions.
Network Isolation: Application and database tiers reside in private subnets, not directly accessible from the internet.
Security Groups & NACLs: Granular traffic control at the instance and subnet levels.
Container Security: Trivy scanning during CI/CD and ECR's native scanning ensure container images are free of known vulnerabilities.
Code Quality: SonarQube helps identify and remediate security vulnerabilities within the application code itself.
👋 Contributing
Contributions are welcome! Please fork the repository and submit a pull request with your improvements.
