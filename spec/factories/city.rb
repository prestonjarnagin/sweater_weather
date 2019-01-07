FactoryBot.define do
  factory :city do
    sequence(:name)     { |n| "#{Faker::Address.city}, #{Faker::Address.state_abbr}" }
    created_at           { Time.now }
    updated_at           { Time.now }
  end
end
