FactoryBot.define do
  # factory :post do
  #   user_id {1}
  #   title  {"グルメツアー"}
  #   body {"カニ食べ放題"}
  # end
  factory :post do
    title { Faker::Lorem.characters(number:5) }
    body { Faker::Lorem.characters(number:20) }
    user
  end
end
