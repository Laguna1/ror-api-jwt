FactoryBot.define do
  factory :track do
    item
    name { 'Name' }
    distance { 100 }
    duration { 30 }
    repeat { 2 }
  end
end
