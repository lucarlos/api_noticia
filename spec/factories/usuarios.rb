FactoryBot.define do
  factory :usuarios, class: 'ApiNoticia::Models::Usuario' do
    nome { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    cargo { 0 }
    biografia { Faker::Lorem.sentence }
    ativo { true }
  end
end
