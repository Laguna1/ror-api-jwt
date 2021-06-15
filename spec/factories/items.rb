FactoryBot.define do
    factory :item do
      sequence(:day) { |n| n.days.ago }
      user
    end
  end