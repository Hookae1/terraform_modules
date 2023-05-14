resource "aws_iam_instance_profile" "ec2" {
  name = "${local.pre-fix}-EC2InstanceProfile"
  role = aws_iam_role.ec2.name
}
