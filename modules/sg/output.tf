output "sg_ssh" {
    description = "ID of SSH Security groups"
    value       = aws_security_group.ssh.id
}

output "sg_web" {
    description = "ID of WEB Security groups"
    value       = aws_security_group.web.id
}

output "sg_mon" {
    description = "ID of MON Security groups"
    value       = aws_security_group.mon.id
}

output "sg_data" {
    description = "ID of DB Security groups"
    value       = aws_security_group.data.id
}