class CreatePublicacoes < ActiveRecord::Migration[7.0]
  def change
    create_table :publicacoes do |t|
      t.string :titulo, null: false
      t.string :subtitulo, null: false
      t.text :conteudo, null: false
      t.string :imagem_principal, null: false
      
      t.timestamps
    end
  end
end
