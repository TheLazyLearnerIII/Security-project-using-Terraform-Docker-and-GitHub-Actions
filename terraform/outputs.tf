output "instance_public_ip" {
    value = aws_instance.web.public_ip
    description = "Public IP of the EC2 instance"
}
output "instance_id" {
    value = aws_instance.web.id
    description = "ID of the created EC2 instance"
}
output "iam_role_name" {
  value       = aws_iam_role.ssm_read_role.name
  description = "IAM role name for SSM access"
}