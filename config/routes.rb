Maggieslight::Application.routes.draw do

  devise_for :users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources 'student-caregivers', as: :care_provider_profiles,
    controller: :care_provider_profiles do
      member do
        get 'flag'
      end
    end

  resources 'family-individual-ads', as: :care_receiver_profiles,
    controller: :care_receiver_profiles do
      member do
        get 'flag'
      end
    end

  resources 'volunteer-opportunities', as: :volunteer_opportunities,
    controller: :volunteer_opportunities do
      member do
        get 'flag'
      end
    end

  resources :employment_surveys, only: [:new, :create, :edit, :update]

  get "/profiles/", to: "user_profiles#index"
  post '/page_feedbacks', to: "page_feedbacks#create"
  root :to => "care_receiver_profiles#index"
end
