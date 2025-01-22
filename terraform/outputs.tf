output "lambda_function_arn" {
  value = aws_lambda_function.scraping_lambda.arn
}

output "sns_topic_arn" {
  value = aws_sns_topic.web_scraping_notifications.arn
}
