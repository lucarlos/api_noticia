FactoryBot.define do
  factory :categorias, class: "ApiNoticia::Models::Categoria" do
    nome { Faker::Name.first_name }
  end
end
