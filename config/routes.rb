Maggieslight::Application.routes.draw do
  resources :care_provider_profiles

  resources :care_receiver_profiles

  root :to => "care_receiver_profiles#index"
  devise_for :users
end
