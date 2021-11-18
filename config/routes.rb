# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'Account', at: 'auth', controllers: {
    sessions: 'auth/sessions',
    token_validations: 'devise_token_auth/token_validations'
  }

  post 'send-money' => 'account#send_money'
  get 'history' => 'account#history'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end