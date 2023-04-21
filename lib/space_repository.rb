require_relative 'space'

class SpaceRepository
  def all
    spaces = []
  
    sql = 'SELECT id, name, description, available_start, available_end, price, user_id FROM spaces;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      space = Space.new
      space.id = record['id']
      space.name = record['name']
      space.description = record['description']
      space.available_start = record['available_start']
      space.available_end = record['available_end']
      space.price = record['price']
      space.user_id = record['user_id']

      spaces << space
    end
    return spaces
  end

  def find(id)
    sql = 'SELECT id, name, description, available_start, available_end, price, user_id FROM spaces WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])

    space = Space.new

    space.id = result_set[0]['id']
    space.name = result_set[0]['name']
    space.description = result_set[0]['description']
    space.available_start = result_set[0]['available_start']
    space.available_end = result_set[0]['available_end']
    space.price = result_set[0]['price']
    space.user_id = result_set[0]['user_id']

    return space
  end

  def create(space)
    sql = 'INSERT INTO space (name, description, available_start, available_end, price, user_id) VALUES ($1, $2, $3, $4, $5, $6);'
    result_set = DatabaseConnection.exec_params(sql, [space.name, space.description, space.available_start, space.available_end, space.price, space.user_id])

    return space
  end
end


  require_relative 'database_connection'
require_relative 'space'

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

    def find(id)
        sql = 'SELECT id, name, description, available_start, available_end, price, user_id FROM spaces WHERE id = $1;'
        result_set = DatabaseConnection.exec_params(sql, [id])
    
        space = Space.new
    
        space.id = result_set[0]['id']
        space.name = result_set[0]['name']
        space.description = result_set[0]['description']
        space.available_start = result_set[0]['available_start']
        space.available_end = result_set[0]['available_end']
        space.price = result_set[0]['price']
        space.user_id = result_set[0]['user_id']
    
        return space
    end
    

    def create(space)
    sql = 'INSERT INTO spaces (name, description, available_start, available_end, price, user_id) VALUES ($1, $2, $3, $4, $5, $6);'
    sql_params = [space.name, space.description, space.available_start, space.available_end, space.price, space.user_id]
    DatabaseConnection.exec_params(sql, sql_params)
    end

end