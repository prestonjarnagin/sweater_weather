Rails.application.routes.draw do

  get '/', to: redirect('/api/v1/')

  namespace :api do
    namespace :v1 do
      get '/', to: 'welcome#show'
      get '/forecast', to: 'forecast#show'
      get '/favorites', to: 'favorites#index'
      get '/gifs', to: 'gifs#index'

      post '/users', to: 'users#create'
      post '/sessions', to: 'sessions#show'
      post '/favorites', to: 'favorites#create'

      delete '/favorites', to: 'favorites#delete'

    end
  end
end
