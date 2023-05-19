module "ec2" {
  # https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.5.0"
  create = true

  name                        = "${local.pre-fix}-${var.app_name}"
  ami                         = var.ec2_default_ami #https://cloud-images.ubuntu.com/locator/ec2/ Jammy Jellyfish - Ubuntu 22.04 - arm64
  instance_type               = var.ec2_instance_type
  cpu_credits                 = var.ec2_cpu_credits
  subnet_id                   = var.public_subnets #data.aws_subnets.selected_public.ids[0]
  vpc_security_group_ids      = var.vpc_security_group_ids #[data.aws_security_group.ssh.id, data.aws_security_group.web.id, data.aws_security_group.mon.id, data.aws_security_group.data.id]
  associate_public_ip_address = true
  ebs_optimized               = false
  iam_instance_profile        = data.aws_iam_instance_profile.iam_profile.name
  key_name                    = aws_key_pair.ec2.key_name
  user_data                   = null
  disable_api_termination     = false
  monitoring                  = false
  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 30
    }
  ]
}
