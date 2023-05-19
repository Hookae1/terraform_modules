output "vpc_id" {
  description           = "The ID of the VPC"
  value                 = try(module.vpc.vpc_id[0], "")
}

output "public_subnets" {
    description         = "List of IDs of public subnets"
    value               = module.vpc.public_subnets[0].id     
}

output "private_subnets" {
    description         = "List of IDs of private subnets"
    value               = module.vpc.private_subnets.ids   
}

output "database_subnets" {
    desctiption         = "List of IDs of database subnets"
    value               = module.vpc.database_subnets.ids     
}

output "elasticache_subnets" {
    description         = "List of IDs of elasticache subnets"
    value               = module.vpc.elasticache_subnets.ids    
}