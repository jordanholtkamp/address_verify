require 'spec_helper'
require './lib/format_api_request'

describe FormatApiRequest, type: :model do
    it 'formats address input' do
        input_row = ['123 mulberry ave', 'denver', '80211']
        formatter = FormatApiRequest.new(input_row)

        expected = {"street_number"=>"123 mulberry ave", 
        "city"=>"denver", "zipcode"=>"80211"}
        expect(formatter.create_data_hash).to eq(expected)
    end
end