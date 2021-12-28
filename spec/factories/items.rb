FactoryBot.define do
  factory :item do
    order_id { 1 }
    name { Faker::Book.title }
    price { 1.5 }
    quantity { 2 }
  end
end
