FactoryBot.define do
  # factory :user do
  #   email  {"a@a"}
  #   name {"佐藤"}
  #   introduction {"よろしくです"}
  #   password {111111}
  #   password_confirmation {111111}
  # end
  factory :user do
    name { Faker::Lorem.characters(number:10) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number:20) }
    password { '111111' }
    password_confirmation { '111111' }
  end
end
