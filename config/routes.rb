#Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#end
Myrottenpotatoes::Application.routes.draw do
  resources :movies
  get '/movies/:id/similar_movies', to: 'movies#similar_movies',
                                    as: 'similar_movies'
  root :to => redirect('/movies')
end
