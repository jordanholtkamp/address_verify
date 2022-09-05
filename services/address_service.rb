require 'faraday'
require 'json'

class AddressService
    def initialize(data)
        @street_address = data["street_number"]
        @city = data["city"]
        @zipcode = data["zipcode"]
    end

    def parsed_response
        JSON.parse(address_response.body, symbolize_names: true)
    end

    private
    def connection
        url = "https://us-street.api.smartystreets.com/street-address"
        Faraday.new(url: url) do |faraday|
            faraday.headers['Referer'] = 'localhost'
        end
    end

    def address_response
        connection.get("?street=#{@street_address}
        &city=#{@city}&zipcode=#{@zipcode}&key=#{ENV['ADDRESS_API_KEY']}")
    end
end