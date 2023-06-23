resource "aws_lambda_function" "lambda_function" {
  function_name = var.function_name
  timeout       = 15
  image_uri     = "${var.image_url}:latest"
  package_type  = "Image"
  memory_size   = 2048

  role = aws_iam_role.function_role.arn
  environment {
    variables = {
      "JOBLIB_MULTIPROCESSING" : 0
    }
  }
}

resource "aws_iam_role" "function_role" {
  name = var.function_name

  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}
