json.call(@publicacao, :id, :titulo, :subtitulo, :imagem_principal, :created_at)
json.categorias @publicacao.categorias.each do |categoria|
  json.call(categoria, :id, :nome)
end