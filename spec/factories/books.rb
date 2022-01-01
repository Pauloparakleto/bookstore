FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    price { Faker::Number.decimal }
    quantity { 10 }
    published { false }
  end
end
