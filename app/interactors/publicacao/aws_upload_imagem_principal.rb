module Publicacao
    class AwsUploadImagemPrincipal
      include Interactor
      include Interactor::Contracts
  
      expects do
        required(:arquivo_imagem).filled
        required(:id_publicacao).filled
      end
  
      on_breach do |breaches|
        mensagem = []
        breaches.each do |breach|
          mensagem << breach.messages
        end
        context.fail!(mensagem: mensagem.join(', '))
      end
  
      def call
        if start_aws_upload_image
          context.response_aws = start_aws_upload_image
        else
          context.response_aws = start_aws_upload_image        
        end          
      end

      def enviar_imagem?(object_aws, nome_bucket, nome_imagem, arquivo_imagem)
        response = object_aws.put_object(
          bucket: nome_bucket,
          key: nome_imagem,
          body: arquivo_imagem
        )
        if response.etag
          return "https://api-noticia-ruby-rails.s3.sa-east-1.amazonaws.com/#{nome_imagem}"
        else
          return false
        end
      end
      
      def start_aws_upload_image
        nome_bucket = 'api-noticia-ruby-rails'
        nome_imagem = mudar_nome_imagem
        arquivo_imagem = context.arquivo_imagem.tempfile
        regiao_bucket = 'sa-east-1'

        # Aws.config = hash

        object_aws = Aws::S3::Client.new(region: regiao_bucket)
        enviar_imagem?(object_aws, nome_bucket, nome_imagem, arquivo_imagem)   
      end

      def mudar_nome_imagem
        new_name_img = "api-noticia-publicacao-#{context.id_publicacao.to_s}"
      end
    end
end