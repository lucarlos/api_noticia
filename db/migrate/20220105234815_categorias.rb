class Categorias < ActiveRecord::Migration[7.0]
  def up
    create_table :categorias, comment: 'Tabela de categorias de notícias' do |t|
      t.string :nome, null: false, comment: 'Nome identificador da categoria'
      t.timestamps
    end

    add_index :categorias, :nome, unique: true, comment: 'Index para buscar categorias por nome'
  end
end
