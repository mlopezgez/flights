module "lambda_function" {
    source = "../../resources/lambda"
    image_url = var.image_url
    function_name = var.function_name
}