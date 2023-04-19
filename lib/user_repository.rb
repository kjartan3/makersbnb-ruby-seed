require_relative 'user'

class UserRepository
  def all
    users = []

    sql = 'SELECT id, email, password FROM users;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      user = User.new
      user.id = record['id']
      user.email = record['email']
      user.password = record['password']

      users << user
    end
  end

  def find(id)
    sql = 'SELECT id, email, password FROM users WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])

    user = User.new
    
    user.id = result_set[0]['id']
    user.email = result_set[0]['email']
    user.password = result_set[0]['password']

    return user
  end

  def create(user)
    encrypted_password = BCrypt::Password.create(user.password)
    sql = 'INSERT INTO user (email, password) VALUES ($1, $2);'
    result_set = DatabaseConnection.exec_params(sql, [user.email, encrypted_password])

    return user
  end
end