#!/usr/bin/env ruby

# Simple sinatra stager.
# An example of how to use the continuum-stager-api.
# The API is located at: https://github.com/apcera/stager-api-ruby

require "bundler"
Bundler.setup

# Bring in continuum-stager-api
require "continuum-stager-api"

stager = Apcera::Stager.new

# Add the ruby dependency we need to stage our app. If it was added
# then restart the stager, otherwise we already have it.
puts "Adding dependencies"
should_restart = false

if stager.dependencies_add("runtime", "ruby")
  should_restart = true
end

# Need build tools
if stager.dependencies_add("package", "build-essential")
  should_restart = true
end

if should_restart == true
  stager.relaunch
end

# Download the package from the staging coordinator.
puts "Downloading Package..."
stager.download

# Extract the package to the "app" directory.
puts "Extracting Package..."
stager.extract("app")

# Run bundler for my app in the extracted directory.
puts "Running Bundler..."
stager.execute_app("bundle install --path vendor/bundle --binstubs vendor/bundle/bin --deployment")
stager.execute("find #{stager.app_path} -type d -exec chmod 755 {} +")

# Run tests
puts "Running Tests..."
stager.execute_app("bash -c 'export RUBYOPT=W0;RACK_ENV=test bundle exec rake test'")

# Set the start command.
start_cmd = "bundle exec rackup config.ru -p $PORT"
puts "Setting start command to '#{start_cmd}'"
stager.start_command = start_cmd

# Set the start path.
start_path = "/app"
puts "Setting start path to '#{start_path}'"
stager.start_path = start_path

# Finish staging, this will upload your final package to the
# staging coordinator.
puts "Completed Staging..."
stager.complete
