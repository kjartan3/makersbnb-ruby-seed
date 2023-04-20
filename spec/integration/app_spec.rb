require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'json'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  # Write your integration tests below.
  # If you want to split your integration tests
  # accross multiple RSpec files (for example, have
  # one test suite for each set of related features),
  # you can duplicate this test file to create a new one.


  context "GET /requests" do
    it 'should get the requests page' do
      response = get('/requests')
      
      expect(response.status).to eq(200)
      expect(response.body).to include('Requests')
      expect(response.body).to include("Requests I've made")
      expect(response.body).to include("Requests received")
      
    end

    xit 'when you log in with user_id 3 you should display one request made' do
      response = get('/requests/3')

      expect(response.status).to eq(200)
      expect(response.body).to include("<p>House of Dreams</p>")
      expect(response.body).to include("<p>Approved</p>")
      expect(response.body).to include("<p>2023-07-06</p>")
    end

    xit 'returns the list of bookings made from user2' do 
      post(
        "/login",
        email:"user2@gmail.com",
        password:"abcd")

      response = get('/requests')

      expect(response.status).to eq 200 
      expect(response.body).to include('House of Horrors')
      expect(response.body).to include('No new requests')
    end 
  end
end
      
    



      
