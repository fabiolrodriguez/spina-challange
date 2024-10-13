output "db_endpoint" {
  value = aws_db_instance.postgres.endpoint
  description = "The connection endpoint for the RDS database instance."
}

output "ecr_repository_url" {
  value = module.service.ecr_repository_url
  description = "The URL of the ECR repository."
}
