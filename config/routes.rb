Rails.application.routes.draw do

  namespace :admin do
    root to: "homes#top"

    resources :orders_details, only: [:update]
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :homes, only: [:top]
  end

  scope module: 'public' do

    root to: "homes#top"
    get "about" => "homes#about"

    # 会員
    get "customers/my_page" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
    get "customers/confirm" => "customers#confirm"
    patch "customers/withdraw" => "customers#withdraw"

    # 商品
    resources :items, only: [:index, :show]

    # カート
    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete '/cart_items/destroy_all', to: 'public/cart_items#destroy_all', as: 'cart_items_destroy_all'

    # 注文
    resources :orders, only: [:new, :create, :index, :show]
    post "orders/confirm" => "orders#confirm"
    get "orders/thanks" => "orders#thanks"

    # 住所
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]


  end

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }




  devise_for :users
end

