import os
import boto3
import requests
from bs4 import BeautifulSoup

sns_client = boto3.client('sns')
sns_topic_arn = os.environ['SNS_TOPIC_ARN']

def lambda_handler(event, context):
    # Example scraping of a website (replace with actual logic)
    url = <url of website>
    response = requests.get(url)
    
    # Check if the request was successful
    if response.status_code == 200:
        soup = BeautifulSoup(response.content, 'html.parser')
        title = soup.title.string
        print(f"Scraped Title: {title}")
        
        # Send SNS notification on success
        message = f"Scraped data successfully from {url}. Title: {title}"
        sns_client.publish(TopicArn=sns_topic_arn, Message=message, Subject='Web Scraping Complete')
        return {
            'statusCode': 200,
            'body': f'Successfully scraped: {title}'
        }
    else:
        error_message = f"Failed to scrape {url}. Status Code: {response.status_code}"
        sns_client.publish(TopicArn=sns_topic_arn, Message=error_message, Subject='Web Scraping Failed')
        return {
            'statusCode': 500,
            'body': error_message
        }
