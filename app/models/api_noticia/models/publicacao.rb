# frozen_string_literal: true

module ApiNoticia
  module Models
    class Publicacao < ApplicationRecord
      attr_accessor :file_imagem

      self.table_name = 'publicacoes'
      
      enum situacao: { em_analise: 0, aprovada: 1, desativada: 2 }

      include Concerns::Publicacao::Associations
      include Concerns::Publicacao::Callbacks
      include Concerns::Publicacao::Methods
      include Concerns::Publicacao::Scopes
      include Concerns::Publicacao::Validations
    end
  end
end
