# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :plant do
    item_code "MyString"
    descripton "MyString"
    finishtime "MyText"
    expiration "MyText"
    parent_plant_id 1
  end
end
