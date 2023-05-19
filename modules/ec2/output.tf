output "public_ip" {
    description = "Elastic IP of EC2 server"
    value       = aws_eip.ec2.public_ip
}
