Tilannekuva::Application.routes.draw do
  devise_for :users
  root to: "units#index"
  
  get 'units/view' => 'units#view'
  get 'units/available' => 'units#available'
  get 'units/changeavailability' => 'units#changeavailability'
  get 'units/unit' => 'units#unit'

  resources :operations
  resources :events
  resources :locations
  resources :units
  resources :states
  resources :codes
  resources :types
  resources :events
  get 'unit' => 'units#index'
end
