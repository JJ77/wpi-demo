# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entry do
    pots 1
    stick_week 1
    hang_week 1
    finish_week 1
    rating 1
    status 1
    plant
    bed
    greenhouse
    location
  end
end
