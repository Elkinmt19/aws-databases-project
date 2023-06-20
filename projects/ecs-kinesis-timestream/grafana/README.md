# <p align="center"> <img src="assets/imgs/ecs_logo.png" width="5%"/> **Grafana** <img src="assets/imgs/ecs_logo.png" width="5%"/> </p>

This service was built on top of `Amazon ECS`, this application hosts a `Grafana` client using a container. This service is going to be used to visualize all the TimeSeries data that is inserted in the `Timestream` database of the project.

<p align="center">
    <img src="assets/imgs/grafana_logo.webp" width="80%"/>
</p>

This application has been developed as a visualization tool so that the user can see in real time the data being entered into the time series database.

## **Getting Started** :checkered_flag:
This application can be executed locally using Docker. In order to run the application you need to run the following steps:

- Execute the container using the docker-compose up command.
    ```bash
    docker-compose up -d
    ```
- Stop the container using the docker-compose down command.
    ```bash
    docker-compose down
    ```