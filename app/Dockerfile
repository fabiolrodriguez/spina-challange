FROM ruby:3.3 AS base

# Register Yarn package source.
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install additional packages.
RUN apt update -qq
RUN apt install -y postgresql-client nodejs yarn

# Prepare working directory.
WORKDIR /ror
COPY . /ror
RUN gem install bundler
RUN bundle install

# Development build
FROM base AS development
RUN rails new . --database=postgresql
RUN echo "gem 'spina', '~> 2.18'" >> /ror/Gemfile
RUN bundle install

# Configure endpoint.
COPY ./entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start app server.
CMD ["rails", "server", "-e", "development", "-b", "0.0.0.0"]

# Production build
FROM base AS production
COPY . /app
RUN mv .env_production .env
RUN rails new . --database=postgresql
RUN echo "gem 'spina', '~> 2.18'" >> /ror/Gemfile
RUN bundle install

# Configure endpoint.
COPY ./entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Precompile Rails assets
RUN RAILS_ENV=production bundle exec rake assets:precompile
CMD ["rails", "server", "-e", "production", "-b", "0.0.0.0"]
