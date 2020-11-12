FactoryBot.define do
  factory :user do
    first_name { "João" }
    last_name { "da Silva" }
    email { "joao@email.com" }
    password { "12345678" }
    password_confirmation { "12345678" }
    role { "user" }
  end
end
