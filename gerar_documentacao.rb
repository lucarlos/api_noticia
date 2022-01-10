File.delete('public/api/open_api/index.json') if File.exist?('public/api/open_api/index.json')
puts OpenApi.write_docs
