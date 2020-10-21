FactoryBot.define do
  factory :invoice_item do
    item { nil }
    invoice { nil }
    quantity { 1 }
    unit_price { "MyString" }
    created_at { "" }
    updated_at { "MyString" }
  end
end
