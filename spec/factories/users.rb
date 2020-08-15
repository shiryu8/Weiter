FactoryBot.define do
  	factory :user do
        name {"akeru"}
        sequence(:email) { |n| "akeru#{n}@example.com"}
        password {"password"}
  	end
end
