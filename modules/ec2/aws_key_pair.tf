resource "aws_key_pair" "ec2" {
  key_name   = local.pre-fix
  public_key = var.ec2_public_ssh_key
}
