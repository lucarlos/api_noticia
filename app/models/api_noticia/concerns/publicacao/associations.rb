module ApiNoticia
  module Concerns
    module Publicacao
      module Associations
        extend ActiveSupport::Concern

        included do
          has_many :publicacoes_categorias
          has_many :categorias, through: :publicacoes_categorias, class_name: 'ApiNoticia::Models::Categoria'

          accepts_nested_attributes_for :publicacoes_categorias
        end
      end
    end
  end
end