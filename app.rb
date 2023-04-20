require 'pg'
require 'bcrypt'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/user_repository'
require_relative 'lib/database_connection'

DatabaseConnection.connect('makersbnb')


class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

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

  post '/sessions/new' do
    email = params[:email]
    password = params[:password]

    user_repo = UserRepository.new

    user = user_repo.find_by_email(email)
    stored_password = BCrypt::Password.new(user.password)

    if stored_password == password
      session[:user_id] = user.id
      return erb(:login_success)
    else
      return erb(:wrong_credentials)
    end
  end   

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