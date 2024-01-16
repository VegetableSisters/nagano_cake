Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers
  devise_for :users
 root to: 'homes#top'
end
