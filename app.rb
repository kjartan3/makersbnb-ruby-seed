require 'sinatra/base'
require 'sinatra/reloader'

# this is the application class (remove this comment, just testing git branches)

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end
end

