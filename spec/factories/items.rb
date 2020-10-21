FactoryBot.define do
  factory :item do
    name { "Banana Stand" }
    description { "There's always money in the banana stand." }
    unit_price { Faker::Number.decimal(l_digits: (Faker::Number.within(range: 1..10)), r_digits: 2 ) }
    merchant
  end
end
