resource "aws_eip" "ec2" {
  count    = 1
  instance = module.ec2.id
  vpc      = true
  depends_on = [
    module.ec2
  ]
}
