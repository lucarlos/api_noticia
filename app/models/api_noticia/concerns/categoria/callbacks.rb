module ApiNoticia
  module Concerns
    module Categoria
      module Callbacks
        extend ActiveSupport::Concern

        included do
          before_validation :strip_nome
        end

        private
        def strip_nome
          self.nome = nome&.strip
        end
      end
    end
  end
end
