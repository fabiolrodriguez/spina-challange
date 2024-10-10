provider "aws" {
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-spina"
    key    = "terraform-state.tfstate"
    region = "us-east-1"
  }
}