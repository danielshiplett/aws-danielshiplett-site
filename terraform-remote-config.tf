terraform {
  backend "s3" {
    encrypt = "true"
    profile = "daniel-shiplett-site"
    bucket  = "terraform-backend-188529814778"
    key     = "site/terraform.tfstate"
    region  = "us-east-1"
  }
}
