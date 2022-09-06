# Address Verify

## Overview
Address Verify is a command line application that verifies and formats 
addresses. Address Verify was built in Ruby 2.7.2. The application accepts a CSV file as a command line argument. The CSV file should contain rows of address data. The application accepts the rows of data, makes a call to the Smarty Street API, and prints the new formatted address to the command line, along with the original address. If the address is invalid, that is also printed to the console.

## Assumptions
#### API Key
I assumed that the Smarty API key provided by Amy was an embedded key. I saw that there were two types of keys and the secret key had two components, so as the key provided to me only had one component, I assumed it was an embedded key. As it did not work for making my requests, I created my own embedded key and set the `Referer` header that is necessary when using the embedded key to `localhost`.

## Usage
#### Run using Docker
* To simplify running the code for this application, I put it into a Docker image container.
* Simply clone the repo and cd into the project directory.
* The Dockerfile will run all the tests and the application, using the csv file with the 5 addresses I added into it. If you wish to use your own CSV file for the program, simply change out the last argument in the ruby `CMD` in the Dockerfile with whatever path to your CSV. Or add the csv file into the root directory of the project.
* Run and build the Dockerfile with `docker run -e ADDRESS_API_KEY=YOUR_API_KEY_VALUE $(docker build -q .)` switching out `YOUR_API_KEY_VALUE` with your Smarty Api Key Value.
* This will run all the tests, and should see no output if they all pass. You can also run `rspec` in the terminal if you want to see the testing output in the console.

#### Run locally
* Clone the repo and cd into the project directory
* Run `bundle install` & `bundle update`
* To run the testing suite, again run `rspec`
* Before running the program, make sure you set your environment variable for the API key by creating a `.env` file setting the `ADDRESS_API_KEY` variable, or simply add it into the code in the AddressService that calls the API (only for testing purposes)
* To run the program, run `ruby lib/address_verify.rb #{YOUR_CSV_FILE}`


## Testing
To run the test suite, cd into the project directory and run `rspec`. The testing suite leverages webmock and VCR to record and stub out external API requests.

