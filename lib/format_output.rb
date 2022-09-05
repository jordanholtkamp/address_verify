class FormatOutput
    def initialize(json_response, original_input)
        @json_response = json_response
        @original_input = original_input
    end

    def format_console_output
        if @json_response.empty?
            invalid_input
        else
            @original_input.join(", ") + " -> " + format_address_response
        end
    end

    def invalid_input
        string_input = @original_input.join(", ")
        "#{string_input} -> Invalid Address"
    end

    def format_address_response
        street_address = @json_response[0][:delivery_line_1]
        city = @json_response[0][:components][:city_name]

        first_four_zip = @json_response[0][:components][:zipcode]
        plus4 = @json_response[0][:components][:plus4_code]

        full_zipcode = "#{first_four_zip}-#{plus4}"
        "#{street_address}, #{city}, #{full_zipcode}"
    end
end