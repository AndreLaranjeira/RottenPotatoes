require 'rails_helper'

RSpec.describe Movie, type: :model do

  describe 'find_by_director function' do

    before(:each) {
      @movie1 = FactoryBot.create(:movie, title: "Star Wars", director: "George Lucas")
      @movie2 = FactoryBot.create(:movie, title: "Blade Runner", director: "Ridley Scott")
      @movie3 = FactoryBot.create(:movie, title: "THX-1138", director: "George Lucas")
      @movie4 = FactoryBot.create(:movie, title: "Alien", director: nil)
    }

    it 'returns a list of movies with the movie director if it exists' do
      expect(@movie1.find_by_director).to eq([@movie1, @movie3])
      expect(@movie2.find_by_director).to eq([@movie2])
    end

    it 'returns a empty list if the movie has no director' do
      expect(@movie4.find_by_director).to eq([])
    end

  end

end
