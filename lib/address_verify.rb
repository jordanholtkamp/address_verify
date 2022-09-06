require 'csv'
require_relative './format_api_request'
require_relative '../services/address_service'
require_relative './format_output'
require 'dotenv/load'

address_service = AddressService.new
csv_file = ARGV[0]

address_service.validate_input(csv_file)

begin
    csv_text = CSV.read(ARGV[0])
rescue Errno::ENOENT
    puts "LOG.ERROR: File not found"
    exit!
end

csv_text.each do |address_input_row|
    address_hash = address_service.create_data_hash(address_input_row)

    connection = address_service.make_api_call
    api_response = address_service.get_response(connection, address_hash)
    parsed_json = address_service.parsed_response(api_response)

    formatted_console_output = address_service.format_output(parsed_json, address_input_row)

    puts formatted_console_output
end