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
variable "app" {
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
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1EaEgOnBfCNxJhFAISKghB1TfrD6IyencZYNesm4dhrxCuOXr5ZYPAIpZWNrOMnB7kkBuGaT9KcG4y/lc9iKGMla+bnXMAU3QUz+U7TLhZATu94NYZLkoqFJgh2TXWFj+XLeLMX2tIM+NSu/qL6W12EzzR+Fb5dCHrVMHPurHCQarnm7vLC+qTCk+kEYxeoPiEcSx9dJ034nCekOYk/QbTl44XvliPr7Qpztw4DKR2tc6iYASgN3sVXHotK/7c1zk8pwI8Pf+B/mDTn0Jl8ylnfaHWHuxoCLXbwWmZozg68kqNS5a3IYsgNsaV1FC14UtJ46U36BOcM3dVgIo67nLvHohzmC45pf5zkXKtpWcGrDROdkF6VRJTJ5LcOzy3i0r8QezKb7MZSbj5uT8fGWUUVtKg3nwWqBKczSbyoYkYC19WJ1yGacavZAf9s8lSudRxwiAiia49Z3VQvBEWiGSB7bQHJ4dMM/6Ysx/G4Yrs1k2fdgJMLgXmU1L8vO32A3HVctT12zexzmrwIEfx/+sDfNu1pttbWwnulg4oUSpDSg+vaNlsQHmt2xrIDA+kBxTFCcwjrFjWgKsrgXJbIwORguaovy71wBfqWJkUfppn574NoTzxAEyuBHsGcFZvAzpcYOwxL43YzYOzM/D0KNIFr5zetJk+JDAbAHydbOhyw== yurii.rybitskyi@coaxsoft.com"
}

variable "ec2_default_ami" {
  description = "Default Ubuntu AMI to setup EC2"
  type        = string
  default     = "ami-086c7bb4748b92860"
}

variable "ec2_cpu_credits" {
  description = "CPU credits for EC2 instances"
  type        = string
  default     = "unlimited"
}