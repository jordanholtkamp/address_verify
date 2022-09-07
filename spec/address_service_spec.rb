require 'spec_helper'
require './lib/address_service'

describe AddressService, type: :model do
    it 'creates a data hash' do
        address = ["123 real blvd", 'los angeles', '90210']
        hash = AddressService.new.create_data_hash(address)
        expect(hash).to have_key("street_number")
        expect(hash).to have_key("city")
        expect(hash).to have_key("zipcode")
    end
    
    it 'makes a call to the API and gets response body', :vcr do
        input_row = ['1888 summit st', 'columbus', '43201']

        # this is only needed to satisfy the vcr request cassette
        ENV['ADDRESS_API_KEY'] = "TEST"

        service = AddressService.new
        hash = service.create_data_hash(input_row)

        connection = service.make_api_call
        expect(connection).to be_a Faraday::Connection
        response = service.get_response(connection, hash)
        parsed = service.parse_response(response)
        expect(parsed[0]).to have_key("input_index")
        expect(parsed[0]).to have_key("delivery_line_1")
        expect(parsed[0]["components"]["zipcode"]).to eq("43201")
    end

    it 'makes formats proper output' do
        json_response = JSON.parse(File.read("./fixtures/api_response.json"))

        input_row = ['1888 summit st', 'columbus', '43201']

        response = AddressService.new.format_output(json_response, input_row)
        expect(response).to include(input_row[0])
        expect(response).to include(input_row[1])
        expect(response).to include(input_row[2])
        expect(response).to include('->')
        expect(response).to include("1888 Summit St, Columbus, 43201-5506")
        
    end


    it 'outputs inavlid argument' do
        address = ["123 not real blvd", 'los angeles', '90210']
        output = AddressService.new.invalid_input(address)
    end

    # Messes up rspec console output
    # it 'handles no csv file argument' do
    #     address_service = AddressService.new

    #     expect(address_service.validate_input(nil)).to output("LOG.ERROR: Please put in a CSV file as a command line argument")
    # end
end