provider "aws" {
  profile = "penny"
  region  = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket  = "penny-bucket-4550-0700-7237"
    key     = "COC/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = "true"
    profile = "penny"
  }
}

