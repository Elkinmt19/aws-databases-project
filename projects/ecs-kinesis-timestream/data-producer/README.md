```bash
# To start the API server use the following command.
uvicorn run:app --reload

# To build the container image use the following command.
docker build -t <name:tag> .

# To run a container using the image previously created
# use the following command.
docker run --rm --name <container-name> -p <machine-port>:<container-port> <image-name>
```