FROM python:3.8-slim

WORKDIR /workdir
COPY Pip* .

RUN python -m pip install --upgrade pip
RUN pip install pipenv
RUN pipenv install --system --deploy

COPY realtime_data_producer.py .

ENTRYPOINT [ "python", "realtime_data_producer.py"]
