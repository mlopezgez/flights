provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

module "flights-repository" {
  source = "./modules/ecr"
  name   = "flights"
}
