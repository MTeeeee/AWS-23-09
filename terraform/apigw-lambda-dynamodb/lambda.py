import json
import boto3

client = boto3.client('dynamodb')
dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table('tf-db')
tableName = 'tf-db'

def lambda_handler(event, context):

    dummy_id = "2"
    dummy_eintrag = "Hello"
    
    table.put_item(
        Item={
            'id': dummy_id,
            'name': dummy_eintrag
        }
        )
    
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
