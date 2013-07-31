json.array!(@care_provider_profiles) do |care_provider_profile|
  json.extract! care_provider_profile, :name, :location, :field_of_study, :school, :skills, :misc, :contact_email, :contact_phone
  json.url care_provider_profile_url(care_provider_profile, format: :json)
end
