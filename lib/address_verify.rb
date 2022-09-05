require 'csv'
require_relative './format_api_request'
require_relative '../services/address_service'
require_relative './format_output'
require 'dotenv/load'

if ARGV[0].nil?
    print "Please put in a CSV file as a command line argument\n"
end

csv_text = CSV.read(ARGV[0])

csv_text.each do |address_input_row|

    address_hash = FormatApiRequest.new(address_input_row).create_data_hash

    if ENV['ADDRESS_API_KEY'].nil?
        print "Set environment variable named 'ADDRESS_API_KEY' to make API call"
    end

    address_api_response = AddressService.new(address_hash).parsed_response

    formatted_console_output = FormatOutput.new(address_api_response, address_input_row).format_console_output

    puts formatted_console_output
end