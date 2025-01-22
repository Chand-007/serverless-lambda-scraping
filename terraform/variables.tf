variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
  default     = "webScrapingLambda"
}
