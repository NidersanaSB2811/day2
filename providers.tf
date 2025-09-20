terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4" # or latest version
    }
  }

  required_version = ">= 1.2.0"
}

provider "local" {}
