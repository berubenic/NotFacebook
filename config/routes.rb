Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  # FIX FOR refreshing users/password/new after error resulted in No Route Error
  get 'users/password', to: redirect('/')

  resources 'posts' do
    resources 'comments'
  end

  resources :friends, only: [:index], controller: 'users'

  resources :friendships, only: %i[index create update destroy]
end
