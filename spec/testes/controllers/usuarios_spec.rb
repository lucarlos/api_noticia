require 'rails_helper'

def gerar_token
  @usuario_token = FactoryBot.create(:usuarios)
  JsonWebToken.encode(user_id: @usuario_token.id)
end

RSpec.describe 'Request de Usuários', type: :request do
  describe 'GET /api/v1/usuarios/:id SHOW' do
    before(:each) do
      @token = gerar_token
      @usuario = FactoryBot.create(:usuarios)
    end

    context 'Quando não está autenticado' do
      it 'Retorna erro 401' do
        get "/api/v1/usuarios/#{@usuario.id}", headers: {}

        expect(response).to have_http_status(401)
      end
    end

    context 'Quando está autenticado' do
      context 'Quando id não existe' do
        it 'Retorna erro 404' do
          get '/api/v1/usuarios/0', headers: { "Authorization": @token.to_s }

          expect(response).to have_http_status(404)
        end
      end

      context 'Quando id existe' do
        context 'Quando não tem permissão' do
          it 'Retorna erro 403' do
            novo_usuario_token = FactoryBot.create(:usuarios)

            novo_token = JsonWebToken.encode(user_id: novo_usuario_token.id)

            get "/api/v1/usuarios/#{@usuario.id}", headers: { "Authorization": novo_token }

            expect(response).to have_http_status(403)

            expect(novo_usuario_token.id).to_not eq(@usuario.id)
          end
        end

        context 'Quando tem permissão' do
          it 'Retorna o dado buscado' do
            get "/api/v1/usuarios/#{@usuario_token.id}", headers: { "Authorization": @token.to_s }

            expect(response).to have_http_status(200)
            expect_json_keys(%i[id nome email cargo ativo biografia])
          end
        end
      end
    end
  end

  describe 'POST /api/v1/usuarios CREATE' do
    context 'Quando passa dados válidos' do
      it 'Cadastra usuário e retorna status 200' do
        usuario = FactoryBot.attributes_for(:usuarios)
        post '/api/v1/usuarios', params: usuario

        expect(response).to have_http_status(200)
        expect_json(nome: usuario[:nome], email: usuario[:email], cargo: usuario[:cargo],
                    ativo: usuario[:ativo], biografia: usuario[:biografia])
      end
    end

    context 'Quando passa dados inválidos' do
      it 'Retorna erro 422' do
        usuario_1 = FactoryBot.create(:usuarios)
        usuario_2 = FactoryBot.attributes_for(:usuarios, nome: usuario_1.nome)
        post '/api/v1/usuarios', params: usuario_2

        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT api/v1/usuarios/:id UPDATE' do
    before(:each) do
      @token = gerar_token
      @usuario = FactoryBot.create(:usuarios)
    end
    context 'Quando não está autenticado' do
      it ' Retorna erro 401' do
        put "/api/v1/usuarios/#{@usuario_token.id}", params: { nome: 'teste' }

        expect(response).to have_http_status(401)
      end
    end

    context 'Quando está autenticado' do
      context 'Quando não tem permissao' do
        it 'retorna erro 403' do
          novo_token = JsonWebToken.encode(user_id: @usuario.id)
          put "/api/v1/usuarios/#{@usuario_token.id}", params: { nome: 'teste' },
                                                      headers: { "Authorization": novo_token.to_s }

          expect(response).to have_http_status(403)
        end
      end

      context 'Quando tem permissao' do
        context 'Quando envia dados inválidos' do
          it 'Retorna erro 422' do
            put "/api/v1/usuarios/#{@usuario_token.id}", params: { email: "teste" },
                                                        headers: { "Authorization": @token.to_s }

            expect(response).to have_http_status(422)
          end
        end

        context 'Quando envia dados válidos' do
          it 'Retorna os dados alterados' do
            put "/api/v1/usuarios/#{@usuario_token.id}", params: { nome: 'novo nome' },
                                                        headers: { "Authorization": @token.to_s }

            expect(response).to have_http_status(200)
          end
        end
      end
    end
  end

  describe 'DELETE api/v1/usuarios/:id DESTROY' do
    before(:each) do
      @token = gerar_token
      @usuario = FactoryBot.create(:usuarios)
    end
    context 'Quando não está autenticado' do
      it 'Retorna erro 401' do
        usuario = FactoryBot.create(:usuarios)
        delete "/api/v1/usuarios/#{usuario.id}"

        expect(response).to have_http_status(401)
      end
    end

    context 'Quando está autenticado' do
      context 'Quando não tem permissão' do
        it 'Retorna erra 403' do
          usuario = FactoryBot.create(:usuarios)
          delete "/api/v1/usuarios/#{usuario.id}", headers: { 'Authorization': @token.to_s }

          expect(response).to have_http_status(403)
        end
      end

      context 'Quando tem permissão' do
        context 'Quando passa ID que não existe' do
          it 'Retorna erro 404' do
            delete "/api/v1/usuarios/#{0}", headers: { 'Authorization': @token.to_s }

            expect(response).to have_http_status(404)
          end
        end

        context 'Quando passa id existente' do
          it 'Retorna status 200' do
            usuario = FactoryBot.create(:usuarios)
            novo_token = JsonWebToken.encode(user_id: usuario.id)
            delete "/api/v1/usuarios/#{usuario.id}", headers: { 'Authorization': novo_token.to_s }

            expect(response).to have_http_status(200)
          end
        end
      end
    end
  end
end
