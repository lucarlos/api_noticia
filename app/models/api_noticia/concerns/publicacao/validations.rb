module ApiNoticia
  module Concerns
    module Publicacao
      module Validations
        extend ActiveSupport::Concern

        included do
          validates :titulo, :subtitulo, :conteudo, presence: true
        end
      end
    end
  end
end