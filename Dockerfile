FROM ruby:2.7.5

ARG B_UID=1000
ARG B_GID=1000
ARG RAILS_PORT=3000

RUN addgroup --gid ${B_GID} rails
RUN adduser --disabled-password --gecos '' --uid ${B_UID} --gid ${B_GID} rails

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client


RUN mkdir /app && \
    chown -R rails:rails /app

WORKDIR /app
USER rails

COPY --chown=rails:rails Gemfile* /app/

RUN gem install bundler && \
    bundle install

EXPOSE $RAILS_PORT

COPY --chown=rails:rails ./entrypoint.sh /app/
RUN chmod +x ./entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
CMD ["bin/rails", "server", "-b", "0.0.0.0"]