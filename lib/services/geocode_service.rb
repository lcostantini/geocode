require 'net/http'
require 'json'

class GeocodeService
  BASE_URL = 'https://maps.googleapis.com/maps/api'.freeze

  class << self
    def token
      ENV['GEOCODE_API_KEY']
    end

    def build_query(params)
      params.map do |key, value|
        "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
      end.join('&')
    end

    def get(path, params)
      query = build_query(params)
      uri = URI(BASE_URL + path + "?key=#{token}&#{query}")

      handle_response(Net::HTTP.get_response(uri))
    end

    def handle_response(response)
      code = response.code.to_i
      raise StandardError, response if code < 200 || code >= 300

      JSON.parse(response.body, symbolize_names: true)
    end

    def geocode_address(address)
      get('/geocode/json', address: address)
    end
  end
end
