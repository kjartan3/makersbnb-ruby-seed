require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/space_repository.rb'

DatabaseConnection.connect('makersbnb')


class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload "lib/space_repository"
  end

  get '/spaces' do
    repo = SpaceRepository.new
    @spaces = repo.all
    return erb :spaces
    # side note: if spaces table is empty then expect to not see anything on localhost
    # before adding entries with a create method / or post request form 
  end
end
