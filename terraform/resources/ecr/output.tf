output "repository_arn" {
  value = aws_ecr_repository.repository.arn
}

output "repository_url" {
  value = aws_ecr_repository.repository.repository_url
}
