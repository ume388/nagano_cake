Rails.application.routes.draw do
  devise_for :customers, controlles: {
    sessions: "customers/sessions",
    registrations: "customers/registrations",
  }
  
  devise_for :admins, controlles: {
    sessions: "admins/sessions",
    registrations: "admins/registrations"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :public do
    root to: 'homes#top'
  end
  
  namespace :admin do
    root to: 'homes#top'
    resources :items
    resources :customers
    resources :orders
  end
  
end
