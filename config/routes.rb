# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :users, only: [:create]
    get '/users/my', to: 'users#show'
    resources :authentication, only: [:create]
    resources :todo_lists
  end
end
