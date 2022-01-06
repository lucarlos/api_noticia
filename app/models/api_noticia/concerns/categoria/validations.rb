module ApiNoticia
  module Concerns
    module Categoria
      module Validations
        extend ActiveSupport::Concern

        included do
          validates :nome, presence: true, uniqueness: { case_sensitive: false }
        end
      end
    end
  end
end