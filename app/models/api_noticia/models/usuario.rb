module ApiNoticia
  module Models
    class Usuario < ApplicationRecord
      self.table_name = 'usuarios'
      has_secure_password

      include ApiNoticia::Concerns::Usuario::Associations
      include ApiNoticia::Concerns::Usuario::Callbacks
      include ApiNoticia::Concerns::Usuario::Methods
      include ApiNoticia::Concerns::Usuario::Scopes
      include ApiNoticia::Concerns::Usuario::Validations
    end
  end
end
