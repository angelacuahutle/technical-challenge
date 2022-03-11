# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users do
    resources :queries, only: [:index, :new, :create, :show] # , defaults: {format: :html}
    get '/users/:user_id/queries/new', to: 'queries#new'
  end
  root 'queries#new'
  # For details on the DS :showL available within this file, see https://guides.rubyonrails.org/routing.html
  # namespace :api do
  #   namespace :v1 do
  #     resources :users, only: [:index] do
  #       resources :repositories, only: [:index]
  #     end
  #   end
  # end
end
