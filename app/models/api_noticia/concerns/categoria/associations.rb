module ApiNoticia
  module Concerns
    module Categoria
      module Associations
        extend ActiveSupport::Concern

        included do
          # has_many :publicacoes_categorias
          has_many :publicacoes_categorias, class_name: 'ApiNoticia::Models::PublicacaoCategoria',
                                            foreign_key: :categoria_id, inverse_of: :categoria
        end
      end
    end
  end
end
