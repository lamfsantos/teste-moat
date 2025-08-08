# Use official Ruby 3.1.3 image
FROM ruby:3.1.3-slim-bullseye

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - default-mysql-client: MySQL client
# - default-libmysqlclient-dev: MySQL development files
# - git: For git operations
RUN apt-get update -qq && \
    apt-get install -y build-essential \
    default-mysql-client \
    default-libmysqlclient-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the main application
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile --gemfile app/ lib/

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose port 3000 to the Docker host
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
