FROM python:3-alpine

WORKDIR /app

COPY . ./

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 3000

ENTRYPOINT [ "python", "./app.py" ]

