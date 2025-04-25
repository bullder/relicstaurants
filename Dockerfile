# Stage 1: Build
FROM public.ecr.aws/docker/library/node:21 AS build

WORKDIR /srv

COPY package.json package-lock.json ./
RUN npm ci --omit=dev

# Copy the rest and build
COPY . .
RUN npm run build

# Stage 2: Runtime
FROM public.ecr.aws/docker/library/node:21-slim

RUN apt-get update && apt-get install -y \
    curl \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /srv

COPY --from=build /srv/package.json /srv/package-lock.json ./
COPY --from=build /srv/build ./build
COPY --from=build /srv/public ./public
COPY --from=build /srv/server ./server

EXPOSE 3000

ENV NEW_RELIC_NO_CONFIG_FILE=true
ENV NEW_RELIC_DISTRIBUTED_TRACING_ENABLED=true
ENV NEW_RELIC_LOG=stdout
ENV NEW_RELIC_AI_MONITORING_ENABLED=true
ENV NEW_RELIC_CUSTOM_INSIGHTS_EVENTS_MAX_SAMPLES_STORED=100k
ENV NEW_RELIC_SPAN_EVENTS_MAX_SAMPLES_STORED=10k
ENV NEW_RELIC_APP_NAME=relicstaurants

CMD ["node", "./server/start.js"]
