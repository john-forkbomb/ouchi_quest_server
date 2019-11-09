FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y nodejs build-essential
RUN gem install bundler -v 2.0.2

ENV APP_ROOT /jphacks
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

ADD Gemfile ${APP_ROOT}/Gemfile
ADD Gemfile.lock ${APP_ROOT}/Gemfile.lock
RUN bundle install

COPY . $APP_ROOT
