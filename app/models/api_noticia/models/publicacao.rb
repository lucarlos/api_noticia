# frozen_string_literal: true

module ApiNoticia
  module Models
    class Publicacao < ApplicationRecord
      self.table_name = 'publicacoes'

      include Concerns::Publicacao::Associations
      include Concerns::Publicacao::Callbacks
      include Concerns::Publicacao::Methods
      include Concerns::Publicacao::Scopes
      include Concerns::Publicacao::Validations
    end
  end
end
