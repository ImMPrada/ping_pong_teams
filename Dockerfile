FROM ruby:3.1.2-alpine

RUN apk add --update --no-cache build-base postgresql-dev postgresql-client git
RUN mkdir /app

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler:2.3.14
RUN bundle install

COPY . /app
