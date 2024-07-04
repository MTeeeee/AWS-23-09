import json
import boto3
from datetime import datetime

client = boto3.client('dynamodb')
dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table('S3-Uploads')
tableName = 'S3-Uploads'


def lambda_handler(event, context):
    
    
    # print(event["Records"]["s3"]["object"]["key"])
    print(event["Records"][0]["s3"]["object"]["key"])
    # TODO implement
    
    dummy_eintrag = event["Records"][0]["s3"]["object"]["key"]
    dummy_time = datetime.now().strftime('%Y-%m-%d-%H-%M-%S')
    
    # requestJSON = json.loads(event['body'])
    
    table.put_item(
        Item={
            'Time': dummy_time,
            'Name': dummy_eintrag
        }
        )
    
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
