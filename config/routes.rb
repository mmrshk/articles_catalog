# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  root to: 'admin#show'
end
