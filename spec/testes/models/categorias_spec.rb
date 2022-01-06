require 'rails_helper'

RSpec.describe ApiNoticia::Models::Categoria, type: :model do
  context 'Validation' do
    subject { FactoryBot.create(:categorias) }
    it {
      should validate_presence_of(:nome)
    }
    it {
      should validate_uniqueness_of(:nome).ignoring_case_sensitivity
    }
  end

  context 'Callbacks' do
    it 'Retira espaços em branco ao salvar categoria' do
      categoria = FactoryBot.build(:categorias)
      categoria.nome = ' Curiosidades AA        '
      categoria.save
      expect(categoria.nome).to eq('Curiosidades AA')
    end
  end
end