FactoryBot.define do
  factory :publicacoes_categorias, class: 'ApiNoticia::Models::PublicacaoCategoria' do
    association :categoria, factory: 'categorias'
    association :publicacao, factory: 'publicacoes'
  end
end