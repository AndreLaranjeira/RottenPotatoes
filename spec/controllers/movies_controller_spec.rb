require 'rails_helper'

RSpec.describe MoviesController, type: :controller do

  describe 'similar_movies action' do

    before(:each) {
      @movie = FactoryBot.create(:movie, title: "Star Wars", director: "George Lucas")
      @movie2 = FactoryBot.create(:movie, title: "Alien", director: "")
      FactoryBot.create(:movie, title: "Blade Runner", director: "Ridley Scott")
      FactoryBot.create(:movie, title: "THX-1138", director: "George Lucas")
    }

    it 'calls a model method to obtain movie results' do
      @fake_results = [double('Movie'), double('Movie')]
      expect(Movie).to receive(:find_by_director).with(@movie).and_return(@fake_results)
      get :similar_movies, params: {id: @movie.id}
    end

    it 'makes the results available in an instance variable' do
      @fake_results = [double('Movie'), double('Movie')]
      expect(Movie).to receive(:find_by_director).and_return(@fake_results)
      get :similar_movies, params: {id: @movie.id}
      expect(assigns(:movies)).to eq(@fake_results)
    end

    it 'redirects the user home if there were no results' do
      get :similar_movies, params: {id: @movie2.id}
      expect(response).to redirect_to(movies_path)
    end

    it 'displays a message if there are no results' do
      get :similar_movies, params: {id: @movie2.id}
      expect(flash[:notice]).to eq("'Alien' has no director info")
    end

  end

end
