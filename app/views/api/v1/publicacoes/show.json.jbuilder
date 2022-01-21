json.call(@publicacao, :id, :titulo, :subtitulo, :url_imagem_principal, :data_criacao)
json.categorias @publicacao.categorias.each do |categoria|
  json.call(categoria, :id, :nome)
end