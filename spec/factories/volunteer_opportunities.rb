# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :volunteer_opportunity do
    org_name "MyString"
    event_type "MyString"
    description "MyString"
    contact_phone "MyString"
    contact_name "MyString"
    contact_email "MyString"
    event_start "2014-05-22 22:40:36"
    event_end "2014-05-22 22:40:36"
    user_id 1
    agree_terms false
    ein "MyString"
    type_of_org "MyString"
    title "MyString"
    location "MyString"
  end
end
