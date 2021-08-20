#
# Example providers file.  It assumes your account is in the 'us-gov-west-1'
# region and that your '$HOME/.aws/credentials' file is setup with a profile
# called 'dcaf-automation-team-admin'.  The account and keys associated with
# that profile must have administrator access to the AWS account.
#

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.54.0"
    }

    null = {
      source = "hashicorp/null"
      version = "3.1.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }

    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
  }
}

provider "aws" {
    region  = "us-east-1"
    profile = "daniel-shiplett-site"
}

provider "null" {
}

provider "random" {
}

provider "template" {
}
