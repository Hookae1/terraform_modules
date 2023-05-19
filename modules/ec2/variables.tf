### =================================== ###
###           Global variables          ###
### =================================== ###
variable "region_id" {
  description = "Region"
  type        = string
}

variable "env_id" {
  description = "Uniqe Id of the environtment used for names and tags"
  type        = string
}

variable "project_id" {
  description = "Uniqe Id of the project used for names and tags"
  type        = string
}

variable "maintainer" {
  description = "Email of Person Responsible for Project Infrastructure"
  type        = string
}

### =================================== ###
###     Specific variable for module    ###
### =================================== ###
variable "app_name" {
  description = "Name of application"
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ec2_public_ssh_key" {
  description = "Public ssh key to use with EC2"
  type        = string
}

variable "ec2_default_ami" {
  description = "Default Ubuntu AMI to setup EC2"
  type        = string
}

variable "ec2_cpu_credits" {
  description = "CPU credits for EC2 instances"
  type        = string
  default     = "unlimited"
}

### =================================== ###
###          Inherited variables        ###
### =================================== ###

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_subnets" {
  description = "List of IDs of private subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of IDs of public subnets"
  type        = list(string)
}

variable "database_subnets" {
  description = "List of IDs of database subnets"
  type        = list(string)
}

variable "elasticache_subnets" {
  description = "List of IDs of elasticache subnets"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "List of IDs of elasticache subnets"
  type        = list(string)
}