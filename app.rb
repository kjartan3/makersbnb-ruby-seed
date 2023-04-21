require 'pg'
require 'bcrypt'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/space_repository'
require_relative 'lib/booking_repository'
require_relative 'lib/user_repository'

DatabaseConnection.connect('makersbnb_test')

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload "lib/space_repository"
  end
  # establishes database connection
  conn = PG.connect(
    dbname: 'makersbnb_test',
    host: '127.0.0.1'
  )
  enable :sessions
  # Render the signup form
  get '/' do
    erb :sign_up
  end
  # Handle form submission
  post '/' do
    email = params[:email]
    password = params[:password]
    # Insert user data into the database
    conn.exec_params("INSERT INTO users (email, password) VALUES ($1, $2)", [email, password])
    # Redirect to success page
    redirect '/sign_up_confirmation'
  end
  # Render success page
  get '/sign_up_confirmation' do
    erb :sign_up_confirmation
  end
  # get '/' do
  #   return erb(:sign_up)
  # end
  get '/sessions/new' do
    return erb(:login)
  end

  post '/sessions/new' do
    email_address = params[:email_address]
    password = params[:password]

    user = UserRepository.new.find_by_email(email_address)

    if user && user.password == password
      session[:email_address] = user.email_address
      #################################################################################################
      # DO SOMETHING LIKE 
      # repo = SpaceRepository.new
      # @peeps = repo.all
      # @user = user
      # erb(:spaces)
      #######################################################################################################

    else
      erb(:wrong_credentials)
    end
  end  
  get '/confirmation' do
    return erb(:sign_up_confirmation)
  end

  get '/spaces' do
    repo = SpaceRepository.new
    @spaces = repo.all
    return erb(:spaces)
    # side note: if spaces table is empty then expect to not see anything on localhost
    # before adding entries with a create method / or post request form 
  end

  get '/spaces/new' do
    return erb(:spaces_new)
  end

  post '/spaces' do
    repo = SpaceRepository.new
    new_space = Space.new
    new_space.name = params[:name]
    new_space.description = params[:description]
    new_space.price = params[:price]
    new_space.available_start = params[:available_start]
    new_space.available_end = params[:available_end]
    new_space.user_id = params[:user_id]
    repo.create(new_space)

    redirect '/spaces'
  end

  get '/requests' do
    repo = BookingRepository.new
    @requests = repo.all 
    #maybe @bookings? 
    get_inbound_requests
    get_outbound_requests
    return erb(:requests)
  end

  get "/requests/view" do
    repo = BookingRepository.new
    return erb(:view_request)
  end

  get "/requests/view/:id" do
    repo = BookingRepository.new
    id = params['id']
    # @returned_booking = repo.find(booking_id)
    # @returned_booking = 

    result = conn.exec_params('SELECT name FROM spaces WHERE id = $1', ['id'])
    booking = result.first
    # @space = space_repo.find(params[:name])
    #return erb :status { id: id, status: booking['status'], name: booking['name'] } # maybe change booking to space
    # return erb(:view_request)
  end # <-- conn.exec_param method included in this get request.

  post "/requests/view" do
    status = params['status'] # <-- maybe '@status'
    id = params['id'] 
    conn.exec_param('UPDATE bookings SET status = $1 WHERE id = $2', [status, id])
  end




  private 
  def get_inbound_requests
    #create params for specific user that is logged in
    @params = session[:user_id]
    # calling all method on Spaces
    @all_spaces = SpaceRepository.new.all
    # selecting spaces with user that is currently logged in
    @user_spaces = @all_spaces.select {|space| space.user_id == @params} 
    # creating an empty array to hold the list of space_ids connected to the user that is logged in 
    user_space_ids = []
    # it iterates over spaces and adds these id's to the array
    @user_spaces.each do |space|
      id = space.id
      user_space_ids << id
    end
    # creates a new variable to hold a list of all bookings
    @all_bookings = BookingRepository.new.all
    # creates array to hold bookings of the current user
    @inbound_bookings = []
    # iterates over the bookings and checks for a match of the current user's space id
    @all_bookings.each do |booking|
      if user_space_ids.include? booking.space_id
        @inbound_bookings << booking
      end
    end

    return @inbound_requests

  end

  def get_outbound_requests
    @outbound_bookings = []
    # iterating over all bookings, if it matches with logged in user it puts those into the array
    @all_bookings.each do |request|
      if request.user_id == @params
        @outbound_bookings << request
      end
    end
    return @outbound_bookings
  end

  # post '/' do
  #   email = params['email']
  #   password = ['password']
  #   password_hash = BCrypt::Password.create(password) # this password_hash may need to be changed to .create(password_hash)

  #   UserRepository.new.create(email: email, password_hash: password_hash)

  #   redirect '/confirmation'
  # end

   

  # post '/' do
  #   email = params[:email]
  #   password = params[:password]
  #   redirect 'confirmation'
  # end


  # post '/register' do
  #   username = params[:username]
  #   email = params[:email]
  #   password = params[:password]
  #   redirect '/'
  # end
end
