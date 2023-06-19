# <p align="center"> <img src="assets/imgs/ecs_logo.png" width="5%"/> **Data Producer** <img src="assets/imgs/ecs_logo.png" width="5%"/> </p>

This service was built on top of `Amazon ECS`, its main functionality is to randomly generate events in a time windows that is specify by the user of the application as a parameter.

<p align="center">
    <img src="assets/imgs/python_logo.png" width="25%"/>
    <img src="assets/imgs/fastapi_logo.png" width="50%"/>
</p>

This application was developed using Python and some of its most popular libraries as `Boto3`, `Faker` and `FastAPI`. The data generation is controlled using a simple REST API created using FastAPI framework. The data generated is instantly sent to a Kinesis Data Stream for future processing.

## **Getting Started** :checkered_flag:
This application can be used in two ways:
- Running the application locally with a Python installation on your local machine and creating a virtual environment to install all the dependencies and modules needed.

    In order to run the application you need to run the following steps:

    - Install the Python dependencies and create the virtual environment.
        ```bash
        pip install pipenv 
        pipenv install 
        ```
    - Start the REST API service locally using the uvicorn command.
        ```bash
        uvicorn run:app --reload
        ```

- Executing the application using Docker with a container.

    In order to run the application you need to run the following steps:

    - Build the container image using the docker build command.
        ```bash
        docker build -t <image-name:tag> .
        ```
    - Execute the container the docker run command.
        ```bash
        docker run --rm --name <container-name> -p 8080:8080 <image-name:tag>
        ```