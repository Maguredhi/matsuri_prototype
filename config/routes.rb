Rails.application.routes.draw do
  devise_for :users
  root "pages#top"

  resources :events, only: [:index, :show]
  resources :news, only: [:index, :show]

  namespace :admin do
    root 'events#index'
    resources :events
    resources :news
  end
end
