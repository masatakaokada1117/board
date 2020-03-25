FactoryBot.define do
  factory :user do
    name { "hoge" }
    password { "password" }
    password_confirmation { "password" }

    trait :invalid do
      name { "ユーザー1" }
      password { "password" }
      password_confirmation { "invalid_password" }
    end
  end
end
