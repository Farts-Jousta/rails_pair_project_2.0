Rails.application.routes.draw do
  resources :comments
  devise_for :users
  resources :tracks
  resources :albums
  resources :artists

  get '/' => "artists#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
