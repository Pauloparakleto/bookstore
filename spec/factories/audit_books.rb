FactoryBot.define do
  factory :audit_book do
    admin_id { 1 }
    book_id { 1 }
    title { Faker::Book.title }
    quantity { 1 }
    price { '9.99' }
    published { false }
  end
end
