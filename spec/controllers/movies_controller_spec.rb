require 'rails_helper'

RSpec.describe MoviesController, type: :controller do

  describe 'similar_movies action' do

    before(:each) {
      @movie = FactoryBot.create(:movie, title: "Star Wars", director: "George Lucas")
      FactoryBot.create(:movie, title: "Blade Runner", director: "Ridley Scott")
      FactoryBot.create(:movie, title: "THX-1138", director: "George Lucas")
    }

    it 'calls a model method to obtain movie results' do
      expect(Movie).to receive(:find_by_director).with("George Lucas")
      get :similar_movies, params: {id: @movie.id}
    end

    it 'makes the results available in an instance variable' do
      @fake_results = [double('Movie'), double('Movie')]
      expect(Movie).to receive(:find_by_director).and_return(@fake_results)
      get :similar_movies, params: {id: @movie.id}
      expect(assigns(:movies)).to eq(@fake_results)
    end

    it 'displays a list of results if there are results'
    it 'redirects the user home if there were no results'

  end

end
