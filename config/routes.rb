Rails.application.routes.draw do

  namespace :public do
    get 'cart_items/index'
  end
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
    get 'customers/confirm_withdrawal' => 'customers#confirm_withdrawal'
    resources :cart_items, only: [:index]
  end

  #管理者側
  namespace :admin do
  get '/' => 'homes#top'
  end

end
