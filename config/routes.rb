Rails.application.routes.draw do
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[index]

  devise_scope :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end
  end
  root 'devise/sessions#new'
  # FIX FOR refreshing users/password/new after error resulted in No Route Error
  get 'users/password', to: redirect('/')
  match 'delete_profile_image', to: 'users#delete_profile_image', via: [:get]
  resources 'posts' do
    resources 'comments'
  end

  resources :friendships, only: %i[create update destroy]

  resources :likes, only: %i[create destroy]
end
