module ApiNoticia  
  module Models
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
      has_secure_password
    end
  end
end