# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_12_111406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categorias", comment: "Tabela de categorias de notícias", force: :cascade do |t|
    t.string "nome", null: false, comment: "Nome identificador da categoria"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["nome"], name: "index_categorias_on_nome", unique: true, comment: "Index para buscar categorias por nome"
  end

  create_table "publicacoes", comment: "Tabela de publicações de notícias", force: :cascade do |t|
    t.string "titulo", null: false, comment: "Título da publicação"
    t.string "subtitulo", null: false, comment: "Subtílo da publicação"
    t.text "conteudo", null: false, comment: "Conteúdo da publicação"
    t.string "url_imagem_principal", null: false, comment: "Url da imagem da publicação salva no aws"
    t.datetime "data_criacao", precision: 6, null: false, comment: "Data de criação da publicação"
    
  create_table "usuarios", comment: "Pessoa que acessará a aplicação", force: :cascade do |t|
    t.string "nome", null: false, comment: "Nome do usuário"
    t.string "email", null: false, comment: "Email do usuário"
    t.string "password_digest", null: false, comment: "Senha para acesso a conta"
    t.text "biografia", comment: "Comentário que aborda as características e interesses do usuário"
    t.integer "cargo", default: 0, null: false, comment: "Cargo atribuído ao usuário"
    t.boolean "ativo", default: true, null: false, comment: "Verifica se usuário está ou não com a conta ativa"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

<<<<<<< HEAD
  create_table "publicacoes_categorias", comment: "Tabela de associação de muitos para muitos entre publicações e categorias", force: :cascade do |t|
    t.bigint "categoria_id", null: false, comment: "Id da categoria"
    t.bigint "publicacao_id", null: false, comment: "Id da publicação"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["categoria_id"], name: "index_publicacoes_categorias_on_categoria_id"
    t.index ["publicacao_id"], name: "index_publicacoes_categorias_on_publicacao_id"
  end

  add_foreign_key "publicacoes_categorias", "categorias"
  add_foreign_key "publicacoes_categorias", "publicacoes"
=======
>>>>>>> origin/autenticacao
end
