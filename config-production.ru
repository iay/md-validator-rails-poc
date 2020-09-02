# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

map '/md-validator-rails-poc' do
  run Rails.application
end
