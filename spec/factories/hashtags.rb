FactoryBot.define do
  factory :hashtag do
    hashname { Faker::Lorem.characters(number:20) }
  end
end