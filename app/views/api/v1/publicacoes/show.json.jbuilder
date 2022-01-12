json.call(@publicacao, :id, :titulo, :subtitulo, :url_imagem_principal, :created_at, :file_imagem)
json.categorias @publicacao.categorias.each do |categoria|
  json.call(categoria, :id, :nome)
end