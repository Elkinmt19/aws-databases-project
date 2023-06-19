# <p align="center"> <img src="assets/imgs/database.gif" width="5%"/> **ECS + Kinesis + Timestream Integration Project** <img src="assets/imgs/database.gif" width="5%"/> </p>

This project implements a Data Pipeline that takes real-time events and inserts them into an `Amazon Timestream` database and then these events are visualized using `Grafana`. This whole project was built on top of `Terraform` as an IaC (Infrastructure as Code) tool and using AWS services.

## **Architecture** :triangular_ruler:
This section shows a diagram of the project architecture. It shows how AWS services and project elements interact with each other.

<p align="center">
    <img src="assets/imgs/data_pipeline_architecture.drawio.png" width="100%"/>
</p>

## **Services** :space_invader:
- [Amazon Elastic Container Service (ECS)](https://aws.amazon.com/ecs/): Amazon Elastic Container Service (Amazon ECS) is a fully managed container orchestration service that simplifies your deployment, management, and scaling of containerized applications.

- [Amazon Elastic Container Registry (ECR)](https://aws.amazon.com/es/ecr/): Amazon Elastic Container Registry (Amazon ECR) is a fully managed container registry offering high-performance hosting, so you can reliably deploy application images and artifacts anywhere.

- [Amazon Kinesis Data Streams](https://aws.amazon.com/es/kinesis/data-streams/): Amazon Kinesis Data Streams is a serverless streaming data service that makes it easy to capture, process, and store data streams at any scale.

- [AWS Lambda](https://aws.amazon.com/lambda/?nc1=h_ls): AWS Lambda is a serverless, event-driven compute service that lets you run code for virtually any type of application or backend service without provisioning or managing servers.

- [Amazon Timestream](https://aws.amazon.com/timestream/): Amazon Timestream is a fast, scalable, and serverless time-series database service that makes it easier to store and analyze trillions of events per day up to 1,000 times faster.
## **Tools** :wrench:

## **Setup** :rocket:



