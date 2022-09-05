require 'spec_helper'
require './lib/format_output'
require 'json'

RSpec.describe FormatOutput, type: :model do
    it 'formats output after API call' do
        json_response = JSON.parse(File.read("./fixtures/api_response.json"))

        original_input = ["1888 summit st", "columbus", "43201"]

        output = FormatOutput.new(json_response, original_input).format_console_output
        expect(output).to include(original_input[0])
        expect(output).to include(original_input[1])
        expect(output).to include(original_input[2])

    end
end