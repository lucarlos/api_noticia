module ApiNoticia
  module Concerns
    module Publicacao
      module Callbacks
        extend ActiveSupport::Concern

        included do
          before_validation :strip_titulo, :strip_subtitulo
        end

        private

        def strip_titulo
          self.titulo =  titulo&.strip
        end

        def strip_subtitulo
          self.subtitulo = subtitulo&.strip
        end
      end
    end
  end
end
