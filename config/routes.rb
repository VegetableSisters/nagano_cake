Rails.application.routes.draw do
  root to: 'public/homes#top'

  namespace :admin do
    resources :orders_details, only: [:update]
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :homes, only: [:top]
  end

  namespace :public do
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :orders, only: [:new, :confirm, :thanks, :create, :index, :show]
    resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
    resources :customers, only: [:show, :edit, :update, :confirm, :withdraw]
    resources :items, only: [:index, :show]
  end

  devise_for :admins
  devise_for :customers
  devise_for :users
end

