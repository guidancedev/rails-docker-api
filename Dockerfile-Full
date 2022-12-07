FROM ruby:3.0.0

RUN apt-get update -qq && apt-get install -y build-essential postgresql-client
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app/

RUN gem install bundler -no-ri-no-rdoc
RUN bundle install --jobs 8
RUN rm -rf /usr/local/bundle/cache/*.gem && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete

WORKDIR /usr/src/app/
COPY . /usr/src/app/

ENTRYPOINT ["./entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]