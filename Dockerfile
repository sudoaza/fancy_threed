FROM ruby:2.5.4
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /threed
WORKDIR /threed
COPY Gemfile /threed/Gemfile
COPY Gemfile.lock /threed/Gemfile.lock
RUN gem install bundle
RUN bundle install
COPY . /threed

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]