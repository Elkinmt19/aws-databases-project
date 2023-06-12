import boto3
import json
import base64
from botocore.config import Config

def lambda_handler(event, context):
    timestream_client = boto3.client(
        'timestream-write', 
        config=Config(
            read_timeout=20, 
            max_pool_connections = 5000, 
            retries={'max_attempts': 10}
        )
    )
    
    for record in event['Records']:
        # Extract the data from the Kinesis record
        payload = base64.b64decode(record['kinesis']['data']).decode('utf-8')
        data = json.loads(payload)
        print(data)
        
        # Prepare the data for Timestream insertion
        # dimensions = [
        #     {'Name': 'sensor', 'Value': data['sensor']},
        #     {'Name': 'location', 'Value': data['location']}
        # ]
        # measures = [
        #     {'Name': 'temperature', 'Value': str(data['temperature']), 'Unit': 'C'},
        #     {'Name': 'humidity', 'Value': str(data['humidity']), 'Unit': 'percent'}
        # ]
        
        # # Write data to Timestream
        # timestream_client.write_records(
        #     DatabaseName='your-database-name',
        #     TableName='your-table-name',
        #     Records=[
        #         {
        #             'Dimensions': dimensions,
        #             'MeasureName': measure['Name'],
        #             'MeasureValue': measure['Value'],
        #             'MeasureValueType': 'DOUBLE',
        #             'Time': str(data['timestamp'])
        #         }
        #         for measure in measures
        #     ]
        # )
    
    return {
        'statusCode': 200,
        'body': 'Data inserted into Timestream successfully.'
    }
