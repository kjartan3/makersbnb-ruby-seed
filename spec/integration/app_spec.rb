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
      expect(response.body).to include('<form method="post" action="/">')
      expect(response.body).to include('<input type="email" id="email" name="email" required>')
      expect(response.body).to include('<input type="password" id="password" name="password" required>')
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

  context 'GET /confirmation' do # sign up page
    it 'should display account confirmation' do
      response = get('/confirmation')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>You have now made an account with MakersBNB</h1>')
      expect(response.body).to include('<a href="/sessions/new" class="button"> Click here to login </a>')
    end
  end

  context 'POST /' do
    it 'creates a new user' do
      response = post('/', params: { email: 'user@example.com', password: 'teddy' }) # <-- added this

      expect(response.status).to eq(302) # <-- 302 used for redirect response (IF NEEDED)
      expect(user_repository.new.all.length).to eq(4)
      expect(user_repository.new.all.last.email).to eq('user@example.com')
      expect(user_repository.new.all.last.password).to eq('teddy')
    end
  end


  #   xit 'save data to database' do
  #     post('/confirmation', email: 'user1@gmail.com', password: '12345')
  #     expect(last_response).to be_redirect
  #     follow_redirect!
  #     expect(last_request.path).to eq('/confirmation')
  #   end
  # end 
end


# context 'GET /register' do
#   it "displays the register form" do
#     get '/register'
#     expect(last_response).to be_ok # wouldn't work as .to eq 200 as GET /register route is failing because the response status is not equal to 200. It looks like the response is returning a Rack::MockResponse object, which is not equal to the integer value 200.
#     expect(last_response.body).to include("Name")
#     expect(last_response.body).to include("Email")
#     expect(last_response.body).to include("Password")
#   end

#   it "registers in the user" do
#     post '/register',username:'Username', email: 'user@example.com', password: 'password'
#     expect(last_response).to be_redirect
#     follow_redirect!
#     expect(last_request.path).to eq('/')
#   end
# end