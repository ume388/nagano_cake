Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }
  
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }
  
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'
  get 'items' => 'public/items#index'
  get 'items/:id' => 'public/items#show'
  
  namespace :public do
  end
  
  namespace :admin do
    root to: 'homes#top'
    resources :items
    resources :customers
    resources :orders
  end
  
end
