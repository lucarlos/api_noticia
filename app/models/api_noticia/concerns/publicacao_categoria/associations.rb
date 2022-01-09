module ApiNoticia
  module Concerns
    module PublicacaoCategoria
      module Associations
        extend ActiveSupport::Concern

        included do
          belongs_to :categoria, inverse_of: :publicacoes_categorias, class_name: 'ApiNoticia::Models::Categoria',
                                 foreign_key: :categoria_id
          belongs_to :publicacao, inverse_of: :publicacoes_categorias, class_name: 'ApiNoticia::Models::Publicacao', 
                                  foreign_key: :publicacao_id
        end
      end
    end
  end
end
