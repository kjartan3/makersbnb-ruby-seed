require 'pg'
require 'bcrypt'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/space_repository'

DatabaseConnection.connect('makersbnb_test')



class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload "lib/space_repository"
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

  get '/confirmation' do
    return erb(:sign_up_confirmation)
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
