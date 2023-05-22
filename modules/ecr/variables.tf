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

variable "app_ids" {
  description = "APP ids"
  type        = list(string)
  default     = ["fe", "be"]
}