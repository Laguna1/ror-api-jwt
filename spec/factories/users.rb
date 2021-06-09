FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 5..20) }
    pasword_digest { 'password' }
  end
end
