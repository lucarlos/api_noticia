module ApiNoticia  
  module Models
    class Categoria < ApplicationRecord
      self.table_name = 'categorias'

      include Concerns::Categoria::Associations
      include Concerns::Categoria::Callbacks
      include Concerns::Categoria::Methods
      include Concerns::Categoria::Scopes
      include Concerns::Categoria::Validations
    end
  end
end