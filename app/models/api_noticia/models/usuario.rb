module ApiNoticia
  module Models
    class Usuario < ApplicationRecord
      has_secure_password
      self.table_name = 'usuarios'

      include ApiNoticia::Concerns::Usuario::Associations
      include ApiNoticia::Concerns::Usuario::Callbacks
      include ApiNoticia::Concerns::Usuario::Methods
      include ApiNoticia::Concerns::Usuario::Scopes
      include ApiNoticia::Concerns::Usuario::Validations
    end
  end
end
