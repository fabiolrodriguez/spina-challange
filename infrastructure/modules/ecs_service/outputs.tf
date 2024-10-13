output "service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.test.name
}

output "service_id" {
  description = "The ARN of the ECS service"
  value       = aws_ecs_service.test.id
}

output target_group_arn {
  value = aws_lb_target_group.test.arn
}

output security_group{
  value = aws_security_group.test.id
}

output "ecr_repository_url" {
  value = aws_ecr_repository.test-repo.repository_url
  description = "The URL of the ECR repository."
}
