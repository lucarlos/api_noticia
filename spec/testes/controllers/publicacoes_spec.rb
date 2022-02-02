require 'rails_helper'

RSpec.describe 'Request Publicações', type: :request do
  describe 'GET /api/v1/publicacoes INDEX' do
    context 'Quando não existem dados salvos' do
      it 'Retorna o array de Resultados vazio' do
        get '/api/v1/publicacoes'

        expect_json(resultados: [])
        expect(response).to have_http_status(200)
      end
    end

    context 'Quando existem dados salvos' do
      it 'Retorna todos os dados como json' do
        5.times do
          FactoryBot.create(:publicacoes_categorias)
        end

        get '/api/v1/publicacoes'

        expect_json_keys('resultados.*', %i[id titulo subtitulo conteudo url_imagem_principal data_criacao])
        expect_json_keys('resultados.*.categorias.*', %i[id nome])
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /api/v1/publicacoes/:id SHOW' do
    context 'Quando não existe a publicacao buscada' do
      it 'retorna erro 404' do
        get "/api/v1/publicacoes/#{0}"

        expect(response).to have_http_status(404)
      end
    end

    context 'Quando existe a publicação buscada' do
      it 'retorna os dados da publicacao' do
        publicacao = FactoryBot.create(:publicacoes_categorias).publicacao
        get "/api/v1/publicacoes/#{publicacao.id}"

        expect_json(id: publicacao.id, titulo: publicacao.titulo, subtitulo: publicacao.subtitulo,
                    url_imagem_principal: publicacao.url_imagem_principal)
        
        publicacao.categorias.each do |categoria|
          expect_json(categorias: [id: categoria.id, nome: categoria.nome])
        end
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /api/v1/publicacoes CREATE' do
    context 'Quando passa dados inválidos' do
      context 'Quando o titulo e subtitulo é vazio' do
        it 'retorna erro 422 e não salva a publicacao' do
          expect do
            post '/api/v1/publicacoes', params: { titulo: '', subtitulo: '' }
          end.to_not change { ApiNoticia::Models::Publicacao.count }
          expect(response).to have_http_status(422)
        end
      end

      context 'Quando o conteudo e url_imagem_principal é vazio' do
        it 'retorna erro 422 e não salva a publicacao' do
          expect do
            post '/api/v1/publicacoes', params: { conteudo: '', url_imagem_principal: '' }
          end.to_not change { ApiNoticia::Models::Publicacao.count }
  
          expect(response).to have_http_status(422)
        end
      end
    end

    context 'Quando passa dados válidos' do
      it 'Salva publicação e retorna o objeto e status 201' do
        categoria = FactoryBot.create(:categorias)
        
        attributes_publicacao = FactoryBot.attributes_for(:publicacoes, url_imagem_principal: '')
        attributes_publicacao[:file_imagem] = Rack::Test::UploadedFile.new('/noticia/spec/testes/imagens/imagem-teste.jpg')
        attributes_publicacao[:publicacoes_categorias_attributes] = [{ categoria_id: categoria.id }]

        expect do
          post '/api/v1/publicacoes', params: attributes_publicacao
        end.to change { ApiNoticia::Models::Publicacao.count }.by(1)

        publicacao = ApiNoticia::Models::Publicacao.last
        expect_json(id: publicacao.id, titulo: publicacao.titulo, subtitulo: publicacao.subtitulo, url_imagem_principal: publicacao.url_imagem_principal)                
        publicacao.categorias.each do |categoria|
          expect_json(categorias: [id: categoria.id, nome: categoria.nome])
        end
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT /api/v1/publicacoes/:id UPDATE' do
   
    context 'Quando passa dados inválidos' do
      context 'Quando passa o titulo e subtitulo em branco' do
        it 'Retorna erro 422 e não altera a publicação' do
          publicacao = FactoryBot.create(:publicacoes_categorias).publicacao
          put "/api/v1/publicacoes/#{publicacao.id}", params: { titulo: '', subtitulo: '' }          
          expect(response).to have_http_status(422)
        end
      end

      context 'Quando passa conteudo e url_imagem_principal em branco' do
        it 'Retorna erro 422 e não altera a publicação' do
          publicacao = FactoryBot.create(:publicacoes_categorias).publicacao
          put "/api/v1/publicacoes/#{publicacao.id}", params: { conteudo: '', url_imagem_principal: '' }
          expect(response).to have_http_status(422)
        end
      end
    end

    context 'Quando passa dados válidos' do
      it 'Retorna 200 e a publicacao com os dados atualizados' do
        publicacao = FactoryBot.create(:publicacoes_categorias).publicacao
        attributes_publicacao = 
          { 
            titulo: 'Novo Titulo',
            file_imagem: Rack::Test::UploadedFile.new('/noticia/spec/testes/imagens/imagem-teste.jpg')            
          }
        put "/api/v1/publicacoes/#{publicacao.id}", params: attributes_publicacao
        
        expect_json(id: publicacao.id, titulo: 'Novo Titulo', subtitulo: publicacao.subtitulo,
                    url_imagem_principal: "https://api-noticia-ruby-rails.s3.sa-east-1.amazonaws.com/api-noticia-publicacao-#{publicacao.id}.jpg")
        publicacao.categorias.each do |categoria|
          expect_json(categorias: [id: categoria.id, nome: categoria.nome])
        end
        expect(response).to have_http_status(200)
      end
    end

  end

  describe 'DELETE /api/v1/publicacoes/:id DESTROY' do
    context 'Quando passa um id inválido' do
      it 'Retorna erro 404' do
        delete "/api/v1/publicacoes/#{0}"
        expect(response).to have_http_status(404)
      end
    end

    context 'Quando passa um id válido' do
      it 'Exclui a publicacao e retorna 200' do
        publicacao = FactoryBot.create(:publicacoes_categorias).publicacao
        expect do
          delete "/api/v1/publicacoes/#{publicacao.id}"
        end.to change { ApiNoticia::Models::Publicacao.count }.by(-1)
      end
    end
  end

end
