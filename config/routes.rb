Rails.application.routes.draw do
  resources :users, only: [:index, :edit, :update]
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        passwords: 'users/passwords',
        registrations: 'users/registrations'
      }
  devise_scope :user do
     get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :courses do
    resources :subscriptions, only: [:new, :create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  root "pages#index"
end
