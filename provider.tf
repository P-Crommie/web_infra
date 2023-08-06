terraform {
  required_providers {

    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket         = "proj-tfstate"
    key            = "webinfra/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform"
  }
}

provider "aws" {
  region = var.project_region
  default_tags {
    tags = merge(
      var.tags,
      {
        workspace = "${terraform.workspace}"
        project   = "${var.project}"
      },
    )
  }
}
