FactoryBot.define do
  factory :author do
    first_name { Faker::Book.author.first }
    last_name { Faker::Book.author.last }
  end
end
