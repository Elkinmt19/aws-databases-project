"Entry point of the application."
from fastapi import FastAPI, HTTPException
from realtime_data_producer import put_kinesis_events

app = FastAPI(
    title="Football real-time Data Producer",
    description="""
    This is a simple application that creates and puts events into a Kinesis DataStream.
    """,
    version="1.0.0",
)

@app.post(
    "/api/put_events/{max_minutes}",
    tags=["Generate Events"]
)
async def put_events(max_minutes:float):
    """Put the real-time events into the Kinesis DataStream.

    Generate and put the football events into the Kinesis DataStream.

    Args:
        max_minutes (float): Maximum minutes that the function is going 
            to generate and put events into the Kinesis DataStream.
    """
    try:
        put_kinesis_events(max_minutes=max_minutes)
    except ValueError as e:
        raise HTTPException(
            status_code=500, 
            detail=str(e)
        )
    return {"message": "The process was successful."}