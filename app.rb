require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:sign_up)
  end

  get '/sessions/new' do
    return erb(:login)
  end

  post '/' do
    email = params[:email]
    password = params[:password]
    redirect 'confirmation'
  
end

post '/register' do
  username = params[:username]
  email = params[:email]
  password = params[:password]
  redirect '/'
end