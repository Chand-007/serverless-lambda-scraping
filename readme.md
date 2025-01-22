# Web Scraping Lambda with AWS & Terraform


***This project implements a serverless web scraping solution using AWS Lambda, Terraform, and SNS for notifications. The web scraping function runs on an hourly schedule using AWS CloudWatch Events, and notifications about the completion of the scraping process are sent to an email address via SNS.***

## Step-by-Step Guide

### 1. Configure Web Scraping Function
In the lambda/scraping_function.py file, modify the following line to point to the URL you wish to scrape:

URL =   # Replace with the URL to scrape


### 2. Configure Terraform Variables
In the terraform/main.tf file


update the email address in the aws_sns_topic_subscription resource block:

  endpoint  = <email>  # Replace with the desired email address
