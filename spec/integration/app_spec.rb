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
      expect(response.body).to include('House of Horrors')
      expect(response.body).to include('2023-07-04')
      expect(response.body).to include('2023-08-31')
    end
  end

  context 'GET /spaces/new' do
    it 'allows user to list a space' do
      response = get('/spaces/new')

      expect(response.status).to eq(200)
      expect(response.body).to include('<input type="text" name="name">')
      expect(response.body).to include('<input type="text" name="description">')
      expect(response.body).to include('<input type="date" name="available_from">')
      expect(response.body).to include('<input type="date" name="available_to">')
      expect(response.body).to include('<input type="number" name="price">')
    end
  end
      
end