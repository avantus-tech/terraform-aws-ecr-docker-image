output "repository_url" {
  description = "ECR repository URL of Docker image"
  value       = aws_ecr_repository.repo.repository_url
}

output "tag" {
  description = "Docker image tag"
  value       = local.docker_tag
}

output "hash" {
  description = "Docker image source hash"
  value       = data.external.hash.result["hash"]
}
