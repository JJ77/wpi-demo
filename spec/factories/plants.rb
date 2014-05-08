# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :plant do
    item_code "I_code"
    description "plant"
    finishtime ["20", "20", "21"]
    expiration ["8", "8", "8"]
    parent_plant_id 1
  end
end
