FROM ruby:3.1.3

RUN apt-get update

WORKDIR /app
COPY . /app/

ENV BUNDLE_PATH /gems
RUN bundle install
RUN rake db:migrate

EXPOSE 3000
ENTRYPOINT ["bundle", "exec"]
CMD rails server -b 0.0.0.0
