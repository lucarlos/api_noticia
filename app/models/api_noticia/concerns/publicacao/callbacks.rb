module ApiNoticia
  module Concerns
    module Publicacao
      module Callbacks
        extend ActiveSupport::Concern

        included do
          before_validation :strip_titulo, :strip_subtitulo
          before_create :set_data_criacao
        end

        private

        def strip_titulo
          self.titulo =  titulo&.strip
        end

        def strip_subtitulo
          self.subtitulo = subtitulo&.strip
        end

        def set_data_criacao
          self.data_criacao = DateTime.current
        end
      end
    end
  end
end
