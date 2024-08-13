output "arn" {
  description = "arn of kms key"
  value       = aws_kms_key.kms_key.arn
}

output "id" {
  description = "id of kms key"
  value       = aws_kms_key.kms_key.key_id
}

output "policy_id" {
  description = "id of the kms policy"
  value       = aws_iam_policy.kms_access.id
}

output "policy_arn" {
  description = "arn of the kms policy"
  value       = aws_iam_policy.kms_access.arn
}

output "policy_name" {
  description = "name of the kms policy"
  value       = aws_iam_policy.kms_access.name
}

output "policy_document" {
  value = aws_iam_policy.kms_access.policy
}

output "kms_policy_document" {
  value = data.aws_iam_policy_document.kms_policy.json
}
