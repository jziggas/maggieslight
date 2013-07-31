# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :care_provider_profile do
    name "MyString"
    location "MyString"
    field_of_study "MyString"
    school "MyString"
    skills "MyString"
    misc "MyString"
    contact_email "MyString"
    contact_phone "MyString"
  end
end
