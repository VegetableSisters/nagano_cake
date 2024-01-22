Rails.application.routes.draw do
  namespace :admin do
    root to: "homes#top"
    resources :orders_details, only: [:update]
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :homes, only: [:top]
  end

  scope module: 'public' do
    root to: "homes#top"
    get "about" => "homes#about"
    get "customers/my_page" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
    get "customers/confirm" => "customers#confirm"
    patch "customers/withdraw" => "customers#withdraw"
    resources :items, only: [:index, :show] do
      get 'genre/:id', to: 'items#genre', as: 'genre_specific', on: :collection
    end
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      delete :destroy_all, on: :collection
    end
    get "orders/thanks" => "orders#thanks"
    resources :orders, only: [:new, :create, :index, :show]
    post "orders/confirm" => "orders#confirm"
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  end

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users
end
