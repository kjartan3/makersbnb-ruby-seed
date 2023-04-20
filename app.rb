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
    DatabaseConnection.exec_params("INSERT INTO users (email, password) VALUES ($1, $2)", [email, password])
  
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

  get '/spaces' do
    return erb(:spaces)
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