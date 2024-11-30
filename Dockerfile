FROM python:3.10.12-alpine

COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip install -r requirements.txt

COPY . .

EXPOSE 5000

ENV FLASK_APP="blacklists/src/main.py"
RUN pip install newrelic
ENV NEW_RELIC_APP_NAME="blacklist-app"
ENV NEW_RELIC_LOG=stdout
ENV NEW_RELIC_DISTRIBUTED_TRACING_ENABLED=true
ENV NEW_RELIC_LICENSE_KEY=c71f6d0fe274079b9fb2390adaaa05aaFFFFNRAL
ENV NEW_RELIC_LOG_LEVEL=info

CMD ["flask", "run", "-h", "0.0.0.0", "--port=5000"]
ENTRYPOINT [ "newrelic-admin", "run-program" ]