# Spring project deployed to EKS

## Description and status

You have a microservice you would like to roll out within an EKS cluster. This service should
- Be publicly accessible (NO TLS)
- Have access to AWS resources such as S3, RDS, ..
- Please provide ‘Infrastructure as Code’-scripts to setup an EKS cluster with 
  - a. A Load balancer
  - b. TLS Termination at the load balancer (NOT DONE)
  - c. EC2 instances for the node group
  - d. An RDS instance
  - e. Setup the toy Java Spring-Project https://github.com/spring-projects/spring-petclinic which should utilize the RDS and provisioned secrets
- The scripts should be runnable on a CLI as well as be integrable into a delivery
pipeline

Please provide some documentation on how to run them

## Approach

- Have infrastructure as code with terraform
- Build and push image to ECR with skaffold
- Deploy image to a cluster with skaffold

## How to run

- Prepare your AWS credentials with `aws configure`
- Run `./init.sh`
