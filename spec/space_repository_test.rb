require_relative '../lib/space_repository.rb'
require_relative '../lib/space.rb'
require 'spec_helper'
require 'rack/test'

def reset_space_table
  seed_sql = File.read('spec/seeds/tables_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe SpaceRepository do

  include Rack::Test::Methods

  let(:app) { Application.new }


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

  it 'creates a new space' do 
    repo = SpaceRepository.new
    new_space = Space.new
    new_space.name = "Bowser's Castle"
    new_space.description = "Original stone floors, with Bowser army optional"
    new_space.available_start = "2023-01-01"
    new_space.available_end = "2023-12-03"
    new_space.price = 300
    new_space.user_id = 1
    repo.create(new_space)
    space_list = repo.all
    expect(space_list.length).to eq 4
    expect(space_list[3].description).to eq 'Original stone floors, with Bowser army optional'
  end
end

