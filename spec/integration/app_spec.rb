require "spec_helper"
require "rack/test"
require_relative '../../app.rb'
require 'json'


# TEST NOT WORKING,   error message kept saying that it couldn't connect to to the test date:
# Error message:
# Refusing to connect to the dev database in test mode.
# For your safety, when the tests are running this class will refuse
# to connect to a database unless its name ends with `_test`.
# You tried to connect to the database `makersbnb`.
# This is probably a problem with your setup.


describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context 'GET /' do
    it 'should get the homepage' do
      response = get('/spaces')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h3>House of Horrors</h3>')
      expect(response.body).to include('<%=Haunted house with friendly ghost %>')
      expect(response.body).to include('<%=2023-07-04%>')
      expect(response.body).to include('<%=2023-08-31%>')
      expect(response.body).to include(100)
    end
  end
end