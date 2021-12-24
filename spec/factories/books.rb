FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    price { Faker::Number.decimal }
    quantity { Faker::Number.number }
  end
end
