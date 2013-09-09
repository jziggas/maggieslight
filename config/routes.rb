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

  get "/profiles/", to: "user_profiles#index"
  post '/page_feedbacks', to: "page_feedbacks#create"
  root :to => "care_receiver_profiles#index"
end
