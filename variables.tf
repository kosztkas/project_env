variable "aws_access_key" {
  description = "AWS access key"
  default     = ""
}

variable "aws_secret_key" {
  description = "AWS secret key"
  default     = ""
}

variable "aws_region" {
  description = "This is the selected AWS region."
  default     = "eu-central-1"
}

variable "ami_id" {
  description = "AMI ID, Ubuntu 22.04 LTS x86 in this case"
  default     = "ami-0caef02b518350c8b"
}

variable "instance_type" {
  description = "Instance family.size to be deployed"
  default     = "t3a.small"
}

variable "subnet-id" {
  description = "The Sunbnet ID in which we create the instances"
  default     = "subnet-12345678987654321"
}

variable "vpc-id" {
  description = "The VPC ID where the subnet is"
  default     = "vpc-12345678987654321"
}

variable "security-group-id" {
  description = "Security group id"
  default     = "sg-12345678987654321"
}

# NOTE the total number of VMs will be group_names × vm_suffix
# e.g. 7 groups × 3 vm --> 21 VM total
variable "vm_suffix" {
  description = "List of VMs to be created, also the second part of their names"
  default     = [ "vm1", "vm2", "vm3"]
}


variable "group_names" {
  description = "List of group names"
  default     = ["group1", "group2", "group3", "group4", "group5", "group6", "group7"]
}
