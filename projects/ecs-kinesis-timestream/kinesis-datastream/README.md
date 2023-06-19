# <p align="center"> <img src="assets/imgs/kds_logo.png" width="5%"/> **Kinesis Data Stream** <img src="assets/imgs/kds_logo.png" width="5%"/> </p>

The service creates a `Kinesis Data Stream` using AWS, the events of this stream are sent by the `Data Producer` service and the creation of this service was completely developed using Terraform as IaC tool.

<p align="center">
    <img src="assets/imgs/aws_logo.png" width="45%"/>
    <img src="assets/imgs/kds_big_logo.png" width="35%"/>
</p>

This stream is important for this project because it carries the real-time events that were produced by the Data Producer service and then integrates with other services such as Lambda to get the events and put them into a Database.