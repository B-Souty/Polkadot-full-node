terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.13.6"
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}
