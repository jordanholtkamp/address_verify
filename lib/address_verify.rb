require 'csv'
require_relative './format_api_request'
require_relative '../services/address_service'
require_relative './format_output'
require 'dotenv/load'

csv_text = CSV.read(ARGV[0])

address_hash = {}

csv_text.each do |address_input_row|

    address_hash = FormatApiRequest.new(address_input_row).create_data_hash

    address_api_response = AddressService.new(address_hash).parsed_response

    FormatOutput.new(address_api_response, address_input_row).format_console_output

    # api call
    
    # for each address and then return
end
