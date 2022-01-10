require 'open_api'

Rails.application.reloader.to_prepare do
  OpenApi::Config.class_eval do
    # Part 1: configs of this gem
    self.file_output_path = 'public/api/open_api'

    # Part 2: config (DSL) for generating OpenApi info
    open_api :index, base_doc_classes: [
      Api::V1::CategoriasDoc
    ]
    info version: '1.0.0', title: 'Noticia API'#, description: ..
    # server 'http://localhost:3000', desc: 'Internal staging server for testing'
    # bearer_auth :Authorization
  end
end