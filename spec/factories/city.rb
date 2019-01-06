FactoryBot.define do
  factory :city do
    sequence(:name)     { |n| "City #{n}, ST" }
    created_at           { Time.now }
    updated_at           { Time.now }
  end
end
