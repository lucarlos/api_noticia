module ApiNoticia
  module Concerns
    module Categoria
      module Associations
        extend ActiveSupport::Concern

        included do
          has_many :publicacoes_categorias, class_name: 'ApiNoticia::Models::PublicacaoCategoria'
          has_many :publicacoes, through: :publicacoes_categorias, class_name: 'ApiNoticia::Models::Publicacao'
        end
      end
    end
  end
end
