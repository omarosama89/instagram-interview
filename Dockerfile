FROM ruby:2.5.1


WORKDIR /app

COPY . /app

RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs

RUN gem install bundler -v 2.3.27
RUN bundle i

CMD ["rails", "s"]
