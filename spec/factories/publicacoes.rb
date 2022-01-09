FactoryBot.define do
  factory :publicacoes, class: 'ApiNoticia::Models::Publicacao' do   
    titulo { Faker::Name.name }
    subtitulo { Faker::Name.name }
    conteudo { Faker::Lorem.characters(number: 1000) }
    imagem_principal { Faker::Internet.domain_name + '.jpg' }
  end
end