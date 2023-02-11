module "network" {
  source = "github.com/devopskrishna9/tf-module-vpc"
  env    = var.env

  for_each   = var.vpc
  cidr_block = each.value.cidr_block
}
