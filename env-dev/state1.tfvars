#bucket = "terraform-brk"
#key    = "roboshop-infra/dev/terraform.tfstate"
#region = "us-east-1"
#
#

terraform {
  backend "s3" {
    bucket = "terraform-brk"
    key    = "roboshop-infra/dev/terraform.tfstate"
    region = "us-east-1"
  }
}

