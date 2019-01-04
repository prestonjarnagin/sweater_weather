FactoryBot.define do
  factory :user do
    sequence(:email)     { |n| "user#{n}@mail.com" }
    sequence(:password)  { |n| "password#{n}" }
    created_at           { Time.now }
    updated_at           { Time.now }
    key                 { SecureRandom.urlsafe_base64 }
  end
end
