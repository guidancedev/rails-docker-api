# https://lipanski.com/posts/dockerfile-ruby-best-practices
# 145MB - docker multistage development environment with live reload
FROM ruby:3.0.0-alpine AS base

ARG BUILD_PACKAGES="build-base git bash openssh" \
    DEV_PACKAGES="postgresql-dev" \
    RUBY_PACKAGES="tzdata"
ENV RAILS_ENV=development

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app/

RUN apk update && apk upgrade && \
    apk add --no-cache --virtual .build-deps $BUILD_PACKAGES && apk add $DEV_PACKAGES \
    && apk add --update $RUBY_PACKAGES && bundle install --jobs=5 && apk del .build-deps

COPY . .

# Remove folders not needed in resulting image
RUN rm -rf tmp/cache app/assets vendor/assets spec

############### Build step done ###############

FROM ruby:3.0.0-alpine

ARG PACKAGES="tzdata postgresql-client"

ENV RAILS_ENV=development
WORKDIR /usr/src/app

RUN apk update && apk upgrade \
    && apk add --update --no-cache $PACKAGES

COPY --from=base /usr/local/bundle/ /usr/local/bundle/
COPY . .

ENTRYPOINT ["sh", "./entrypoint.sh"]
EXPOSE 3000
CMD ["bundle","exec","rails", "server", "-b", "0.0.0.0"]
