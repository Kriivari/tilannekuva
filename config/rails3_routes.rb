Tilannekuva::Application.routes.draw do
  resources :operations
  resources :events
  resources :locations
  resources :units
  match 'units/view' => 'unit#view'
  match 'units/available' => 'unit#available'
  match 'units/unit' => 'unit#unit'
  resources :states
  resources :codes
  resources :types
  resources :events
  match 'unit' => 'unit#index'
  match '/' => 'units#index'
  match '/:controller(/:action(/:id))'
end
