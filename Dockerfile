FROM  python:3-alpine

WORKDIR /app

COPY app.py,requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 3000

COPY . .

CMD [ "python", "./your-daemon-or-script.py" ]
ENTRYPOINT [ "app.py" ]