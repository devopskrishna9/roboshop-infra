env = "dev"
default_vpc_id = "vpc-072c42e4347721029"

vpc = {
  main = {
     cidr_block = "10.0.0.0/16"
  }
}

subnets = {
  public = {
    name = "public"
    vpc_name = "main"
    cidr_block = ["10.0.0.0/24", "10.0.1.0/24"]
    availability_zone = ["us-east-1a", "us-east-1b"]
  }
  app = {

  }
  web = {

  }
  db = {

  }
}