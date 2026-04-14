terraform {
  backend "s3" {
    bucket  = "terraform-state-cjj"
    key     = "jenkins-test-041326.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-2"
}
