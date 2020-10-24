Rails.application.routes.draw do
  get 'bookmarks/create'
  get 'bookmarks/destroy'
  root 'home#top'
  get 'home/about'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :users, only: [:index, :show, :edit, :update]
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
  resources :notifications, only: [:index, :destroy]

  post 'follow/:id' => 'relationships#follow', as: 'follow' 
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' 
  get 'follower/:id' => 'relationships#follower', as: 'follower'
  get 'followed/:id' => 'relationships#followed', as: 'followed'
  get 'user/:id/favorite' => 'users#favorite', as: 'favorite'
  get 'user/:id/bookmark' => 'users#bookmark', as: 'bookmark'
  get 'search' => 'search#search'
  get '/post/hashtag/:name' => 'posts#hashtag', as: 'hashtag'
  get '/post/category/:name' => 'posts#category', as: 'category'
  get '/post/prefecutre' => 'posts#prefecture', as: 'prefecture'
  get '/post/map' => 'posts#map', as: 'map'
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
end
