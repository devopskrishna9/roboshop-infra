module "vpc" {
  source = "github.com/devopskrishna9/tf-module-vpc"
  env = var.env
  default_vpc_id = var.default_vpc_id

  for_each = var.vpc
  cidr_block = each.value.cidr_block
  public_subnets = each.value.public_subnets
  private_subnets = each.value.private_subnets
  availability_zone = each.value.availability_zone
}

module "docdb" {
  source = "github.com/devopskrishna9/tf-module-docdb"
  env = var.env

  for_each = var.docdb
  subnet_ids = lookup(lookup(lookup(lookup(module.vpc, each.value.vpc_name, null), "private_subnet_ids", null), each.value.subnets_name, null), "subnet_ids", null)
  vpc_id = lookup(lookup(module.vpc, each.value.vpc_name, null), "vpc_id", null)
  allow_cidr = lookup(lookup(lookup(lookup(var.vpc, each.value.vpc_name, null), "private_subnets", null), "app",null), "cidr_block", null)
  engine_version = each.value.engine_version
  number_of_instances = each.value.number_of_instances
  instance_class = each.value.instance_class
}

module "rds" {
  source = "github.com/devopskrishna9/tf-module-rds"
  env = var.env

  for_each = var.rds
  subnet_ids = lookup(lookup(lookup(lookup(module.vpc, each.value.vpc_name, null), "private_subnet_ids", null), each.value.subnets_name, null), "subnet_ids", null)
  vpc_id = lookup(lookup(module.vpc, each.value.vpc_name, null), "vpc_id", null)
  allow_cidr = lookup(lookup(lookup(lookup(var.vpc, each.value.vpc_name, null), "private_subnets", null), "app",null), "cidr_block", null)
  engine = each.value.engine
  engine_version = each.value.engine_version
  number_of_instances = each.value.number_of_instances
  instance_class = each.value.instance_class
}

#module "elasticache" {
#  source = "github.com/devopskrishna9/tf-module-elasticache"
#  env = var.env
#
#  for_each = var.elasticache
#  subnet_ids = lookup(lookup(lookup(lookup(module.vpc, each.value.vpc_name, null), "private_subnet_ids", null), each.value.subnets_name, null), "subnet_ids", null)
#  vpc_id = lookup(lookup(module.vpc, each.value.vpc_name, null), "vpc_id", null)
#  allow_cidr = lookup(lookup(lookup(lookup(var.vpc, each.value.vpc_name, null), "private_subnets", null), "app",null), "cidr_block", null)
#  node_type = each.value.node_type
#  num_node_groups = each.value.num_node_groups
#  replicas_per_node_group = each.value.replicas_per_node_group
#}

module "rabbitmq" {
  source = "github.com/devopskrishna9/tf-module-rabbitmq"
  env = var.env

  for_each = var.rabbitmq
  subnet_ids = lookup(lookup(lookup(lookup(module.vpc, each.value.vpc_name, null), "private_subnet_ids", null), each.value.subnets_name, null), "subnet_ids", null)
  vpc_id = lookup(lookup(module.vpc, each.value.vpc_name, null), "vpc_id", null)
  allow_cidr = lookup(lookup(lookup(lookup(var.vpc, each.value.vpc_name, null), "private_subnets", null), "app",null), "cidr_block", null)
  engine_type = each.value.engine_type
  engine_version = each.value.engine_version
  host_instance_type = each.value.host_instance_type
  deployment_mode = each.value.deployment_mode
}

module "alb" {
  source = "github.com/devopskrishna9/tf-module-alb"
  env = var.env

  for_each = var.alb
  subnet_ids = lookup(lookup(lookup(lookup(module.vpc, each.value.vpc_name, null), each.value.subnets_type, null), each.value.subnets_name, null), "subnet_ids", null)
  vpc_id = lookup(lookup(module.vpc, each.value.vpc_name, null), "vpc_id", null)
  allow_cidr = lookup(lookup(lookup(lookup(var.vpc, each.value.vpc_name, null), "private_subnets", null), "app",null), "cidr_block", null)
  subnets_name = each.value.subnets_name
  subnets_type = each.value.subnets_type
  internal = each.value.internal
}
output "vpc" {
  value = module.vpc
}


