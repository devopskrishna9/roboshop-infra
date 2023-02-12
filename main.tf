resource "null_resource" "test" {
  provisioner "local-exec" {
    command = "echo ${var.env}"
  }
}

backend "s3" {
  bucket = "terraform-brk"
  key    = "roboshop-infra/dev/terraform.tfstate"
  region = "us-east-1"
}
