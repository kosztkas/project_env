Project environment via Infrastructure as Code
===

This is a Terraform configuration which creates multiple sets of virtual machines for a sandbox.
With the default configuration it creates 3 EC2 instances for each of the 7 groups (which makes 21 instances in total) with size `t3a.small` and using the Ubuntu 22.04LTS x86 image

The instances will be tagged with a Name tag, with a value of `group[1-7]-vm[1-3]` and a Group tag, with the value `group[1-7]`

The ssh keypairs used should be available in AWS and named like `group[1-7]-key`

Usage
-----
You can use this with the following steps:

### Necessary setup

1. Setting values for the following in the variables.tf file or through the environment variables:
    - AWS_ACCESS_KEY
    - AWS_SECRET_KEY
    - the VPC ID
    - the subnet ID
    - the security group ID
    
### Optional modifications

2. Modify the setup:
    - the list of groups
    - the list of VM's
    - AMI ID, EC2 instance family / size, etc, go wild

Modifying the configuration like in the following example will create 2 instances for 3 groups, 6 in total.

```
variable "vm_suffix" {
  description = "List of VMs to be created, also the second part of their names"
  default     = [ "vm1", "vm2"]
}


variable "group_names" {
  description = "List of group names"
  default     = ["group1", "group2", "group3"]
}
```

### RUN(!)
3.  Use terraform and create what we have configured

First we have to initialize terraform backend and download/install the provider
```console
foo@bar:~/project_env$ ls
main.tf  outputs.tf  variables.tf

foo@bar:~/project_env$ terraform init
```
Then just to be sure run `plan`, let us preview what actions are we planning to take, optionally we can also export this plan so we can apply exactly that later with the option `-out envplan`
```console
foo@bar:~/project_env$ terraform plan
```
After this if we're satisfied with our plan, we can go ahead and apply it, optionally if we saved our plan previously we can use that, just put it after the apply like `terraform apply envplan`
```console
foo@bar:~/project_env$ terraform apply
```
    
Authors
-------
Created and hopefully maintained by Sandor Kosztka (@kosztkas)

Reference
---------
* [Terraform documentation](https://developer.hashicorp.com/terraform/docs)
* [Terraform flatten function](https://developer.hashicorp.com/terraform/language/functions/flatten)
* [Terraform distinct function](https://developer.hashicorp.com/terraform/language/functions/distinct)
* [Terraform for_each](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)
* [nested loops magic](https://www.daveperrett.com/articles/2021/08/19/nested-for-each-with-terraform/) - found on 2022/11/14
