# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :projection do
    plant nil
    entry nil
    pots 1
    finish_week 1
    delay_week 1
  end
end
