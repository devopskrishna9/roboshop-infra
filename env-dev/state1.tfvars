#bucket = "terraform-brk"
#key    = "roboshop-infra/dev/terraform.tfstate"
#region = "us-east-1"
#
#


  backend "s3" {
    bucket = "terraform-brk"
    key    = "roboshop-infra/dev/terraform.tfstate"
    region = "us-east-1"
  }


