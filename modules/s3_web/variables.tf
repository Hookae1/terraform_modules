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
###         Inherited variables         ###
### =================================== ###
variable "app_domain" {
  description = "Domain of FE application"
  type        = string
}
variable "api_domain" {
  description = "Domain of API application"
  type        = string
}
variable "acm_certificate_arn" {
  description = "TLS certificate Arn to use from ACM"
  type        = string
}

variable "s3_logs" {
  description = "S3 bucket for storing logs"
  type        = string 
}
