output "region" {
  value = var.region
}

output "cluster_name" {
  value = module.eks.cluster_id
}

output "ecr_repository" {
  value = aws_ecr_repository.this.repository_url
}

output "db_username" {
  value = module.db.db_instance_username
  sensitive = true
}

output "db_password" {
  value = module.db.db_instance_password
  sensitive = true
}

output "db_host" {
  value = module.db.db_instance_endpoint
  sensitive = true
}
