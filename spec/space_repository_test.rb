require_relative '../lib/space_repository.rb'
require_relative '../lib/space.rb'

def reset_space_table
    seed_sql = File.read('spec/seeds/tables_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
  end
  
  describe SpaceRepository do
    before(:each) do 
      reset_space_table
    end

    describe '#all' do
        it 'returns a list of all spaces' do
            repo = SpaceRepository.new
            space_list = repo.all
            expect(space_list.length).to eq 3
            expect(space_list[0].description).to eq 'Haunted house with friendly ghost'
        end
    end
end

