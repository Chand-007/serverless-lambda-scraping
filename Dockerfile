FROM python:3.8-slim


WORKDIR /app


COPY lambda/requirements.txt .


RUN pip install --no-cache-dir -r requirements.txt -t /app/lambda/


COPY lambda/ /app/lambda/


RUN zip -r /app/lambda-function.zip /app/lambda/


CMD ["ls", "-l", "/app/lambda-function.zip"]
