#
# Dockerfile for md-validator-rails-poc.
#

#
# First stage: build the application and the precompiled assets.
#
FROM ruby:3.2-alpine as builder

LABEL maintainer="Ian Young <ian@iay.org.uk>"

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

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN bundle config set deployment 'true'
RUN bundle config set without 'development'

#
# Install gems.
#
COPY Gemfile Gemfile.lock ./
RUN bundle install

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

#
# Second stage: executable image with no Node presence
# and with the webpacker gem excluded.
#
FROM ruby:3.2-alpine AS poc

LABEL maintainer="Ian Young <ian@iay.org.uk>"

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
      openssl \
      pkgconfig \
      python3 \
      sqlite-dev \
      tzdata

WORKDIR /app

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN bundle config set deployment 'true'
RUN bundle config set without 'development'

#
# Install gems.
#
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the application
COPY . ./

#
# The Node configuration is not wanted in the
# production image.
#
RUN rm package.json yarn.lock

# Copy precompiled assets
COPY --from=builder /app/public/assets public/assets

ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true

EXPOSE 3000

CMD ["bin/rails", "server", "--environment=production", \
      "--config=config-production.ru"]
