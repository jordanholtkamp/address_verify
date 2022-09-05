class FormatApiRequest

    def initialize(address_row)
        @address_row = address_row
    end

    def create_data_hash
        address_hash = {}
        address_hash["street_number"] = @address_row[0]
        address_hash["city"] = @address_row[1]
        address_hash["zipcode"] = @address_row[2]
        return address_hash
    end
end