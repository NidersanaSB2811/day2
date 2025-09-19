# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "genai_bucket"
    key    = "genai.tfstate"
    region = "us-east-1"
  }
}
