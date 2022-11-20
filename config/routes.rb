require 'sidekiq/web'

Rails.application.routes.draw do
  scope :api do
    resources :articles
    resources :authors
    mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app
  end
end