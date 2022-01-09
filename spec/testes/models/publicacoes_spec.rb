require 'rails_helper'

RSpec.describe ApiNoticia::Models::Publicacao, type: :model do
  describe 'Validation' do
    subject { FactoryBot.create(:publicacoes) }
    it {
      should validate_presence_of(:titulo)
      should validate_presence_of(:subtitulo)
      should validate_presence_of(:conteudo)
      should validate_presence_of(:imagem_principal)
    }
  end

  describe 'Callbacks' do
    context 'strip_titulo' do
      it 'Retira espaços em branco do titulo' do
        publicacao = FactoryBot.build(:publicacoes)
        titulo = '  Novo MMORPG será lançando de 2022    '
        publicacao.titulo = titulo
        publicacao.save
        expect(publicacao.titulo).to eq(titulo.strip)
      end
    end

    context 'strip_subtitulo' do
      it 'Retira espaços em branco do subtitulo' do
        publicacao = FactoryBot.build(:publicacoes)
        subtitulo = '  BlueProtocol chegará em fevereiro de 2022    '
        publicacao.subtitulo = subtitulo
        publicacao.save
        expect(publicacao.subtitulo).to eq(subtitulo.strip)
      end
    end
  end

  describe 'Associations' do
    it { should have_many(:publicacoes_categorias).class_name('ApiNoticia::Models::PublicacaoCategoria') }
    it { should have_many(:categorias).through(:publicacoes_categorias).class_name('ApiNoticia::Models::Categoria') }
    it { should accept_nested_attributes_for(:publicacoes_categorias).allow_destroy(true) }
  end
end