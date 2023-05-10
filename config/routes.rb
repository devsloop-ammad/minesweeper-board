# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'boards#new'

  resources :boards, only: %i[index new create show]
end
