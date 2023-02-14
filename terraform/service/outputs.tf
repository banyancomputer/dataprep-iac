/* Ec2 Outputs */

# DNS name for the Ec2 instance
output "ec2_public_dns" {
  description = "The public DNS name of the EC2 instance"
  value       = aws_eip.ec2.public_dns
  depends_on  = [aws_eip.ec2]
}
# Private Key for the EC2 instance. This is also saved to the local file system
output "ec2_pem_key" {
  description = "The private key of the EC2 instance"
  value       = tls_private_key.ec2.private_key_pem
  depends_on  = [tls_private_key.ec2]
  sensitive   = true
}
# The path to the private key of the EC2 instance on the local machine
output "ec2_pem_path" {
  description = "The path to the private key of the EC2 instance on the local machine"
  value       = null_resource.ec2-key-write.triggers.key_file_path
  depends_on = [tls_private_key.ec2]
}