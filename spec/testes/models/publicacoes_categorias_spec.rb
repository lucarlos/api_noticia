require 'rails_helper'

RSpec.describe ApiNoticia::Models::PublicacaoCategoria, type: :model do
  describe 'Associations' do
    it { should belong_to(:categoria).class_name('ApiNoticia::Models::Categoria') }
    it { should belong_to(:publicacao).class_name('ApiNoticia::Models::Publicacao') }
  end
end