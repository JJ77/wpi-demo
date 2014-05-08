# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bed do
    name "MyString"
    capacity 1000
    greenhouse
    location
  end
end
