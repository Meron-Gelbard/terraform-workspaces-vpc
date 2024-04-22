locals {

  subnet_count = "${terraform.workspace == "TESTING" ? 4 : 1}"
  workspace_confs = {
    dev = {
      instance_type = "t2.micro"
      instance_count = 2
      region        = "us-east-1"
      subnet_count = 2
    }
    prod = {
      instance_type = "t2.large"
      instance_count = 4
      region        = "us-west-2"
      subnet_count = 4
    }
  }
  current_config = "${terraform.workspace == "prod" ? workspace_confs.prod : workspace_confs.dev}"
}