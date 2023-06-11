import os
import json
import time
import random
import boto3
import logging
from faker import Faker
from datetime import datetime

logger = logging.getLogger()
logger.setLevel(logging.INFO)
logger.addHandler(logging.StreamHandler())

fake = Faker()

kds_name=os.getenv("KDS_NAME", default="football_player_stream")
region=os.getenv("AWS_REGION", default="us-east-1")
client_kinesis = boto3.client('kinesis',region_name=region)


def generate_player_performance(
    player_name:str,
    minutes_played:float, 
    last_event:dict
) -> dict:
    """Generate fake data about a football player.

    Use the faker module to generate data about a football player.

    Args:
        player_name (str): Name of the football player.
        minutes_played (float): Minutes played by the football player.
        last_event (dict): Last event generated.

    Returns:
        Single registry generated.
    """
    goals = fake.random_int(
        min=last_event["goals"], max=9
    )
    shots = fake.random_int(
        min=goals if (goals > last_event["shots"]) else last_event["shots"], 
        max=99
    )
    assists = fake.random_int(
        min=last_event["assists"], max=goals
    )

    performance = {
        "id": 'id' + str(random.randint(1665586, 8888888)),
        "player_name": player_name,
        "minutes_played": minutes_played,
        "goals": goals,
        "assists": assists,
        "shots": shots,
        "passes_completed": fake.random_int(
            min=(
                assists if (assists > last_event["passes_completed"]) 
                else last_event["passes_completed"]
            ),
            max=99
        ),
        "pass_accuracy": fake.random_int(min=0, max=99),
        "key_passes": fake.random_int(
            min=(
                assists if (assists > last_event["key_passes"]) 
                else last_event["key_passes"]
            ),
            max=9
        ),
        "crosses": fake.random_int(
            min=last_event["crosses"], max=9
        ),
        "dribbles_completed": fake.random_int(
            min=last_event["dribbles_completed"], max=9
        ),
        "tackles": fake.random_int(
            min=last_event["tackles"], max=9
        ),
        "interceptions": fake.random_int(
            min=last_event["interceptions"], max=9
        ),
        "clearances": fake.random_int(
            min=last_event["clearances"], max=9
        ),
        "blocked_shots": fake.random_int(
            min=last_event["blocked_shots"], max=9
        ),
        "fouls_committed": fake.random_int(
            min=last_event["fouls_committed"], max=9
        ),
        "fouls_suffered": fake.random_int(
            min=last_event["fouls_suffered"], max=9
        ),
        "offsides": fake.random_int(
            min=last_event["offsides"], max=9
        ),
        "touches": fake.random_int(
            min=last_event["touches"], max=99
        ),
        "duels_won": fake.random_int(
            min=last_event["duels_won"], max=99
        ),
        "aerial_duels_won": fake.random_int(
            min=last_event["aerial_duels_won"], max=9
        ),
        "recoveries": fake.random_int(
            min=last_event["recoveries"], max=9
        ),
        "fouls_drawn": fake.random_int(
            min=last_event["fouls_drawn"], max=9
        )
    }
    return performance


def put_kinesis_events(max_minutes:float):
    """Put the football player events to a Kinesis Data Streams.

    Create and put the events into a Kinesis Data Streams.

    Args:
        max_minutes (float): Maximum minutes that the function is going 
            to generate and put events into the Kinesis DataStream.
    """
    if (max_minutes > 10):
        raise ValueError(
            "The maximum amount of time that the function can generate events is 10 minutes."
        )

    player_name = fake.name()

    id = "id" + str(random.randint(1665586, 8888888))

    last_event = {
        "id": id,
        "player_name": player_name,
        "minutes_played": 0,
        "goals": 0,
        "assists": 0,
        "shots": 0,
        "passes_completed": 0,
        "pass_accuracy": 0,
        "key_passes": 0,
        "crosses": 0,
        "dribbles_completed": 0,
        "tackles": 0 ,
        "interceptions": 0,
        "clearances": 0,
        "blocked_shots": 0,
        "fouls_committed": 0 ,
        "fouls_suffered": 0,
        "offsides": 0,
        "touches": 0,
        "duels_won": 0,
        "aerial_duels_won": 0,
        "recoveries": 0,
        "fouls_drawn": 0
    }

    started_datetime = datetime.now()
    frequency = 0.5
    minutes = 0
    i = 0

    try:
        while (minutes <= max_minutes):
            minutes = (datetime.now() - started_datetime).total_seconds()/60
            last_event = generate_player_performance(
                player_name=player_name, 
                minutes_played=minutes,
                last_event=last_event,
            )
            time.sleep(frequency)

            response=client_kinesis.put_record(
                StreamName=kds_name, 
                Data=json.dumps(last_event), 
                PartitionKey=id
            )

            i = i + 1

            logger.info(
                "Total ingested:" + 
                str(i) +
                ",ReqID:" + 
                response['ResponseMetadata']['RequestId'] +
                ",HTTPStatusCode:" + 
                str(response['ResponseMetadata']['HTTPStatusCode'])
            )
    except KeyboardInterrupt:
        logger.warn("The events ingestion process has been stopped.")

def main():
    """Entrypoint of the application."""
    _ = put_kinesis_events(max_minutes=5)


if __name__ == "__main__":
    main()
