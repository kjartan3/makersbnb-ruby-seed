require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }


  context 'GET /' do
    it 'should display signup as the homepage' do
      response = get('/')

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/">')
      expect(response.body).to include('<input type ="text" name ="Email" required />')
      expect(response.body).to include('<input type ="text" name ="Password" required />')
      expect(response.body).to include('<input type ="text" name ="Password Confirmation" required />')
    end
  end

  context 'GET /sessions/new' do
    it 'should display login page' do
      response = get('/sessions/new')

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/sessions/new">')
      expect(response.body).to include('<input type ="text" name ="Email" required />')
      expect(response.body).to include('<input type ="text" name ="Password" required />')
    end
  end

  context 'POST /confirmation' do 
    it 'should display account confirmation and save to database' do
      post('/confirmation', email: 'user1@gmail.com', password: '12345')
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/confirmation')
    end
  end 
end
