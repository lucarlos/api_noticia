class CreatePublicacoesCategorias < ActiveRecord::Migration[7.0]
  def change
    create_table :publicacoes_categorias, comment: 'Tabela de associação de muitos para muitos entre publicações e categorias' do |t|
      t.references :categoria, null: false, foreign_key: { to_table: :categorias }, comment: 'Id da categoria'
      t.references :publicacao, null: false, foreign_key: { to_table: :publicacoes }, comment: 'Id da publicação'
      t.timestamps
    end
  end
end
