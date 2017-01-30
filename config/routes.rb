Tilannekuva::Application.routes.draw do
  resources :operations
  resources :events
  resources :locations
  resources :units
  get 'units/view' => 'unit#view'
  get 'units/available' => 'unit#available'
  get 'units/unit' => 'unit#unit'
  resources :states
  resources :codes
  resources :types
  resources :events
  get 'unit' => 'unit#index'
  get '/' => 'units#index'
  get '/:controller(/:action(/:id))'
end
