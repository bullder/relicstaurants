FROM public.ecr.aws/docker/library/node:21 AS build
WORKDIR /srv

COPY package.json .
COPY package-lock.json .
RUN npm install --omit=dev

ADD . .

# Run build step
RUN npm run build

FROM public.ecr.aws/docker/library/node:21-slim
RUN apt-get update && apt-get install -y \
  curl \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* && apt-get clean

COPY --from=build /srv .

RUN rm -rf /srv/node_modules

EXPOSE 3000

ENV NEW_RELIC_NO_CONFIG_FILE=true
ENV NEW_RELIC_DISTRIBUTED_TRACING_ENABLED=true
ENV NEW_RELIC_LOG=stdout
ENV NEW_RELIC_AI_MONITORING_ENABLED=true
ENV NEW_RELIC_CUSTOM_INSIGHTS_EVENTS_MAX_SAMPLES_STORED=100k
ENV NEW_RELIC_SPAN_EVENTS_MAX_SAMPLES_STORED=10k
ENV NEW_RELIC_APP_NAME=relicstaurants

CMD ["node", "./server/start.js"]
