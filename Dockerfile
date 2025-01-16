# syntax = docker/dockerfile:1
ARG RUBY_VERSION=3.2.5
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails
ENV BUNDLE_PATH="/usr/local/bundle"

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl default-mysql-client libjemalloc2 libvips libpq-dev && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/*

# Throw-away build stage to reduce size of final image
FROM base AS build

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential default-libmysqlclient-dev git pkg-config && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/*

# Install application gems
COPY Gemfile* ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

COPY . .

FROM node:22.7.0-slim AS node
WORKDIR /rails
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Final stage for app image
FROM base
# Copy built artifacts: gems, application
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails
COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /opt/yarn-* /opt/yarn
COPY --from=node /rails/node_modules /rails/node_modules

RUN ln -fs /opt/yarn/bin/yarn /usr/local/bin/yarn

# ‘bundle install’ is a separate stage and the alias is lost. Recreate
RUN echo "alias rails='bundle exec rails'" >> ~/.bashrc

EXPOSE 3000
CMD bash -c "rm -f tmp/pids/server.pid && bin/dev"
