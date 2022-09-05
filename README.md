# Address Verify

## Overview
Address Verify is a command line application that verifies and formats 
addresses. Address Verify was built in Ruby 2.7.2. The application accepts a CSV file as a command line argument. The CSV file should contain rows of address data. The application accepts the rows of data, makes a call to the Smarty Street API, and prints the new formatted address to the command line, along with the original address. If the address is invalid, that is also printed to the console.

## Usage


## Testing
To run the test suite, cd into the project directory and run `rspec`. The testing suite leverages webmock and VCR to
stub out external API requests.