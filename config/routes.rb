Maggieslight::Application.routes.draw do
  resources :care_provider_profiles

  resources :care_receiver_profiles

  root :to => "home#index"
  devise_for :users
end
