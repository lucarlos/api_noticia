json.resultados @usuarios do |usuario|
  json.call(usuario, :id, :nome)
end
