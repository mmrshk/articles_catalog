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

  scope module: 'admins' do
    resources :admins, only: :show

    resources :articles, except: %i[index show] do
      member do
        post 'activate'
      end
    end

    resources :article_uploads do
      collection do
        post 'upload'
      end
    end
  end

  scope module: 'readers' do
    resources :readers, only: :show
    resources :articles, only: %i[index show] do
      collection do
        get 'search'
      end
    end
  end
end
