module ApiNoticia
  module Concerns
    module Publicacao
      module Validations
        extend ActiveSupport::Concern

        included do
          validates :titulo, :subtitulo, :conteudo, :url_imagem_principal, presence: true
        end
      end
    end
  end
end