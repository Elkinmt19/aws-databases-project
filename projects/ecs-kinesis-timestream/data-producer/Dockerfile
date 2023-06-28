FROM python:3.8-slim

WORKDIR /workdir
COPY Pip* ./

RUN python -m pip install --upgrade pip
RUN pip install pipenv
RUN pipenv install --system --deploy

COPY *.py ./
EXPOSE 8000

ENTRYPOINT ["uvicorn", "run:app", "--host", "0.0.0.0", "--port", "80", "--timeout-keep-alive", "600"]