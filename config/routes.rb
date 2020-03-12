Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :boxes, only: [:index, :show] do
    resources :box_lessons, only: [:index]
  end
  get 'map', to: 'boxes#map', as: :map

  resources :bookings, only: [:index, :destroy] do
    resources :reviews, only: [:create]
  end

  get "cancelled", to: 'bookings#cancelled', as: "cancelled"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
