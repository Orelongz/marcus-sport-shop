FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    factory :admin_user do
      role { :admin }
    end
  end
end
