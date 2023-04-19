require 'user'
require 'user_repository'


def reset_users_table
  seed_sql = File.read('spec/seeds/tables_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe UserRepository do 
  before(:each) do
    reset_users_table
  end
  
  it 'lists all users' do
    repo = UserRepository.new

    users = repo.all

    expect(users.length).to eq(4)
    expect(users.first.email).to eq('user1@gmail.com')
    expect(users.first.password).to eq('12345')
  end

  it 'creates a new user' do
    repo = UserRepository.new

    new_user = User.new

    new_user.email = 'user5@gmail.com'
    new_user.password = 'mango'
    repo.create(new_user)

    users = repo.all

    expect(users.length).to eq(5)
    expect(users.last.email).to eq('user5@gmail.com')
    expect(users.last.password).to eq('mango')
  end
end
