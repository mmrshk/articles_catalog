# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  authenticate :user, lambda { |user| user.is_a?(Admin) } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'redirect#index'

  resources :admins, only: :show
  resources :readers, only: :show
  resources :articles do
    member do
      post 'activate'
    end
  end

  resources :article_attachments do
    collection do
      post 'upload'
    end
  end
end
