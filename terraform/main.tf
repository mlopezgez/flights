provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

module "flights_repository" {
  source = "./modules/ecr"
  name   = "flights"
}

module "flights_lambda" {
  source        = "./modules/lambda"
  function_name = "flights"
  image_url     = module.flights_repository.repository_url
}

module "flights_api" {
  source            = "./modules/api"
  name              = "flights"
  function_name     = "flights"
  lambda_invoke_arn = module.flights_lambda.lambda_invoke_arn
}
