json.resultados @categorias do |categoria|
    json.call(categoria, :id, :nome)
end