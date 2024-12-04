# Stage 1: Build dependencies
FROM ruby:3.3.6-alpine3.20 AS builder

# Set the working directory inside the container
WORKDIR /app

# Install build dependencies
RUN apk add --no-cache \
  build-base \
  sqlite-dev \
  git

# Set environment variables for production
ENV RAILS_ENV=production
ENV BUNDLE_WITHOUT="development:test"
ENV BUNDLE_PATH=/app/vendor/bundle

# Copy Gemfile and Gemfile.lock for dependency installation
COPY Gemfile Gemfile.lock ./

# Install Ruby gems
RUN bundle install

# Stage 2: Minimal runtime image
FROM ruby:3.3.6-alpine3.20

# Set the working directory inside the container
WORKDIR /app

# Install runtime dependencies
RUN apk add --no-cache \
  sqlite-libs \
  tzdata

# Set environment variables for production
ENV RAILS_ENV=production
ENV BUNDLE_WITHOUT="development:test"
ENV BUNDLE_PATH=/app/vendor/bundle

# Copy the application and installed gems from the builder stage
COPY --from=builder /app /app

# Copy the rest of the application files
COPY . .

# Expose the port that Rails will run on
EXPOSE 3000

# Set the default command to start the Rails server
CMD ["/app/bin/rails", "server", "-b", "0.0.0.0"]
