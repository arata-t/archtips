FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /archtips
WORKDIR /archtips

COPY Gemfile /archtips/Gemfile
COPY Gemfile.lock /archtips/Gemfile.lock

RUN gem install bundler
RUN bundle install
COPY . /archtips