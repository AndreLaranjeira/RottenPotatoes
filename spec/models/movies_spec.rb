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
      expect(Movie.find_by_director(@movie1)).to eq([@movie1, @movie3])
      expect(Movie.find_by_director(@movie2)).to eq([@movie2])
    end

    it 'returns a empty list if the movie has no director' do
      expect(Movie.find_by_director(@movie4)).to eq([])
    end

  end

end
