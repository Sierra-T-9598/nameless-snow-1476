Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :mechanics
  post '/mechanics/:id/rides', to: 'ride_mechanics#create'
end
