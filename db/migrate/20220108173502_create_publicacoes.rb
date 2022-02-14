class CreatePublicacoes < ActiveRecord::Migration[7.0]
  def change
    create_table :publicacoes, comment: 'Tabela de publicações de notícias' do |t|
      t.string :titulo, null: false, comment: 'Título da publicação'
      t.string :subtitulo, null: false, comment: 'Subtílo da publicação'
      t.text :conteudo, null: false, comment: 'Conteúdo da publicação'
      t.string :url_imagem_principal, null: false, comment: 'Url da imagem da publicação salva no aws'
      t.datetime :data_criacao, null: false, comment: 'Data de criação da publicação'
      t.integer :situacao, null: false, default: 0, comment: 'Situação da publicação'
      t.timestamps
    end
  end
end
