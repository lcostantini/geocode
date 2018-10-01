require 'cuba'
require 'dotenv/load'

Dir['./lib/**/*.rb'].each { |rb| require rb }

require 'pry' unless ENV['RACK_ENV'] == 'production'

Cuba.define do
end
