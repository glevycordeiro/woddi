Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :boxes, only: [:index, :show] do
    resources :box_lessons, only: [:index]
  end
  get 'map', to: 'boxes#map', as: :map

  resources :bookings, only: [:index, :create, :destroy] do
    resources :reviews, only: [:create]
  end

  get "cancelled", to: 'bookings#cancelled', as: "cancelled"
  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end

  mount StripeEvent::Engine, at: '/stripe-webhooks'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
