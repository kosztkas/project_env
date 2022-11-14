terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.39.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

locals {
  group_names = var.group_names
  vms         = var.vm_suffix

  # Nested loop over both lists, and flatten the result.
  vm_names = distinct(flatten([
    for groupnames in local.group_names : [
      for vm in local.vms : {
        groupname = groupnames
        vm        = vm
      }
    ]
  ]))
}

resource "aws_instance" "instances" {
  for_each                    = { for entry in local.vm_names: "${entry.groupname}.${entry.vm}" => entry }
  instance_type               = var.instance_type
  ami                         = var.ami_id
  key_name                    = "${each.value.groupname}-key"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [ var.security-group-id ]
  subnet_id                   = var.subnet-id
  
  root_block_device {
    volume_size = 20
  }

  tags = {
    Name  = "${each.value.groupname}-${each.value.vm}"
    Group = each.value.groupname
  }
}
