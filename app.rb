require 'cuba'
require 'dotenv/load'

Dir['./lib/**/*.rb'].each { |rb| require rb }

require 'pry' unless ENV['RACK_ENV'] == 'production'

Cuba.define do
  on 'geocode_address' do
    on get, param('q') do |address|
      body = GeocodeService.geocode_address(address)

      res['Content-Type'] = 'application/json'
      res.write(body.to_json)
    end
  end

  on true do
    res.status = 404
    res.write({ error: 'not found' }.to_json)
  end
end
