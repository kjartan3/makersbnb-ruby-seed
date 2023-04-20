require 'pg'
require 'bcrypt'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'


class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
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