Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#show'
      post '/users', to: 'users#create'
      post '/sessions', to: 'sessions#show'
      post '/favorites', to: 'favorites#create'

      get '/gifs', to: 'gifs#index'
    end
  end
end
