Rails.application.routes.draw do
  root 'home#top'
  get 'home/about'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :users, only: [:index, :show, :edit, :update]
  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
end
