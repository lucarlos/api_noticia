json.resultados @publicacoes do |publicacao|
  json.call(publicacao, :id, :titulo, :subtitulo, :conteudo, :url_imagem_principal, :data_criacao)
  json.categorias publicacao.categorias.each do |categoria|
    json.call(categoria, :id, :nome)
  end
end