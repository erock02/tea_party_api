FactoryBot.define do
  factory :tea do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    temperature { Faker::Number.between(from: 0, to: 100)}
    brew_time { Faker::Number.between(from: 0, to: 50)}
  end
end
