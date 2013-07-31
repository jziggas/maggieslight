# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :care_receiver_profile do
    name "MyString"
    birthday "2013-07-29"
    gender "MyString"
    disabilities "MyString"
    hobbies "MyString"
    services_needed "MyString"
    misc "MyString"
    hours_needed "MyString"
    days_needed "MyString"
    location "MyString"
    transportation "MyString"
    contact_name "MyString"
    contact_email "MyString"
    contact_phone "MyString"
  end
end
