Maggieslight::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources 'those-who-care',
  as: :care_provider_profiles,
  controller: :care_provider_profiles do

    member do
      get 'flag'
    end

    resources :connections

  end

  resources 'those-in-need',
  as: :care_receiver_profiles,
  controller: :care_receiver_profiles do

    member do
      get 'flag'
    end

    resources :connections

  end


  devise_for :users

  get "/profiles/", to: "user_profiles#index"

  root :to => "care_receiver_profiles#index"

end
