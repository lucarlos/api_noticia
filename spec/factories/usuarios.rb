FactoryBot.define do
  factory :usuarios, class: 'ApiNoticia::Models::Usuario' do
    nome { Faker::Name.first_name }
    email { Faker::Internet.email }
    password_digest { Faker::Number.number(digits: 6) }
  end
end
