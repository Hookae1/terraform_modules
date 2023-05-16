### =================================== ###
###          General variables          ###
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

variable "admin_team" {
  description = "List of users with Admin Privileges"
  type        = list(any)
  default     = []
}
variable "dev_power_team" {
  description = "List of users with Power Development Privileges"
  type        = list(any)
  default     = []
}
variable "dev_minimal_team" {
  description = "List of users with Minial Development Privileges"
  type        = list(any)
  default     = []
}
variable "readonly_team" {
  description = "List of users with Read Only Privileges"
  type        = list(any)
  default     = []
}