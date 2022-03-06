# frozen_string_literal: true

Rails.application.routes.draw do
  resources :queries
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index] do
        resources :repositories, only: [:index]
      end
    end
  end
end
  