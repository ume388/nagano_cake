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
  
  scope module: 'public' do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :items, only: [:show, :index]
    resources :cart_items
    resources :orders do
      post :confirm, on: :collection
      get :complete, on: :collection
    end
    get 'customers/my_page', to: 'customers#show'
    get 'customers/edit' => 'customers#edit'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
  end
  
  namespace :public do
  end
  
  namespace :admin do
    root to: 'homes#top'
    resources :items
    resources :customers
    resources :orders
  end
  
end
