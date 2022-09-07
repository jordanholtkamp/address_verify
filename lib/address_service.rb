require 'faraday'
require 'json'

##
# This class holds all of the logic to validate a csv file, 
# take in the data, make an api request, handle and parse 
# the response to json, and format the output for the console.

class AddressService

    ##
    # Takes in a csv file, does a nil check, exits program if nil.

    def validate_input(csv_file)
        if csv_file.nil?
            puts "LOG.ERROR: Please put in a CSV file as a command line argument\n"
            exit!
        end
    end

    ##
    # Takes in a row of the csv file as an argument.
    # Uses the array to create a hash of the address data.

    def create_data_hash(address_row)
        address_hash = {}
        address_hash["street_number"] = address_row[0]
        address_hash["city"] = address_row[1]
        address_hash["zipcode"] = address_row[2]
        return address_hash
    end

    ##
    # Establishes the connection with the external API through Faraday.
    # Calls self method to get_referer which will set the Referer header
    # based on the docker command.

    def make_api_call
        referer = self.get_referer
        url = "https://us-street.api.smartystreets.com/street-address"
        connection = Faraday.new(url: url) do |faraday|
            faraday.headers['Referer'] = referer
        end
    end

    ##
    # Takes in the Faraday connection object and address hash as arguments.
    # Sets params for the request and makes the api call.

    def get_response(connection, address_hash)
        street = address_hash["street_number"]
        city = address_hash["city"]
        zipcode = address_hash["zipcode"]
        connection.get("?street=#{street}&city=#{city}&zipcode=#{zipcode}&key=#{ENV['ADDRESS_API_KEY']}")
    end

    ##
    # Uses docker command to see if environment var is set for Referer.
    # If not, default referer is 'localhost'

    def get_referer
        if ENV['REFERER']
            return ENV['REFERER']
        end
        return 'localhost'
    end

    ##
    # Parses the API response into json for easy manipulation.

    def parse_response(api_response)
        JSON.parse(api_response.body)
    end

    ## 
    # Returns the final output that is printed to the console
    # Checks if the json returned from the call is empty, meaning that 
    # the API got nothing from the response of the address input.

    def format_output(json, address_input)
        if json.empty?
            self.invalid_input(address_input)
        else
            address_input.join(", ") + " -> " + self.format_address_response(json)
        end
    end

    ##
    # Takes in the address input as an argument.
    # Returns a string of the original input that points to 'Inavlid Address'

    def invalid_input(address_input)
        string_input = address_input.join(", ")
        "#{string_input} -> Invalid Address"
    end

    ##
    # Takes in the json response as an argument.
    # Gets necessary components from the json response.
    # Creates the response using string concatenation.

    def format_address_response(json)
        street_address = json[0]["delivery_line_1"]
        city = json[0]["components"]["city_name"]

        first_four_zip = json[0]["components"]["zipcode"]
        plus4 = json[0]["components"]["plus4_code"]

        full_zipcode = "#{first_four_zip}-#{plus4}"
        "#{street_address}, #{city}, #{full_zipcode}"
    end
end