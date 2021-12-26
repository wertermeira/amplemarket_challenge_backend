FactoryBot.define do
  factory :template do
    name { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end
end
