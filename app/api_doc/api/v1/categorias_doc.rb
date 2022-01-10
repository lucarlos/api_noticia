module Api
  module V1
    class CategoriasDoc < ApiDoc
      route_base 'api/v1/categorias'
      doc_tag name: 'Categorias', description: 'Categorias de uma publicação'

      api :index, 'GET categorias' do
        desc 'Lista todas as categorias cadastradas'

        response 200, 'success', :json, data: {
          resultados: [
            id: { type: 'integer', desc: 'Id da categoria' },
            nome: { type: 'string', desc: 'Nome da categoria' }
          ]
        }
      end

      api :show, 'GET categoria' do
        desc 'Mostra dados da categoria buscada'

        param :path, :id, Integer, :req, desc: 'Id da categoria'

        response 200, 'success', :json, data: {
          id: { type: 'integer', desc: 'Id da categoria' },
          nome: { type: 'string', desc: 'Nome da categoria' }
        }

        response 404, 'not found', :json, data: {
          mensagem: { type: 'string', desc: 'mensagem de erro' }
        }
      end

      api :create, 'POST categoria' do
        desc 'Cadastra categoria'

        request_body :required, :json, data: {
          nome: { type: 'string', desc: 'Nome da categoria' }
        }

        response 201, 'criado', :json, data: {
          id: { type: 'integer', desc: 'Id da categoria' },
          nome: { type: 'string', desc: 'Nome da categoria' }
        }

        response 422, 'unprocessable entity', :json, data: {
          mensagem: { type: 'string', desc: 'mensagem de erro' }
        }
      end

      api :update, 'PUT/PATCH categoria', http: 'put', id: :update_categorias_v1_put do
        desc 'Atualiza categoria'

        param :path, :id, Integer, :req, desc: 'Id da categoria'

        request_body :required, :json, data: {
          id: { type: 'integer', desc: 'Id da categoria' },
          nome: { type: 'string', desc: 'Nome da categoria' }
        }

        response 200, 'success', :json, data: {
          id: { type: 'integer', desc: 'Id da categoria' },
          nome: { type: 'string', desc: 'Nome da categoria' }
        }

        response 404, 'not found', :json, data: {
          mensagem: { type: 'string', desc: 'mensagem de erro' }
        }
      end

      api :update, 'PUT/PATCH categoria', http: 'patch', id: :update_categorias_v1_patch do
        desc 'Atualiza categoria'

        param :path, :id, Integer, :req, desc: 'Id da categoria'

        request_body :required, :json, data: {
          id: { type: 'integer', desc: 'Id da categoria' },
          nome: { type: 'string', desc: 'Nome da categoria' }
        }

        response 200, 'success', :json, data: {
          id: { type: 'integer', desc: 'Id da categoria' },
          nome: { type: 'string', desc: 'Nome da categoria' }
        }

        response 404, 'not found', :json, data: {
          mensagem: { type: 'string', desc: 'mensagem de erro' }
        }
      end

      api :destroy, 'DELETE categoria' do
        desc 'Exclui categoria'

        param :path, :id, Integer, :req, desc: 'Id da categoria'

        response 200, 'success'

        response 404, 'not found', :json, data: {
          mensagem: { type: 'string', desc: 'mensagem de erro' }
        }

        response 422, 'unprocessable entity', :json, data: {
          mensagem: { type: 'string', desc: 'mensagem de erro' }
        }
      end
    end
  end
end
