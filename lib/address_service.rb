require 'faraday'
require 'json'

##
# This class holds all of the logic to validate a csv file, 
# take in the data, make an api request, handle and parse 
# the response to json, and format the output for the console.

class AddressService

    ##
    # Takes in a csv file, does a nil check, exits program if nil
    def validate_input(csv_file)
        if csv_file.nil?
            puts "LOG.ERROR: Please put in a CSV file as a command line argument\n"
            exit!
        end
    end

    def create_data_hash(address_row)
        address_hash = {}
        address_hash["street_number"] = address_row[0]
        address_hash["city"] = address_row[1]
        address_hash["zipcode"] = address_row[2]
        return address_hash
    end

    def make_api_call
        referer = self.get_referer
        url = "https://us-street.api.smartystreets.com/street-address"
        connection = Faraday.new(url: url) do |faraday|
            faraday.headers['Referer'] = referer
        end
    end

    def get_response(connection, address_hash)
        street = address_hash["street_number"]
        city = address_hash["city"]
        zipcode = address_hash["zipcode"]
        connection.get("?street=#{street}&city=#{city}&zipcode=#{zipcode}&key=#{ENV['ADDRESS_API_KEY']}")
    end

    def get_referer
        if ENV['REFERER']
            return ENV['REFERER']
        end
        return 'localhost'
    end

    def parse_response(api_response)
        JSON.parse(api_response.body)
    end

    def format_output(json, address_input)
        if json.empty?
            self.invalid_input(address_input)
        else
            address_input.join(", ") + " -> " + self.format_address_response(json)
        end
    end

    def invalid_input(address_input)
        string_input = address_input.join(", ")
        "#{string_input} -> Invalid Address"
    end

    def format_address_response(json)
        street_address = json[0]["delivery_line_1"]
        city = json[0]["components"]["city_name"]

        first_four_zip = json[0]["components"]["zipcode"]
        plus4 = json[0]["components"]["plus4_code"]

        full_zipcode = "#{first_four_zip}-#{plus4}"
        "#{street_address}, #{city}, #{full_zipcode}"
    end
end