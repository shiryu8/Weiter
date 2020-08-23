require "refile/file_double"
FactoryBot.define do
  factory :article do
    title { Faker::Lorem.characters(number: 5) }
    content { Faker::Lorem.characters(number: 20) }
    image { Refile::FileDouble.new("dummy", "logo.png", content_type: "image/png") }
    user
  end
end
