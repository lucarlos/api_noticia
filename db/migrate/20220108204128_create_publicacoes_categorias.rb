class CreatePublicacoesCategorias < ActiveRecord::Migration[7.0]
  def change
    create_table :publicacoes_categorias do |t|
      t.references :categoria, null: false, foreign_key: { to_table: :categorias }
      t.references :publicacao, null: false, foreign_key: { to_table: :publicacoes }
      t.timestamps
    end
  end
end
