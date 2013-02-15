require 'resque/server'

Board::Application.routes.draw do
  root to: 'home#index'
  filter :locale
  devise_for :users, controllers: {sessions: "sessions"}

  resources :tags, only: [:index, :show]
  
  resources :items, only: [:index, :show] do
    resources :messages, :only => [:new, :create]
  end

  namespace :dashboard do
    resources :items do
      resources :photos
      resources :messages
    end
    resources :messages
    resources :card, only: [:index, :create]
    resources :buying_item, only: [:show]
    resources :transactions, only: [:index, :destroy]
  end

  resources :users

  namespace :admin do
    resources :photos, only: [] do
      resource :ban, only: [:new, :create, :destroy], controller: 'ban_photos'
    end

    resources :users, only: [] do
      resource :ban, only: [:new, :create, :destroy], controller: 'ban_users'
    end

    resource :sessions, only: [:create]

    resources :items, only: [:edit, :update]
  end
  
  mount Resque::Server, :at => "/resque"
end
