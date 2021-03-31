Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions: "customers/sessions",
    registrations: "customers/registrations",
  }
  
  devise_for :admins, controllers: {
    sessions: "admins/sessions",
    registrations: "admins/registrations"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'
  get 'items' => 'public/items#index'
  
  namespace :public do
  end
  
  namespace :admin do
    root to: 'homes#top'
    resources :items
    resources :customers
    resources :orders
  end
  
end
