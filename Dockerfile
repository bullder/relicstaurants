FROM public.ecr.aws/docker/library/node:18 AS build
WORKDIR /srv

# Copy package files and install dependencies
ADD package.json .
RUN npm install

# Copy the rest of the app files for build
ADD . .

# Run build step
RUN npm run build

# --- Runtime image ---
FROM public.ecr.aws/docker/library/node:18-slim
RUN apt-get update && apt-get install -y \
  curl \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* && apt-get clean

# Copy built app from build stage
COPY --from=build /srv .

EXPOSE 3000

ENV NEW_RELIC_NO_CONFIG_FILE=true
ENV NEW_RELIC_DISTRIBUTED_TRACING_ENABLED=true
ENV NEW_RELIC_LOG=stdout
ENV NEW_RELIC_AI_MONITORING_ENABLED=true
ENV NEW_RELIC_CUSTOM_INSIGHTS_EVENTS_MAX_SAMPLES_STORED=100k
ENV NEW_RELIC_SPAN_EVENTS_MAX_SAMPLES_STORED=10k

CMD ["node", "./server/start.js"]
