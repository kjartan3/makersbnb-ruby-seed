require_relative 'database_connection.rb'
require_relative 'space.rb'

class SpaceRepository
    def all
        sql = 'SELECT * FROM spaces;'
        result_set = DatabaseConnection.exec_params(sql,[])
        spaces = []
        result_set.each do |listing|
            space = Space.new
            space.id = listing['id']
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
    
    def create(space)
    sql = 'INSERT INTO spaces (name, description, available_start, available_end, price, user_id) VALUES ($1, $2, $3, $4, $5, $6);'
    sql_params = [space.name, space.description, space.available_start, space.available_end, space.price, space.user_id]
    DatabaseConnection.exec_params(sql, sql_params)
    end

end