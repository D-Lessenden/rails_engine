FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status { "success" }
    created_at { "2012-03-27 15:54:09" }
    updated_at { "2012-03-27 15:54:09" }
  end
end
