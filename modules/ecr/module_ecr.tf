module "ecr" {
  # https://registry.terraform.io/modules/terraform-aws-modules/ecr/aws/latest
  source  = "terraform-aws-modules/ecr/aws"
  version = "1.6.0"

  create = true

  for_each = toset(local.app_ids)

  repository_name                 = "${local.pre-fix}-${each.key}"
  repository_type                 = "private"
  repository_force_delete         = false       # true for test env
  repository_image_tag_mutability = "IMMUTABLE" # "MUTABLE"
  repository_image_scan_on_push   = true
  registry_scan_type              = "BASIC"

  #repository_read_write_access_arns = ["arn:aws:iam::012345678901:role/terraform"]
  create_lifecycle_policy = true
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "untagged",
          #tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })


  tags = {
    Role = "DockerImageRegistry"
  }
}
