terraform {
  backend "s3" {
    region         = "us-west-1"
    bucket         = "hadrian-project-terraform-state-bucket"
    dynamodb_table = "terraform-state-lock"
    key            = "terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.2"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.5"
    }
  }
  required_version = "~> 1.9.4"
}

provider "aws" {
  region = "us-west-1"
}