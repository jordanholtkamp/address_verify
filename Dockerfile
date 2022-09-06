FROM ruby

RUN mkdir /usr/src/app
RUN echo "asdff"
ADD . /usr/src/app/
WORKDIR /usr/src/app/

RUN bundle install
RUN bundle update

RUN rspec

CMD ["ruby", "/usr/src/app/lib/address_verify.rb", "/usr/src/app/addresses.csv"]
