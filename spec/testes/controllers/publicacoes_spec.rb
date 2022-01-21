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

        expect_json_keys('resultados.*', %i[id titulo subtitulo conteudo url_imagem_principal created_at])
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
        publicacao = (FactoryBot.create(:publicacoes_categorias)).publicacao
        
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

  describe 'POST /api/v1/categorias CREATE' do
  end

  describe 'PUT /api/v1/categorias/:id UPDATE' do
  end

  describe 'DELETE /api/v1/categorias/:id DESTROY' do
  end

end
