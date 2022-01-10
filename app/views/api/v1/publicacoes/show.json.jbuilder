json.call(@publicacao, :titulo, :subtitulo, :conteudo, :imagem_principal)
json.categorias @publicacao.categorias.each do |categoria|
  json.call(categoria, :id, :nome)
end