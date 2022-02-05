require 'rails_helper'

RSpec.describe ApiNoticia::Models::Usuario, type: :model do
  context 'Validations' do
    subject { FactoryBot.create(:usuarios) }
    it { should validate_presence_of(:nome) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }

    it { should validate_uniqueness_of(:nome).ignoring_case_sensitivity }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  context 'Callbacks' do
    it 'Retira espaços em branco ao salvar categoria' do
      usuario = FactoryBot.build(:usuarios)
      usuario.nome = ' Curiosidades AA        '
      usuario.save
      expect(usuario.nome).to eq('Curiosidades AA')
    end
  end
end
