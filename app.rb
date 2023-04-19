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
  end

  get '/requests' do


    return erb(:requests)
  end
end

private 
  def requests_received 
    @params = session[:user_id]

    @all_spaces = SpaceRepository.new.all

    @user_spaces = @all_spaces.select {|space| space.user_id == @params}
   

  end



