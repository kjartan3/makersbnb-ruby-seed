require_relative 'user.rb'
require 'bcrypt'

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
  
  def create(email:, password_hash:)
    password_hash = BCrypt::Password.create(password_hash)
    sql = 'INSERT INTO users (email, password_hash) VALUES ($1, $2);'
    result = DatabaseConnection.exec_params(sql, [password_hash, email])

    User.new(
      id: result[0]['id'].to_i,
      email: result[0]['email'],
      password_hash: result[0]['password_hash']
    )
  end

  def find_by_email(email)
    sql = 'SELECT id, email, password FROM users WHERE email = $1;'
    result_set = DatabaseConnection.exec_params(sql, [email])

    user = User.new
    user.id = result_set[0]['id']
    user.email = result_set[0]['email']
    user.password = result_set[0]['password']

    return user
  end
end
