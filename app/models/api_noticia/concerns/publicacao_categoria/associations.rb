module ApiNoticia
  module Concerns
    module PublicacaoCategoria
      module Associations
        extend ActiveSupport::Concern

        included do
          belongs_to :categoria, inverse_of: :publicacoes_categorias, class_name: 'ApiNoticia::Models::Categoria'
          belongs_to :publicacao, inverse_of: :publicacoes_categorias, class_name: 'ApiNoticia::Models::Publicacao'
        end
      end
    end
  end
end
