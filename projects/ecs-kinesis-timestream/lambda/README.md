# <p align="center"> <img src="assets/imgs/lambda_logo.png" width="5%"/> **Lambda** <img src="assets/imgs/lambda_logo.png" width="5%"/> </p>

This `Lambda Function` gets the real-time events from a Kinesis Data Stream to process them and then insert them into a Timestream database. This function was developed using Python and boto3 SDK.

<p align="center">
    <img src="assets/imgs/aws_logo.png" width="45%"/>
    <img src="assets/imgs/lambda_big_logo.png" width="19%"/>
</p>

This function is triggered by a Kinesis Data Stream, every time a new event get in the stream the lambda function is executed.