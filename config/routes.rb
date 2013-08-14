Maggieslight::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  #resources :care_provider_profiles

  #resources :care_receiver_profiles
  resources 'those-who-care', as: :care_provider_profiles, controller: :care_provider_profiles do
      member do
        get 'flag'
      end
    end

  resources 'those-in-need', as: :care_receiver_profiles, controller: :care_receiver_profiles do
      member do
        get 'flag'
      end
    end

  devise_for :users

  get "/profiles/", to: "user_profiles#index"
  # get "/care-givers/", to: "care_provider_profiles#index"
  # get "/care-receivers/", to: "care_receiver_profiles#index"
  # /care-receivers/id
  # /care-givers/id
  # /care-receivers/id/edit
  root :to => "care_receiver_profiles#index"

  # match "providers/:id/:action" => "care_provider_profiles#"
end
