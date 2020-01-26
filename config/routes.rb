# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :users, only: [:create]
    get '/users/my', to: 'users#show'
    delete '/users/my', to: 'users#destroy'
    resources :authentication, only: [:create]

    scope shallow_path: 'todo_lists' do
      resources :todo_lists do
        resources :todo_items, shallow: true, only: %i[index create]
      end
    end
    resources :todo_items, only: %i[show update destroy]
  end
end
