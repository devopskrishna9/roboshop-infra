#resource "null_resource" "test" {
#  provisioner "local-exec" {
#    command = "echo ${var.env}"
#  }
#}

module "vpc" {
  source = "github.com/devopskrishna9/tf-module-vpc"
  env = var.env
  default_vpc_id = var.default_vpc_id

  for_each = var.vpc
  cidr_block = each.value.cidr_block
}


module "subnets" {
  source = "github.com/devopskrishna9/tf-module-subnets"
  env = var.env
  default_vpc_id = var.default_vpc_id
  vpc_id = module.network.vpc_id

  for_each = var.vpc
  cidr_block = each.value.cidr_block
}

