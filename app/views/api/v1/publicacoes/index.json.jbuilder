json.resultados @publicacoes do |publicacao|
  json.call(publicacao, :id, :titulo, :subtitulo, :conteudo, :imagem_principal, :created_at)
  json.categorias publicacao.categorias.each do |categoria|
    json.call(categoria, :id, :nome)
  end
end