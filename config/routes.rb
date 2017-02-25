Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "breweries#index"
  get 'kaikki_bisset', to: 'beers#index'
  # get 'ratings', to: 'ratings#index'
  # get 'ratings/new', to: 'ratings#new'
  # post 'ratings', to: 'ratings#create'

  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]

  delete "memberships", to: "memberships#destroy"
  get 'signin', to: 'sessions#new'
  get 'signup', to: 'users#new'
  delete 'signout', to: 'sessions#destroy'

  resources :places, only:[:index, :show]
  post 'places', to:'places#search'

  resources :breweries do
    post 'toggle_activity', on: :member
  end

  resources :users do
    post 'toggle_block', on: :member
  end

end
