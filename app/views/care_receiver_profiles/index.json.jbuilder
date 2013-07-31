json.array!(@care_receiver_profiles) do |care_receiver_profile|
  json.extract! care_receiver_profile, :name, :birthday, :gender, :disabilities, :hobbies, :services_needed, :misc, :hours_needed, :days_needed, :location, :transportation, :contact_name, :contact_email, :contact_phone
  json.url care_receiver_profile_url(care_receiver_profile, format: :json)
end
