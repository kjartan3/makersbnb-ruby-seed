require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'json'


describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context 'GET /spaces' do
    it 'should get the list of spaces' do
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