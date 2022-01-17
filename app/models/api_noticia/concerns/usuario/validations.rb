module ApiNoticia
  module Concerns
    module Usuario
      module Validations
        extend ActiveSupport::Concern

        included do
          validates :nome, presence: true, uniqueness: { case_sensitive: false }
          validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
          validates :password, presence: true
        end
      end
    end
  end
end