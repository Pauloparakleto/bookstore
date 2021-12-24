FactoryBot.define do
  factory :author do
    first_name { Faker::GreekPhilosophers.name }
    last_name { Faker::Name.last_name }
  end
end
