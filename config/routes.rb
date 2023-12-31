Rails.application.routes.draw do

  # device顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # device管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #顧客側
  scope module: :public do
    root to: "homes#top"
    get '/about' => 'homes#about'
    resources :items, only: [:index, :show]
    get 'customers/mypage' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/confirm_withdrawal' => 'customers#confirm_withdrawal'
    patch 'customers/withdrawal' => 'customers#withdrawal'
    resources :cart_items, only: [:create, :index, :update, :destroy]
    delete 'cart_items/:id/destroy_all' => 'cart_items#destroy_all', as: 'cart_items_destroy_all'
    resources :addresses, only: [:create, :index, :edit, :update, :destroy]
    resources :orders, only: [:new, :create, :index, :show]
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/thanks' => 'orders#thanks'
  end

  #管理者側
  namespace :admin do
  get '/' => 'homes#top'
  resources :items, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :genres, only: [:new, :create, :index, :edit, :update, :destroy]
  resources :customers, only: [:index, :show, :edit, :update]
  resources :orders, only: [:show, :update, :destroy]
  resources :orders_details, only: [:update]
  end

end
