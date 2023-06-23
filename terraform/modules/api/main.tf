module "api_gateway" {
  source            = "../../resources/api"
  name              = var.name
  function_name     = var.function_name
  lambda_invoke_arn = var.lambda_invoke_arn
}
