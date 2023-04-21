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

  conn = PG.connect(
    dbname: 'makersbnb_test',
    host: '127.0.0.1'
  )

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
end





