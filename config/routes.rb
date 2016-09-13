Rails.application.routes.draw do
  get 'about/index'

  devise_for :users, :controllers => {
    :sessions => 'sessions'
  }
  resources :feeds
  root 'feeds#index'
end
