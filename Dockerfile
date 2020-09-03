#
# Dockerfile for md-validator-rails-poc.
#
FROM ruby:2.7-alpine as builder

MAINTAINER Ian Young <ian@iay.org.uk>

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN bundle config set deployment 'true'

# Install system packages
RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      openssl \
      pkgconfig \
      python3 \
      sqlite-dev \
      tzdata \
      yarn

WORKDIR /app

#
# Install gems.
#
COPY Gemfile Gemfile.lock ./
RUN bundle install --without=devel

#
# Install node packages.
#
COPY package.json yarn.lock ./
RUN yarn install --check-files

# Copy the application
COPY . ./

# Precompile assets
ENV RAILS_ENV=production
ENV SECRET_KEY_BASE=dummy
RUN bin/rails assets:precompile

ENV RAILS_SERVE_STATIC_FILES=true

EXPOSE 3000

CMD ["bin/rails", "server", "--environment=production", \
      "--config=config-production.ru"]
