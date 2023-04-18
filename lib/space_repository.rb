require_relative 'database_connection.rb'
require_relative 'space.rb'

class SpaceRepository
    def all
        sql = 'SELECT * FROM spaces;'
        result_set = DatabaseConnection.exec_params(sql,[])
        spaces = []
        result_set.each do |listing|
            space = Space.new
            space.name = listing['name']
            space.description = listing['description']
            space.available_start = listing['available_start']
            space.available_end = listing['available_end']
            space.price = listing['price']
            space.user_id = listing['user_id']
            spaces << space
        end
        return spaces
    end
end