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
  end

  context "GET /requests" do
    it 'should display signup as the requests page' do
      response = get('/requests')
      
      expect(response.status).to eq(200)
      expect(response.body).to include('Sign up')
      expect(response.body).to include('Sign up with your email and password')

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
      expect(response.body).to include('Requests')
      expect(response.body).to include("Requests I've made")
      expect(response.body).to include("Requests received")
      
    end
     # until user is logged in, we cannot test this, so we need the login feature to be implemented first.
    xit 'when you log in with user_id 3 you should display one request made' do
      response = get('/requests/3')

      expect(response.status).to eq(200)
      expect(response.body).to include("<p>House of Dreams</p>")
      expect(response.body).to include("<p>Approved</p>")
      expect(response.body).to include("<p>2023-07-06</p>")
    end
    # until user is logged in, we cannot test this, so we need the login feature to be implemented first.
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

  context 'POST /' do
    it 'creates a new user' do
      response = post('/', params: { email: 'user@example.com', password: 'teddy' }) # <-- added this

      expect(response.status).to eq(302) # <-- 302 used for redirect response (IF NEEDED)
      expect(user_repository.new.all.length).to eq(4)
      expect(user_repository.new.all.last.email).to eq('user@example.com')
      expect(user_repository.new.all.last.password).to eq('teddy')
    end
  end
end  

      
    

# ^ issue with database auto-rolling back to original number, so test expectation isnt consistent.
  # additionally, solution to fixing reset_table issue in database was suggested in rspec test...
  # To do this, first update your `reset_tables.rb` file to include the column:
  #   def reset_tables(db) # Add to this existing method
  #     # ...
  #     db.run("DROP IF EXISTS TABLE ;")
  #     db.run("CREATE TABLE  (id SERIAL PRIMARY KEY, ...);") # Include your column here
  #     # ...
  #   end
  # Then run:
  #   ruby reset_tables.rb
  #   xit 'save data to database' do
  #     post('/confirmation', email: 'user1@gmail.com', password: '12345')
  #     expect(last_response).to be_redirect
  #     follow_redirect!
  #     expect(last_request.path).to eq('/confirmation')
  #   end



      
