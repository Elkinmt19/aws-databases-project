import os
import boto3
import json
import base64
from datetime import datetime
from botocore.config import Config

TIMESTREAM_DB_NAME = os.environ.get("TIMESTREAM_DB_NAME")
TIMESTREAM_TABLE_NAME = os.environ.get("TIMESTREAM_TABLE_NAME")

def lambda_handler(event:dict, context:object):
    """AWS Lambda function handler.

    This function serves as the entry point for the AWS Lambda function.
    It receives an event and a context object as parameters.

    Args:
        event (dict): The event data passed to the Lambda function.
        context (LambdaContext): The context object representing the runtime information.

    Returns:
        dict: The result of the Lambda function execution.
    """
    timestream_client = boto3.client(
        "timestream-write", 
        config=Config(
            read_timeout=20, 
            max_pool_connections = 5000, 
            retries={"max_attempts": 10}
        )
    )
    
    for record in event["Records"]:
        payload = base64.b64decode(record["kinesis"]["data"]).decode("utf-8")
        data = json.loads(payload)
        print(f"Inserting {data}")

        dimensions = [
            {"Name": "player_name", "Value": data["player_name"]},
        ]
        measures = [
            {"Name": "minutes_played", "Value": str(data["minutes_played"]), "Unit": "m"}, 
            {"Name": "goals", "Value": str(data["goals"]), "Unit": "goals"}, 
            {"Name": "assists", "Value": str(data["assists"]), "Unit": "assists"}, 
            {"Name": "shots", "Value": str(data["shots"]), "Unit": "shots"}, 
            {"Name": "passes_completed", "Value": str(data["passes_completed"]), "Unit": "passes"}, 
            {"Name": "pass_accuracy", "Value": str(data["pass_accuracy"]), "Unit": "%"}, 
            {"Name": "key_passes", "Value": str(data["key_passes"]), "Unit": "passes"}, 
            {"Name": "crosses", "Value": str(data["crosses"]), "Unit": "crosses"}, 
            {"Name": "dribbles_completed", "Value": str(data["dribbles_completed"]), "Unit": "dribbles"}, 
            {"Name": "tackles", "Value": str(data["tackles"]), "Unit": "tackles"}, 
            {"Name": "interceptions", "Value": str(data["interceptions"]), "Unit": "interceptions"}, 
            {"Name": "clearances", "Value": str(data["clearances"]), "Unit": "clearances"}, 
            {"Name": "blocked_shots", "Value": str(data["blocked_shots"]), "Unit": "shots"}, 
            {"Name": "fouls_committed", "Value": str(data["fouls_committed"]), "Unit": "fouls"}, 
            {"Name": "fouls_suffered", "Value": str(data["fouls_suffered"]), "Unit": "fouls"}, 
            {"Name": "offsides", "Value": str(data["offsides"]), "Unit": "offsides"}, 
            {"Name": "touches", "Value": str(data["touches"]), "Unit": "touches"}, 
            {"Name": "duels_won", "Value": str(data["duels_won"]), "Unit": "duels"}, 
            {"Name": "aerial_duels_won", "Value": str(data["aerial_duels_won"]), "Unit": "duels"}, 
            {"Name": "recoveries", "Value": str(data["recoveries"]), "Unit": "recoveries"}, 
            {"Name": "fouls_drawn", "Value": str(data["fouls_drawn"]), "Unit": "fouls"}, 
        ]

        timestream_client.write_records(
            DatabaseName=TIMESTREAM_DB_NAME,
            TableName=TIMESTREAM_TABLE_NAME,
            Records=[
                {
                    "Dimensions": dimensions,
                    "MeasureName": measure["Name"],
                    "MeasureValue": measure["Value"],
                    "MeasureValueType": "DOUBLE",
                    "Time": str(int(datetime.strptime(
                        data["timestamp"], 
                        "%Y-%m-%d %H:%M:%S.%f"
                    ).timestamp()*1000)),
                    "TimeUnit": "MILLISECONDS",
                }
                for measure in measures
            ]
        )
    
    return {
        "statusCode": 200,
        "body": "Data inserted into Timestream successfully."
    }
