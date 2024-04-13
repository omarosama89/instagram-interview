Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  namespace :api , defaults: {format: :json} do
      # resources :clients, only: [:index]
      post '/clients/set_locale' => 'clients#set_locale'
      get '/clients/:username' => 'clients#index'
      get '/clients/check_username/:username' => 'clients#check_username'
      resources :services, only: [:index]
      resources :subscription_services, only: [:index]
      resources :notifications
      post '/subscriptions/create'
      get '/subscriptions/approve'
      get '/subscriptions/cancel'
      get '/subscriptions/get_price/:service_id/:likes_count/:posts_count' => 'subscriptions#get_price'
      resources :subscriptions, only: [:show]

      post '/order_rows/create'
      post '/order_rows/create_stripe'
      get '/order_rows/approve'
      get '/order_rows/cancel'
      get '/order_rows/get_price/:service_id/:amounts' => 'order_rows#get_price'
      get '/order_rows/get_status/:order_code' => 'order_rows#get_status'
      resources :order_rows, only: [:show]
      resources :reviews, only: [:create]
      resources :newsletters, only: [:create]
      resources :statistics, only: [:index]
      namespace :mob do
        post '/clients/set_locale' => 'clients#set_locale'
        get '/clients/:username' => 'clients#index'
        get '/clients/check_username/:username' => 'clients#check_username'
        resources :services, only: [:index]
        resources :subscription_services, only: [:index]
        resources :notifications
        post '/subscriptions/create'
        get '/subscriptions/approve'
        get '/subscriptions/cancel'
        get '/subscriptions/get_price/:service_id/:likes_count/:posts_count' => 'subscriptions#get_price'
        resources :subscriptions, only: [:show]

        post '/order_rows/create'
        get '/order_rows/new'
        get '/order_rows/canceled'
        get '/order_rows/success'
        get '/order_rows/not_authorized'
        get '/order_rows/unknown'
        post '/order_rows/create_stripe'
        get '/order_rows/approve'
        get '/order_rows/cancel'
        get '/order_rows/get_price/:service_id/:amounts' => 'order_rows#get_price'
        get '/order_rows/get_status/:order_code' => 'order_rows#get_status'
        resources :order_rows, only: [:show]
        resources :reviews, only: [:create]
        resources :newsletters, only: [:create]
        resources :statistics, only: [:index]
      end
    end
end
