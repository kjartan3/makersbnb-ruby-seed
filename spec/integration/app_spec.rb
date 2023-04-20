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
    it 'returns the form in order to list a space' do
      response = get('/spaces/new')

      expect(response.status).to eq(200)
      expect(response.body).to include('<input type="text" name="name">')
      expect(response.body).to include('<input type="text" name="description">')
      expect(response.body).to include('<input type="date" name="available_start">')
      expect(response.body).to include('<input type="date" name="available_end">')
      expect(response.body).to include('<input type="number" name="price">')
    end
  end

  context 'GET/spaces/:id' do 
    it 'displays the details of the space 1' do
      response = get('/spaces/1')

      expect(response.status).to eq(200)
      expect(response.body).to include('House of Horrors')
      expect(response.body).to include('Haunted house with friendly ghost')
    end

    it 'displays the details of the space 2' do
      response = get('/spaces/2')
  
      expect(response.status).to eq(200)
      expect(response.body).to include('House of Dreams')
      expect(response.body).to include('Lovely house with a terrace top')
    end
  end

  context 'POST /spaces' do
    it 'saves new space to database' do
      response = post('/spaces', name: 'Cottage Green', description: 'Lovely green space with cottage', price: 75, available_start: '2023-06-05', available_end: '2023-06-10')
      expect(response.status).to eq(302)
      
      response = get('/spaces')
      expect(response.body).to include('Cottage Green')
    end
  end
end