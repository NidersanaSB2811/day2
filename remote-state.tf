terraform {
  backend "s3" {
    bucket = "vpc2-state-bucket"
    key    = "state1"
    region = "us-east-1"
  }
}
