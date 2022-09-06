require 'spec_helper'
require './services/address_service'

describe AddressService, type: :model do
    it 'makes request to Smarty API', :vcr do
        json_response = JSON.parse(File.read("./fixtures/api_response.json"))

        ENV['ADDRESS_API_KEY'] = "test_key"

        address_hash = {
            "street_number" => "1888 summit street",
            "city" => "columbus",
            "zipcode" => "43201"
        }

        response = AddressService.new.parsed_response(json_response)
        expect(response[0]).to have_key("delivery_line_1")
        expect(response[0]).to have_key("components")
        expect(response[0]["components"]).to have_key("city_name")
        expect(response[0]["components"]).to have_key("zipcode")
    end

    it 'handles no csv file argument' do
        address_service = AddressService.new

        error_handle = address_service.validate_input(nil)
        require 'pry'; binding.pry
        expect(error_handle).to include("LOG.ERROR")
    end
end