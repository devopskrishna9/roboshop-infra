#resource "null_resource" "test" {
#  provisioner "local-exec" {
#    command = "echo ${var.env}"
#  }
#}

module "network" {
  source = "github.com/devopskrishna9/tf-module-vpc"
  for_each = var.vpc
  cidr_block = each.value.cidr_block

}
