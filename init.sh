#!/usr/bin/env bash
set -e

check_binary_available () {
  if ! command -v "$1"  &> /dev/null
  then
      echo "command not found: $1"
      exit
  fi
}

check_binary_available git
if [ ! -d "code" ]; then
  printf "Clonning the repo\n"
  git clone https://github.com/spring-projects/spring-petclinic code
else
  cd code && git pull && cd ..
fi

printf "Applying terraform\n"
check_binary_available terraform
cd terraform || exit
terraform init
terraform apply

# ECR_REPOSITORY_URL=$(cd terraform && terraform output -raw ecr_repository)
CURRENT_AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" | tr -d '"')
AWS_REGION=$(terraform output -raw region)
CLUSTER_NAME=$(terraform output -raw cluster_name)
DB_USER=$(terraform output -raw db_username)
DB_PASSWORD=$(terraform output -raw db_password)
DB_HOST=$(terraform output -raw db_host)

printf "Apply secrets and env variables to a cluster"
check_binary_available kubectl

aws eks --region "$AWS_REGION" update-kubeconfig --name "$CLUSTER_NAME"
kubectl create secret generic database \
  --from-literal=host="$DB_HOST" \
  --from-literal=username="$DB_USER" \
  --from-literal=password="$DB_PASSWORD"

printf "Building and deploying the project\n"
check_binary_available skaffold
cd .. 
aws ecr get-login-password --region "${AWS_REGION}" | docker login --username AWS --password-stdin "${CURRENT_AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
skaffold run --default-repo "${CURRENT_AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

printf "Done, you can access an app at\n"
kubectl get services
