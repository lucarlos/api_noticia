class CreateUsuario < ActiveRecord::Migration[7.0]
  def up
    create_table :usuarios, comment: 'Pessoa que acessará a aplicação' do |t|
      t.string :nome, null: false, comment: 'Nome do usuário' 
      t.string :email, null: false, comment: 'Email do usuário'
      t.string :password_digest, null: false, comment: 'Senha para acesso a conta'
      t.text :biografia, comment: 'Comentário que aborda as características e interesses do usuário'
      t.boolean :ativo, default: true, null: false, comment: 'Verifica se usuário está ou não com a conta ativa'

      t.timestamps
    end
  end
end
