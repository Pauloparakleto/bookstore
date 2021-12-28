FactoryBot.define do
  factory :order do
    user_id { 1 }
    total_price { 1.5 }
  end
end
