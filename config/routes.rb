Maggieslight::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  resources :care_provider_profiles

  resources :care_receiver_profiles

  root :to => "care_receiver_profiles#index"
  devise_for :users

  get "/profiles", to: "user_profiles#index"
end
