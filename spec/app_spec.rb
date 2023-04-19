require "spec_helper"
require "rack/test"
require_relative '../app.rb'
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


  context 'GET /' do
    it 'should get the homepage' do
      response = get('/spaces')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h3>House of Horrors</h3>')
      expect(response.body).to include('<%=Haunted house with friendly ghost %>')
      expect(response.body).to include('<%=2023-07-04%>')
      expect(response.body).to include('<%=2023-08-31%>')
      xpect(response.body).to include(100)
    end
  end
end