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

  get '/spaces/:id' do
    repo = SpaceRepository.new
    @space = repo.find(params[:id])
    return erb(:space_id)
  end
end
