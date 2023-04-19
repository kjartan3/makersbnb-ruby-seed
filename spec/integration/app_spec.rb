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
      expect(response.body).to include('<h1>Requests</h1>')
      expect(response.body).to include("<div>Requests I've made</div>")
      expect(response.body).to include("<div>Requests I've received</div>")
    end
  end
end
