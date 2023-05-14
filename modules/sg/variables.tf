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

variable "ssh_trusted_ips" {
  description = "Allowed IPs for security and managment"
  type        = map(any)
  default     = { COAX-Office = ["93.175.203.171/32"], COAX-VPN = ["157.245.67.12/32"] }
}
variable "mon_trusted_ips" {
  description = "Monitoring Servers IPs"
  type        = map(any)
  default     = { COAX-Prom = ["165.22.93.23/32"] }
}
