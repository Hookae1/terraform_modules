output "public_ip" {
    description = "Elastic IP of EC2 server"
    value       = aws_eip.ec2[0].public_ip
}
