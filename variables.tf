variable aws_region {
    default = "us-east-1"
}
variable AZs {
    default = ["us-east-1a", "us-east-1b"]
}

variable awscli_creds {
    default = ["~/.aws/credentials"]
}

variable app_name {
    default = "Web-App"
}