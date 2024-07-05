resource "aws_apigatewayv2_api" "tf-api" {
  name          = "tf-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_route" "post_route" {
  api_id    = aws_apigatewayv2_api.tf-api.id
  route_key = "POST /post"
  target = "integrations/${aws_apigatewayv2_integration.post_lambda.id}"
}

resource "aws_apigatewayv2_integration" "post_lambda" {
  api_id           = aws_apigatewayv2_api.tf-api.id
  integration_type = "AWS_PROXY"

  integration_method = "POST"
  integration_uri = aws_lambda_function.test_lambda.invoke_arn
}

resource "aws_apigatewayv2_stage" "tf-api-stage" {
  api_id = aws_apigatewayv2_api.tf-api.id
  name   = "$default"
  auto_deploy = "true"
}


