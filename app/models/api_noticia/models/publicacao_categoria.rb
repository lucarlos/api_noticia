module ApiNoticia
  module Models
    class PublicacaoCategoria < ApplicationRecord
        self.table_name = 'publicacoes_categorias'

        include Concerns::PublicacaoCategoria::Associations
        include Concerns::PublicacaoCategoria::Callbacks
        include Concerns::PublicacaoCategoria::Methods
        include Concerns::PublicacaoCategoria::Scopes
        include Concerns::PublicacaoCategoria::Validations
    end
  end    
end