require 'spec_helper'
require './services/address_service'

describe AddressService, type: :model do
    it 'makes request to Smarty API', :vcr do

        address_hash = {
            "street_number" => "1888 summit street",
            "city" => "columbus",
            "zipcode" => "43201"
        }
        require 'pry'; binding.pry
        response = AddressService.new(address_hash).parsed_response
        expect(response[0]).to have_key(:delivery_line_1)
        expect(response[0]).to have_key(:components)
        expect(response[0][:components]).to have_key(:city_name)
        expect(response[0][:components]).to have_key(:zipcode)
    end
end