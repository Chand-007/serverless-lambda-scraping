provider "aws" {
  region = var.aws_region
}


resource "aws_sns_topic" "web_scraping_notifications" {
  name = "WebScrapingCompletion"
}


resource "aws_lambda_function" "scraping_lambda" {
  function_name = "webScrapingLambda"
  runtime       = "python3.8"
  handler       = "scraping_function.lambda_handler"
  role          = aws_iam_role.lambda_exec_role.arn
  filename      = "lambda-function.zip"  

  environment {
    variables = {
      SNS_TOPIC_ARN = aws_sns_topic.web_scraping_notifications.arn
    }
  }
}


resource "aws_cloudwatch_event_rule" "scraping_schedule" {
  name                = "scraping-schedule"
  schedule_expression = "rate(1 hour)"
}


resource "aws_cloudwatch_event_target" "scraping_lambda_target" {
  rule      = aws_cloudwatch_event_rule.scraping_schedule.name
  arn       = aws_lambda_function.scraping_lambda.arn
  input     = "{}"
}


resource "aws_lambda_permission" "allow_cloudwatch_invoke" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.scraping_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.scraping_schedule.arn
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.web_scraping_notifications.arn
  protocol  = "email"
  endpoint  = "<email>"  # Replace with the desired email address
}

output "lambda_function_arn" {
  value = aws_lambda_function.scraping_lambda.arn
}

output "sns_topic_arn" {
  value = aws_sns_topic.web_scraping_notifications.arn
}
