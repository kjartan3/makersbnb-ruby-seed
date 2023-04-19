require 'user'

class UserRepository 
  def all 
    users = []
    sql = 'SELECT * FROM users;'
    result_set = DatabaseConnection.exec_params(sql,[])

    result_set.each do |record|
      user = User.new
      user.id = record['id'].to_i
      user.email = record['email']
      user.password = record['password']

      users << user
    end
    return users
  end

  def create(user)
    sql = 'INSERT INTO users (email, password) VALUES ($1, $2);'
    result_set = DatabaseConnection.exec_params(sql, [user.email, user.password])
  end
end
