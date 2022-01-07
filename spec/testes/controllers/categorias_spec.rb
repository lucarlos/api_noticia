require 'rails_helper'

RSpec.describe 'Request Categorias', type: :request do
  describe 'GET /api/v1/categorias INDEX' do
    context 'Quando não existem dados salvos' do
      it 'Retorna o array de Resultados vazio' do
        get '/api/v1/categorias'

        expect_json(resultados: [])
        expect(response).to have_http_status(200)
      end
    end

    context 'Quando existem dados salvos' do
      it 'Retorna todos os dados como json' do
        FactoryBot.create(:categorias)
        get '/api/v1/categorias'

        expect_json_keys('resultados.*', %i[id nome])
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /api/v1/categorias/:id SHOW' do
    context 'Quando não existe a categoria buscada' do
      it 'retorna erro 404' do
        get "/api/v1/categorias/#{0}"
        
        expect(response).to have_http_status(404)
      end
    end

    context 'Quando existe a categoria buscada' do
      it 'retorna os dados da categoria' do
        categoria = FactoryBot.create(:categorias)
        get "/api/v1/categorias/#{categoria.id}"
        
        expect_json(id: categoria.id, nome: categoria.nome)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /api/v1/categorias CREATE' do
    context 'Quando passa dados inválidos' do
      context 'Quando o nome é vazio' do
        it 'retorna erro 422 e não salva a categoria' do
          expect do
            post '/api/v1/categorias', params: { nome: '' }
          end.to_not change { ApiNoticia::Models::Categoria.count }

          expect(response).to have_http_status(422)
        end
      end

      context 'Quando o nome já existe' do
        it 'Retorna erro 422 e não salva a categoria' do
          categoria = FactoryBot.create(:categorias)
          expect do
            post '/api/v1/categorias', params: { nome: categoria.nome }
          end.to_not change { ApiNoticia::Models::Categoria.count }

          expect(response).to have_http_status(422)
        end
      end
    end

    context 'Quando passa dados válidos' do
      it 'Salva categoria e retorna 201' do
        expect do
          post '/api/v1/categorias', params: { nome: 'analise' }
        end.to change { ApiNoticia::Models::Categoria.count }.by(1)

        expect_json_keys(%i[id nome])
        expect_json(nome: 'analise')
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT /api/v1/categorias/:id UPDATE' do
    context 'Quando passa dados inválidos' do
      context 'Quando atualiza o nome para algum que já existe' do
        it 'Retorna erro 422 e não altera a categoria' do
          categoria_1 = FactoryBot.create(:categorias)
          categoria_2 = FactoryBot.create(:categorias)
          put "/api/v1/categorias/#{categoria_2.id}", params: { nome: categoria_1.nome }

          expect(response).to have_http_status(422)
        end
      end

      context 'Quando atualiza o nome para vazio' do
        it 'Retorna erro 422 e não altera a categoria' do
          categoria = FactoryBot.create(:categorias)
          put "/api/v1/categorias/#{categoria.id}", params: { nome: '' }

          expect(response).to have_http_status(422)
        end
      end
    end

    context 'Quando passa dados válidos' do
      it 'Atualiza a categoria e retorna os dados' do
        categoria = FactoryBot.create(:categorias)
        put "/api/v1/categorias/#{categoria.id}", params: { nome: 'alterado' }

        expect_json_keys(%i[id nome])
        expect_json(nome: 'alterado')
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /api/v1/categorias/:id DESTROY' do
    context 'Quando passa um id inválido' do
      it 'Retorna erro 404' do
        delete "/api/v1/categorias/#{0}"
        expect(response).to have_http_status(404)
      end
    end

    context 'Quando passa um id válido' do
      it 'Exclui a categoria e retorna 200' do
        categoria = FactoryBot.create(:categorias)
        expect do
          delete "/api/v1/categorias/#{categoria.id}"
        end.to change { ApiNoticia::Models::Categoria.count }.by(-1)
      end
    end
  end
end
