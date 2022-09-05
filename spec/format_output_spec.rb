require 'spec_helper'
require './lib/format_output'

RSpec.describe FormatOutput, type: :model do
    it 'formats output after API call' do
        json_response = File.read("./fixtures/api_response.json")

        original_input = ["1888 summit st", "columbus", "43201"]

        output = FormatOutput.new(json_response, original_input).format_console_output
        require 'pry'; binding.pry
    end
end