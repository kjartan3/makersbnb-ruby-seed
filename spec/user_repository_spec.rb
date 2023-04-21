require 'user'
require 'user_repository'
require 'bcrypt'


def reset_users_table # <-- possibly may need to change the user table create SQL so it enables table reset... unsure of this however
  seed_sql = File.read('spec/seeds/tables_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe UserRepository do 
  before(:each) do
    reset_users_table
  end
  
  describe '#all' do
    it 'lists all users' do
      repo = UserRepository.new
  
      users = repo.all
  
      expect(users.length).to eq(4)
      expect(users.first.email).to eq('user1@gmail.com')
      expect(users.first.password).to eq('12345')
    end
  end

        # it 'creates a new user' do
        #   repo = UserRepository.new

        #   new_user = User.new

        #   new_user.email = 'user5@gmail.com'
        #   new_user.password = 'mango'
        #   repo.create(new_user)

        #   users = repo.all

        #   expect(users.length).to eq(5)
        #   expect(users.last.email).to eq('user5@gmail.com')
        #   expect(users.last.password).to eq('mango')
        # end

  describe '#create' do
    it 'creates a new user using password encryption' do
      repo = UserRepository.new
      user = repo.create(
        email: 'user-test@gmail.com',
        password_hash: 'teddy'
      )
      users = repo.all
      # expect(user.id).to eq(5) <- come back to it if error occurs
      expect(user.email).to eq('user-test@gmail.com')

      expect(BCrypt::Password.new(user.password_hash)).to eq('teddy')
    end
  end
end
